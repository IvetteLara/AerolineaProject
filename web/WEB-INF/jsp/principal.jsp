<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page session="true"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;
              charset=UTF-8">
        <title><s:message code="usuario.bienvenida" /></title>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js">

        </script>        
        <script>
            //JS
            window.onpageshow = function (event) {
                if (event.persisted) {
                    window.location.reload(true);
                }
            };

            //JQuery
            $(window).bind("pageshow", function (event) {
                if (event.originalEvent.persisted) {
                    window.location.reload()
                }
            });
        </script>

    </head>
    <body style="font-family: arial">
        <%
            HttpSession s = request.getSession();
            if (s.getAttribute("usuario") == null) {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            response.setHeader("Cache-Control", "no-cache");
            response.setHeader("Cache-Control", "no-store");
            response.setHeader("Pragma", "no-cache");
            response.setDateHeader("Expires", 0);

        %>    
        <h3><s:message code="usuario.bienvenida" /></h3>
        <table border="0">
            <tr>
                <td><s:message code="usuario.idusuario" /></td>
                <td><%out.println(s.getAttribute("usuario") + "<br/>");%></td>
            </tr>        
            <tr>
                <td><s:message code="usuario.nombres" /></td>
                <td><%out.println(s.getAttribute("nombre") + "<br/>");%></td>
            </tr> 
            <tr>
                <td><s:message code="usuario.email" /></td>
                <td><%out.println(s.getAttribute("correo") + "<br/>");%></td>
            </tr>        
            <tr>
                <td><s:message code="usuario.rol" /></td>
                <td><%out.println(s.getAttribute("idrol") + "<br/>");%></td>
            </tr> 
        </table>    
            
        <br/>
        <br/>
        <a href="<c:url value='/usuarios'/>"><s:message code="usuario.lista.titulo" /></a><br/>
        <a href="<c:url value='/cerrarsesion'/>"><s:message code="usuario.cerrarsesion" /></a>
    </body>
</html>