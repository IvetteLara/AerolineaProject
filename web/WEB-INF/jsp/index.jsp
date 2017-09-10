<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Welcome to Spring Web MVC project</title>
        <script>
            function validate()
            {
                var username = document.form.txtUsuario.value;
                var password = document.form.txtClave.value;
                if (username == null || username == "")
                {
                    alert("El Usuario no puede estar vacío");
                    return false;
                } else if (password == null || password == "")
                {
                    alert("La Clave no puede estar vacía");
                    return false;
                }
            }
        </script>         
    </head>
    ${mensaje}
    <%
      if(request.getParameter("error")!= null) {
          out.print("<p>Error: usuario o contraseña incorrecto</p>");
      }  
    %>    
    <body style="font-family: arial">
        <h3 >Inicio de Sesion</h3>
        <form name="form" action="<c:url value='/login' />" method="POST" onsubmit="return validate()">
            <table border="0">
                <tbody>
                    <tr>
                        <td>Usuario: </td>
                        <td><input type="text" name="txtUsuario" value="" /> </td>
                    </tr>
                    <tr>
                        <td>Clave: </td>
                        <td><input type="password" name="txtClave" value="" /> </td>
                    </tr>
                    <tr><td><span style="color:red"><%=(request.getAttribute("errMessage") == null) ? "" : request.getAttribute("errMessage")%></span></td>
                    </tr>                
                    <tr>
                        <td colspan="2" align="right">
                            <input type="submit" value="Entrar" /> 
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <a href="<c:url value='/usuarios' />">Listado de usuarios</a> 
        <a href="<c:url value='/registrar' />">Registrarse</a>
    </body>
</html>

