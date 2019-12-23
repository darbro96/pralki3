<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Strona główna</title>
</head>
<body>
<%@include file="/WEB-INF/incl/menu.app" %>
<h2>Zmiana hasła</h2>
<p><c:out value="${message}"/></p>
<sf:form id="usersForm" action="updatepass" modelAttribute="user" enctype="multipart/form-data" method="POST">
    <sf:hidden path="email"/>
    <p>Nowe hasło:&nbsp;&nbsp;<sf:password path="newPassword"/></p>
    <font color="red"> <sf:errors path="newPassword"/></font>
    <input type="submit" value="Zmiana hasła">
    <input type="button" value="Rezygnacja" onclick="window.location.href='${pageContext.request.contextPath}/profil'">
</sf:form>
</body>
</html>