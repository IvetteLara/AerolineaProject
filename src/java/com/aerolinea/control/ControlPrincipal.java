package com.aerolinea.control;

import javax.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class ControlPrincipal {

    @RequestMapping("/principal")
    public String Principal(HttpServletRequest req) {
        //if(req.getSession().getAttribute("usuario") != null) {
            return "principal";
        //} else {
        //    return "index";
        //}
    }

    @RequestMapping("/cerrarsesion")
    public String cerrarSesion(HttpServletRequest req) {
        req.removeAttribute("usuario");
        req.removeAttribute("nombre");
        req.removeAttribute("correo");
        req.removeAttribute("idrol");
        req.getSession().invalidate();
        return "redirect:/home";
    }
}
