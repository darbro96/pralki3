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
<sec:authorize access="hasRole('ROLE_USER')">
    <%@include file="/WEB-INF/incl/menu_user.app" %>

    <div class="container-fluid" style="text-align: center;"><br>

        <h1>Strona główna</h1>
        <p>Podgląd aktualnego rozkładu rezerwacji</p>


        <div class="btn-group ml-auto">
                <%--            <button type="button" class="btn btn-primary">Pralka nr 12</button>--%>
                <%--            <button type="button" class="btn btn-primary">Pralka nr 13</button>--%>
                <%--            <button type="button" class="btn btn-primary">Pralka nr 14</button>--%>
                <%--            <button type="button" class="btn btn-primary">Pralka nr 15</button>--%>
                <%--            <button type="button" class="btn btn-primary">Pralka nr 16</button>--%>
                <%--            <button type="button" class="btn btn-primary">Pralka nr 17</button>--%>
            <c:forEach var="w" items="${washers}">
                <button type="button" class="btn btn-primary">Pralka nr <c:out value="${w.numberWasher}" /> (pralnia <c:out value="${w.laundry.numberLaundry}" /> )</button>
            </c:forEach>
        </div>
    </div>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_ADMIN')">
    <%@include file="/WEB-INF/incl/menu.app" %>
    <h1>Panel administratora</h1>
    <p><a href="${pageContext.request.contextPath}/register">Dodaj użytkownika</a></p>
    <p><a href="${pageContext.request.contextPath}/users/1">Lista użytkowników</a></p>
    <p><a href="${pageContext.request.contextPath}/adddormitory">Dodaj akademik</a></p>
    <p><a href="${pageContext.request.contextPath}/addlaundry">Dodaj pralnię</a></p>
    <p><a href="${pageContext.request.contextPath}/addwasher">Dodaj pralkę</a></p>
</sec:authorize>
</body>
</html>