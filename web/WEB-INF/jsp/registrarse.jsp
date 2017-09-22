<%@page contentType="text/html" pageEncoding="UTF-8"
        session="true"%>
<%@taglib uri="http://www.springframework.org/tags/form"
          prefix="form"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;
              charset=UTF-8">
        <title><s:message code="acciones.registrar" /></title>
        <style>
            .error {
                color: #ff0000;
            }
            .errorblock {
                color: #000;
                background-color: #ffEEEE;
                border: 3px solid #ff0000;
                padding: 8px;
                margin: 16px;
            }
        </style>
        <script type="text/javascript">
            function onCambiarClave(valor) {
                document.forms["register"].cambiarClave.value = valor;
            }
        </script>    
    </head>
    <body style="font-family: arial">
        <h3><s:message code="acciones.registrar" /></h3>
        <form:form name="register" method="POST" action="addUsuario" commandName="userForm">
            <form:errors path="*" cssClass="errorblock" element="div" />
            <table>
                <tr>
                    <td><form:label path="idusuario"><s:message code="usuario.idusuario" /></form:label></td>
                        <td>
                        <form:input path="idusuario" />
                        <form:errors path="idusuario" cssClass="error" />
                    </td>
                </tr>
                <tr>
                    <td><form:label path="nombres"><s:message code="usuario.nombres" /></form:label></td>
                    <td><form:input path="nombres" />
                        <form:errors path="nombres" cssClass="error" /></td>
                </tr>
                <tr>
                    <td><form:label
                            path="apellidos"><s:message code="usuario.apellidos" /></form:label></td>
                    <td><form:input path="apellidos" />
                        <form:errors path="apellidos" cssClass="error" /></td>
                </tr>
                <tr>
                    <td><form:label path="email"><s:message code="usuario.email" /></form:label></td>
                    <td><form:input path="email" />
                        <form:errors path="email" cssClass="error" /></td>
                </tr>
                <tr>
                    <td><form:label path="telefono"><s:message code="usuario.telefono" /></form:label></td>
                    <td><form:input path="telefono" />
                        <form:errors path="telefono" cssClass="error" /></td>
                </tr>
                <tr>
                    <td><form:label path="clave"><s:message code="usuario.clave" /></form:label></td>
                    <td><form:password path="clave" showPassword="true" onchange="onCambiarClave(true);" />
                        <form:errors path="clave" cssClass="error" /></td>
                </tr>
                <tr>
                    <td><form:label path="clave2"><s:message code="usuario.clave2" /></form:label></td>
                    <td><form:password path="clave2" showPassword="true" onchange="onCambiarClave(true);" />
                        <form:errors path="clave2" cssClass="error" /></td>
                </tr>                
                <tr>
                    <td><form:label path="pais.idpais"><s:message code="usuario.pais" /></form:label></td>
                    <td><form:select path="pais.idpais">
                            <form:option value="0"><s:message code="acciones.seleccionar" /></form:option> 
                            <form:options items="${paises}" itemLabel="pais"
                                          itemValue="idpais" />
                        </form:select>
                        <form:errors path="pais.idpais" cssClass="error" /></td>
                <tr>
                    <td><form:label path="rol.idrol"><s:message code="usuario.rol" /></form:label></td>
                    <td><form:select path="rol.idrol">
                            <form:option value="0"><s:message code="acciones.seleccionar" /></form:option> 
                            <form:options items="${roles}" itemLabel="rol"
                                          itemValue="idrol" />
                        </form:select>
                        <form:errors path="rol.idrol" cssClass="error" /></td>
                </tr>
                <tr>
                    <td colspan="2">
                        <form:hidden path="cambiarClave" />
                        <input type="submit" value="<s:message code="acciones.enviar" />"/>
                    </td>
                </tr>
            </table>
        </form:form>
    </body>
</html>