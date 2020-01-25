<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Panel mieszkańca - SODS</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <link rel="stylesheet" href="/resources/css/mainPanel.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/test.css" type="text/css">
</head>
<body class="bg-background">
<nav class="navbar navbar-expand-md bg-dark navbar-dark navbar-main" id="navbar-main">

    <a class="navbar-brand font-weight-bold" href="/panel"><i class="fas fa-home"></i> Panel mieszkańca</a>


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
                    <button type="button" class="btn btn-secondary font-weight-bold"><i class="fas fa-home"></i> Panel
                        główny
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"><i
                            class="fas fa-wrench"></i> Zgłoś usterkę
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"><i
                            class="far fa-registered"></i> Podgląd rezerwacji
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"><i class="far fa-user"></i>
                        Twój profil
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid p-5">

    <div class="container-fluid bg-white border p-5">
        <div class="container">
            <h4 class="text-center">Panel główny</h4>


            <%--            <div class="card-group pt-2">--%>
            <%--                <div class="card bg-light">--%>
            <%--                    <div class="card-body text-center">--%>
            <%--                        <p class="card-text">--%>
            <%--                        <h1><span class="badge badge-success">2</span></h1>--%>
            <%--                        <h6>Liczba twoich zgłoszeń</h6></p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--                <div class="card bg-light">--%>
            <%--                    <div class="card-body text-center">--%>
            <%--                        <p class="card-text">--%>
            <%--                        <h1><span class="badge badge-info">2</span></h1>--%>
            <%--                        <h6>Liczba twoich rezerwacji</h6></p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--                <div class="card bg-light">--%>
            <%--                    <div class="card-body text-center">--%>
            <%--                        <p class="card-text">--%>
            <%--                        <h1><span class="badge badge-warning">2</span></h1>--%>
            <%--                        <h6>Liczba twoich ostrzerzeń</h6></p>--%>
            <%--                    </div>--%>
            <%--                </div>--%>
            <%--            </div>--%>


            <div class="card mt-4">
                <div class="card-header"><h6>Podgląd twoich aktywnych rezerwacji</h6></div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-striped">
                            <thead>
                            <tr>
                                <th>Nr</th>
                                <th>Pralka (pralnia)</th>
                                <th>Rozpoczęcie</th>
                                <th>Zakończenie</th>
                                <th></th>
                            </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="r" items="${reservations}">
                                <tr>
                                    <td>${r.idReservation}</td>
                                    <td>${r.washer.numberWasher} (${r.washer.laundry.numberLaundry})</td>
                                    <td>${r.start.toString().replace("T"," ")}</td>
                                    <td>${r.stop.toString().replace("T"," ")}</td>
                                    <td>
                                        <button class="btn btn-outline-primary" onclick="window.location.href='${pageContext.request.contextPath}/reservations?cancel=${r.idReservation}'">
                                            Zrezygnuj
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


        </div>

    </div>
</div>
</body>
</html>