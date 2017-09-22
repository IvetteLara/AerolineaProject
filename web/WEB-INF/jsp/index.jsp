<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN"
    "http://www.w3.org/TR/html4/loose.dtd">
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title><s:message code="usuario.bienvenida" /></title>
        <script>
            function validate()
            {
                var username = document.form.txtUsuario.value;
                var password = document.form.txtClave.value;
                if (username == null || username == "")
                {
                    alert('<s:message javaScriptEscape="true" code="usuario.idusuario.alert" />');
                    return false;
                } else if (password == null || password == "")
                {
                    alert('<s:message javaScriptEscape="true" code="usuario.clave.alert" />');
                    return false;
                }
            }
        </script>         
    </head>
   
    <%
      if(request.getParameter("error")!= null) { 
    %>      
          <span style="color:red"><p><s:message code="usuario.error.alert" /></p></span>
    <%
      }  
    %>    
    <body style="font-family: arial">
        <h3><s:message code="usuario.iniciosesion" /></h3>
        <form name="form" action="<c:url value='/login' />" method="POST" onsubmit="return validate()">
            <table border="0">
                <tbody>
                    <tr>
                        <td><s:message code="usuario.idusuario" /> </td>
                        <td><input type="text" name="txtUsuario" value="" /> </td>
                    </tr>
                    <tr>
                        <td><s:message code="usuario.clave" /> </td>
                        <td><input type="password" name="txtClave" value="" /> </td>
                    </tr>
                    <tr><td><span style="color:red"><%=(request.getAttribute("errMessage") == null) ? "" : request.getAttribute("errMessage")%></span></td>
                    </tr>                
                    <tr>
                        <td colspan="2" align="right">
                            <input type="submit" value="<s:message code="usuario.entrar" />" /> 
                        </td>
                    </tr>
                </tbody>
            </table>
        </form>
        <a href="<c:url value='/usuarios' />"><s:message code="usuario.lista.titulo" /></a> 
        <a href="<c:url value='/registrar' />"><s:message code="acciones.registrar" /></a>
        <br /><br />
        <a href="?language=en_US">Cambiar idioma a Inglés</a><br />
        <a href="?language=es_SV">Cambiar idioma a Español</a>          
    </body>
</html>