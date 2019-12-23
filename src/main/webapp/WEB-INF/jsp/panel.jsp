<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="s"  uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Strona główna</title>
</head>
<body>
<%@include file="/WEB-INF/incl/menu.app" %>
<p align="right">Zalogowano jako: ${user.name} ${user.lastName}</p>
<sec:authorize access="hasRole('ROLE_USER')">
    <h1>Panel użytkownika</h1>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_ADMIN')">
    <h1>Panel administratora</h1>
    <p><a href="${pageContext.request.contextPath}/register">Dodaj użytkownika</a></p>
    <p><a href="${pageContext.request.contextPath}/users/1">Lista użytkowników</a></p>
    <p><a href="${pageContext.request.contextPath}/adddormitory">Dodaj akademik</a></p>
</sec:authorize>
</body>
</html>