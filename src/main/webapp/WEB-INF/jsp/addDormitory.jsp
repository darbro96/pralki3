<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Dodaj akademik</title>
</head>
<body>
<%@include file="/WEB-INF/incl/menu.app" %>
<h2>Dodawanie nowego akademika</h2>
<c:out value="${message }" />
<sf:form id="usersForm" action="adddorm" modelAttribute="dormitory" enctype="multipart/form-data" method="POST">
    Nazwa: <sf:input path="name"/>
    <input type="submit" value="Dodaj" class="formbutton"/>
    <input type="button" value="<s:message code="button.cancel"/>" class="formbutton"
           onclick="window.location.href='${pageContext.request.contextPath}/panel'"/>
</sf:form>
<font color="red"><sf:errors path="name"/></font>
</body>
</html>