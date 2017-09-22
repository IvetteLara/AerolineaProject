<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://www.springframework.org/tags" prefix="s" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html;
              charset=UTF-8">
        <title><s:message code="usuario.lista.titulo" /></title>
    </head>
    <body style="font-family: arial">
        <h3><s:message code="usuario.lista.bdnormal" /></h3>
        <table border="1">
            <thead>
                <tr>
                    <th><s:message code="usuario.idusuario" /></th>
                    <th><s:message code="usuario.nombres" /></th>
                    <th><s:message code="usuario.apellidos" /></th>
                    <th><s:message code="usuario.email" /></th>
                    <th><s:message code="usuario.telefono" /></th>
                    <th><s:message code="usuario.pais" /></th>
                    <th><s:message code="usuario.rol" /></th>
                    <th><s:message code="acciones.editar" /></th>
                    <th><s:message code="acciones.eliminar" /></th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${usuarios}" var="u">
                    <tr>
                        <td>${u.idusuario}</td>
                        <td>${u.nombres}</td>
                        <td>${u.apellidos}</td>
                        <td>${u.email}</td>
                        <td>${u.telefono}</td>
                        <td>${u.pais.pais}</td>
                        <td>${u.rol.rol}</td>
                        <td><a href="<c:url value='/registrar?id=${u.idusuario}'/>"><s:message code="acciones.editar" /></a></td>
                        <td><a href="<c:url value='/remover?id=${u.idusuario}'/>"><s:message code="acciones.eliminar" /></a></td>
                    </tr>
                </c:forEach>
            </tbody>  
        </table>    
        <h3><s:message code="usuario.lista.bdrespaldo" /></h3>
        <table border="1">
            <thead>
                <tr>
                    <th><s:message code="usuario.idusuario" /></th>
                    <th><s:message code="usuario.nombres" /></th>
                    <th><s:message code="usuario.apellidos" /></th>
                    <th><s:message code="usuario.email" /></th>
                    <th><s:message code="usuario.telefono" /></th>
                    <th><s:message code="usuario.pais" /></th>
                    <th><s:message code="usuario.rol" /></th>
                    <th><s:message code="acciones.editar" /></th>
                    <th><s:message code="acciones.eliminar" /></th>
                </tr>
            </thead>
            <tbody>                    
                <c:forEach items="${usuariosBackup}" var="ub">
                    <tr>
                        <td>${ub.idusuario}</td>
                        <td>${ub.nombres}</td>
                        <td>${ub.apellidos}</td>
                        <td>${ub.email}</td>
                        <td>${ub.telefono}</td>
                        <td>${ub.pais.pais}</td>
                        <td>${ub.rol.rol}</td>
                        <td><a href="<c:url value='/registrar?id=${ub.idusuario}'/>"><s:message code="acciones.editar" /></a></td>
                        <td><a href="<c:url value='/remover?id=${ub.idusuario}'/>"><s:message code="acciones.eliminar" /></a></td>
                    </tr>
                </c:forEach>                    
            </tbody>
        </table>
    </body>
</html>