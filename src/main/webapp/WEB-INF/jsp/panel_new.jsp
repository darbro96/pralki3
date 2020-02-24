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
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<sec:authorize access="hasRole('ROLE_USER')">
    <%@include file="/WEB-INF/incl/menu_user.app" %>

    <div class="container-fluid" style="text-align: center;"><br>

        <h1>Strona główna</h1>
        <p>
            <button type="button" class="btn btn-primary"
                    onclick="window.location.href='${pageContext.request.contextPath}/bookwasher'">Zarezerwuj pralkę
            </button>
        </p>
        <p>Podgląd aktualnego rozkładu rezerwacji</p>
            <div class="btn-group ml-auto">
            <c:forEach var="w" items="${washers}">
                <button type="button" class="btn btn-primary"
                        onclick="window.location.href='${pageContext.request.contextPath}/panel?washer=${w.idWasher}'">
                    Pralka nr <c:out value="${w.numberWasher}"/> (pralnia <c:out value="${w.laundry.numberLaundry}"/>)
                </button>
            </c:forEach>
        </div>
            <p><c:out value="${message}"/></p>
            <c:set var="timetable" value="0"/>
            <c:set var="sr" value="0"/>
            <c:set var="size" value="${timetables.size()-1}"/>
        <br><br>
        <div class="table-responsive">
            <table class="table-bordered w-75">
                <tr>
                    <td></td>
                    <c:forEach var="t" items="${timetables}">
                        <td><b>${t.day}</b></td>
                    </c:forEach>
                </tr>
                <c:set var="t" value="${timetables.get(timetable)}"/>
                <c:forEach var="h" items="${hours}">
                    <tr>
                        <td>${h}</td>
                        <c:forEach var="tm" items="${timetables}">
                            <td bgcolor="${t.specialReservations.get(sr).color}"></td>
                            <c:if test="${timetable<size}">
                                <c:set var="timetable" value="${timetable+1}"/>
                                <c:set var="t" value="${timetables.get(timetable)}"/>
                            </c:if>
                        </c:forEach>
                        <c:set var="timetable" value="0"/>
                        <c:set var="t" value="${timetables.get(timetable)}"/>
                    </tr>
                    <c:set var="sr" value="${sr+1}"/>
                </c:forEach>
            </table>
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
    <p><a href="${pageContext.request.contextPath}/addroom">Dodaj pokój</a></p>
</sec:authorize>
</body>
</html>