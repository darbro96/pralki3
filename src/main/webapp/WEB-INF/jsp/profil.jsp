<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Profil użytkownika</title>
</head>
<body>
<%@include file="/WEB-INF/incl/menu.app" %>
<p>E-mail:&nbsp;&nbsp;<b><c:out value="${user.email}"/> </b></p>
<p>Imię:&nbsp;&nbsp;<b><c:out value="${user.name}"/> </b></p>
<p>Nazwisko:&nbsp;&nbsp;<b><c:out value="${user.lastName}"/> </b></p>
<p>Czy aktywny?&nbsp;&nbsp;
    <c:choose>
        <c:when test="${user.active==1}"><font color="green">TAK</font></c:when>
        <c:otherwise><font color="green">NIE</font></c:otherwise>
    </c:choose>
</p>
<p>Rola:&nbsp;&nbsp;
<c:choose>
    <c:when test="${user.nrRoli==1}">Administrator</c:when>
    <c:otherwise>Użytkownik</c:otherwise>
</c:choose>
</p>
<p>Akademik: <c:out value="${user.dormitory.name}" /> </p>
<p><button onclick="window.location.href='${pageContext.request.contextPath}/editpassword'">Zmiana hasła</button></p>
</body>
</html>