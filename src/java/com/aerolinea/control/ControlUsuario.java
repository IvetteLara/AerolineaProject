package com.aerolinea.control;

import com.aerolinea.dao.UsuarioDao;
import com.aerolinea.dao.UsuarioDaoImpl;
import com.aerolinea.entidad.Pais;
import com.aerolinea.entidad.Rol;
import com.aerolinea.entidad.Usuario;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;
import javax.faces.context.FacesContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.validation.ObjectError;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ControlUsuario {

    String BUNDLE_NAME = "com.aerolinea.config.message";  
    
    private UsuarioDaoImpl dao;

    @Autowired
    public void setDao(UsuarioDaoImpl dao) {
        this.dao = dao;
    }
 
        
    @RequestMapping("/login")
    public String logins(@RequestParam("txtUsuario")String usuario,
            @RequestParam("txtClave") String clave,
            HttpServletRequest req) {

        Usuario u = new Usuario();
        u.setIdusuario(usuario);
        u.setClave(clave);
        
        Usuario usuarioLogueado = dao.validarUsuario(u);
        
        if (usuarioLogueado != null) {
            req.getSession().setAttribute("usuario",
                    usuarioLogueado.getIdusuario());
            req.getSession().setAttribute("idrol",
                    usuarioLogueado.getRol().getIdrol());
            req.getSession().setAttribute("correo",
                    usuarioLogueado.getEmail());
            req.getSession().setAttribute("nombre",
                    usuarioLogueado.getNombres() + " " + usuarioLogueado.getApellidos());
            //req.getSession().setMaxInactiveInterval(10); // 10 segundos
            return "redirect:/principal";
        } else {
            //req.setAttribute("errMessage", "Error Login Incorrecto!");
            //return "index";
            return "redirect:/home?error=1";
        }
    }

    @RequestMapping(value = "/usuarios", method = GET)
    public ModelAndView ListaUsuarios() {
        ModelAndView mv = new ModelAndView("usuario");
        String msg = "Listado de usuarios";
        try {
            List<Usuario> lista = dao.consultarUsuarios();
            List<Usuario> listaBackup = dao.consultarUsuariosBackup();

            mv.addObject("usuarios", lista);
            mv.addObject("usuariosBackup", listaBackup);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        mv.addObject("mensaje", msg);

        return mv;
    }

    @RequestMapping(value = "/registrar", method = GET)
    public String mostrarFormRegistro(@RequestParam(value="id", required=false) String id, Map<String, Object> model) {
        Usuario userForm;
        
        try {
            if(id == null) {
                userForm = new Usuario();
            } else {
                userForm = dao.getUsuario(id);
                userForm.setClave2(userForm.getClave());
                userForm.setCambiarClave(false);        
            }

            model.put("userForm", userForm);
            
            List<Pais> p = dao.getPaises();
            List<Rol> r = dao.getRoles();
            model.put("paises", p);
            model.put("roles", r);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }        

        return "registrarse";
    }

    
    private ResourceBundle getBundle(HttpServletRequest req) {
        
        Cookie[] cookies = req.getCookies();

        String locale = "es";
        
        if (cookies != null) {
         for (Cookie cookie : cookies) {
           if (cookie.getName().equals("language")) {
             locale = cookie.getValue();
            }
          }
        }
        
        return ResourceBundle.getBundle(BUNDLE_NAME, new Locale(locale));
    }
    
    
    @RequestMapping(value = "/addUsuario", method
            = RequestMethod.POST)
    public String addUsuario(@Valid
            @ModelAttribute("userForm") Usuario u,
            BindingResult result, Map<String, Object> model,
            HttpServletRequest req) {
        

        ResourceBundle RESOURCE_BUNDLE = getBundle(req);

    
        if(u.getPais() == null || u.getPais().getIdpais() == 0) {
            result.addError(new ObjectError("pais.idpais", RESOURCE_BUNDLE.getString("usuario.pais.idpais")));
        }

        if(u.getRol() == null || u.getRol().getIdrol() == 0) {
            result.addError(new ObjectError("rol.idrol", RESOURCE_BUNDLE.getString("usuario.rol.idrol")));
        }
        
        if(!u.getClave().equals(u.getClave2())) {
            result.addError(new ObjectError("clave", RESOURCE_BUNDLE.getString("usuario.clave.igual")));
        }
        
        if (result.hasErrors()) {
            System.out.println("Este No Es Un Registro Válido!!!");
            List<Pais> p = dao.getPaises();
            List<Rol> r = dao.getRoles();
            model.put("paises", p);
            model.put("roles", r);
            return "registrarse";
        }
        
        try {
            if(u.isCambiarClave()) {
                u.setClave(UsuarioDaoImpl.sha1(u.getClave()));
            }
            dao.guardarUsuario(u);            
    
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return "redirect:/usuarios";
    }
    
    @RequestMapping(value = "/editar", method = RequestMethod.GET)
    public ModelAndView  editUsuario(@RequestParam("id") String id) {
        
        ModelAndView mv = new ModelAndView("registrarse");
        Usuario u = dao.getUsuario(id);
        List<Pais> p = dao.getPaises();
        List<Rol> r = dao.getRoles();

        u.setClave2(u.getClave());
        u.setCambiarClave(false);
        
        mv.addObject("userForm", u);
        mv.addObject("paises", p);
        mv.addObject("roles", r);        
        
        return mv;
    }
    
    @RequestMapping(value = "/remover", method = RequestMethod.GET)
    public String removeUsuario(@RequestParam("id") String id) {

        try {
            dao.EliminarUsuario(id);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return "redirect:/usuarios";
    }    
        
  
}
