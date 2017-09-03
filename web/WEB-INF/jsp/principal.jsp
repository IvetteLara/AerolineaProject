<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;
              charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body style="font-family: arial">
        <h3>Bienvenido a Spring</h3>
        <%
            HttpSession s = request.getSession();
            out.println("Usuario: " + s.getAttribute("usuario") + "<br/>");
            out.println("Nombre: " + s.getAttribute("nombre") + "<br/>");
            out.println("Correo: " + s.getAttribute("correo") + "<br/>");
            out.println("Rol: " + s.getAttribute("idrol") + "<br/>");
        %>
        <a href="<c:url value='/usuarios'/>">Listado de
            Usuarios</a><br/>
        <a href="<c:url value='/cerrarsesion'/>">Cerrar Sesion</a>
    </body>
</html>