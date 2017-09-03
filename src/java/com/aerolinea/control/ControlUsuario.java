package com.aerolinea.control;

import com.aerolinea.dao.UsuarioDao;
import com.aerolinea.dao.UsuarioDaoImpl;
import com.aerolinea.entidad.Pais;
import com.aerolinea.entidad.Rol;
import com.aerolinea.entidad.Usuario;
import java.util.List;
import java.util.Map;
import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import static org.springframework.web.bind.annotation.RequestMethod.GET;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class ControlUsuario {

    private UsuarioDao dao;

    @Autowired
    public void setDao(UsuarioDao dao) {
        this.dao = dao;
    }

    @RequestMapping("/login")
    public String logins(@RequestParam("txtUsuario") String usuario,
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
            return "redirect:/home";
        }
    }

    @RequestMapping(value = "/usuarios", method = GET)
    public ModelAndView ListaUsuarios() {
        ModelAndView mv = new ModelAndView("usuario");
        String msg = "Listado de usuarios";
        try {
            List<Usuario> lista = dao.consultarUsuarios();
            mv.addObject("usuarios", lista);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        mv.addObject("mensaje", msg);

        return mv;
    }

    @RequestMapping(value = "/registrar", method = GET)
    public String mostrarFormRegistro(Map<String, Object> model) {
        Usuario userForm = new Usuario();
        model.put("userForm", userForm);
        try {
            List<Pais> p = dao.getPaises();
            List<Rol> r = dao.getRoles();
            model.put("paises", p);
            model.put("roles", r);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }

        return "registrarse";
    }

    @RequestMapping(value = "/addUsuario", method
            = RequestMethod.POST)
    public String addUsuario(@Valid
            @ModelAttribute("userForm") Usuario u,
            BindingResult result) {

        if (result.hasErrors()) {
            return "registrarse";
        }
        try {
            u.setClave(UsuarioDaoImpl.sha1(u.getClave()));
            dao.guardarUsuario(u);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return "redirect:/usuarios";
    }
    
    @RequestMapping(value = "/editUsuario", method = RequestMethod.GET)
    public ModelAndView  editUsuario(@RequestParam("id") String id) {
        
        ModelAndView mv = new ModelAndView("registrarse");
        Usuario u = dao.getUsuario(id);
        List<Pais> p = dao.getPaises();
        List<Rol> r = dao.getRoles();

        mv.addObject("userForm", u);
        mv.addObject("paises", p);
        mv.addObject("roles", r);        
        
        return mv;
    }
    
    @RequestMapping(value = "/removeUsuario", method = RequestMethod.GET)
    public String removeUsuario(@RequestParam("id") String id) {

        try {
            dao.EliminarUsuario(id);
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        return "redirect:/usuarios";
    }    
}
