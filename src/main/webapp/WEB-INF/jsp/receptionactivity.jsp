<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Panel recepcji - SODS</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <link rel="stylesheet" href="/resources/css/mainPanel.css" type="text/css">
</head>
<body class="bg-background" ng-app="pralki" ng-controller="usersContr">
<nav class="navbar navbar-expand-md bg-green navbar-dark navbar-main" id="navbar-main">

    <a class="navbar-brand font-weight-bold" href="/panel"><i class="fas fa-home"></i> Panel recepcji</a>


    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>


    <div class="collapse navbar-collapse" id="collapsibleNavbar">

        <ul class="navbar-nav ml-auto">
            <li class="nav-item">
                <a class="nav-link font-weight-bold text-white">Zalogowany
                    jako: ${loggedUser.name} ${loggedUser.lastName}</a>
            </li>
            <li class="nav-item">
                <a class="nav-link bg-light font-weight-bold text-dark" href="/logout">Wyloguj <i
                        class="fas fa-lock"></i></a>
            </li>
        </ul>
    </div>
</nav>


<div class="container-fluid bg-light sticky-top align-content-center" id="navbar-button">
    <div class="container">
        <div class="row justify-content-around">
            <div class="align-self-center p-3">
                <div class="btn-group">
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/panel'"><i class="fas fa-user-check"></i>
                        Weryfikuj
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/reception/search'"><i
                            class="fas fa-search"></i>
                        Wyszukaj
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/reception/reservations'">
                        <i
                                class="far fa-calendar-check"></i> Rezerwacje
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/reception/faults'"><i
                            class="far fa-registered"></i> Usterki
                    </button>
                    <button type="button" class="btn btn-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/reception/activity'"><i class="fas fa-user-cog"></i> Profil
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid p-4">
    <div class="container-fluid bg-white border p-5">
        <h3>Twoja aktywność</h3>
        <button class="btn btn-outline-primary"
                onclick="window.location.href='${pageContext.request.contextPath}/editpassword'">Zmiana hasła
        </button>
        <div class="table-responsive">
            <table class="table table-bordered table-hover table-striped">
                <thead class="thead-light">
                <tr>
                    <th>Data i godzina</th>
                    <th>Akcja</th>
                </tr>
                </thead>
                <tbody id="myTable">
                <c:forEach items="${logs}" var="l">
                    <tr>
                        <td>${l.dateAndTime.toString().replace("T"," ")}</td>
                        <td>${l.description}</td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>