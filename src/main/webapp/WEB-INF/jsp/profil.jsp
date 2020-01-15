<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Pralki</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/incl/menu_user.app" %>
<div style="text-align: center;">
    <h1>Twój profil</h1><br>
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
    <p>Akademik:
        <c:choose>
            <c:when test="${user.dormitory.name==null}">Nie zdefiniowano</c:when>
            <c:otherwise><c:out value="${user.dormitory.name}"/> </c:otherwise>
        </c:choose>
    </p>
    <p>
        <c:if test="${user.room!=null}">
            Pokój: ${user.room.number}
        </c:if>
    </p>
    <p>
        <button onclick="window.location.href='${pageContext.request.contextPath}/editpassword'">Zmiana hasła</button>
    </p>
</div>
</body>
</html>