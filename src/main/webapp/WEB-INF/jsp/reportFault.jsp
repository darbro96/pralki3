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
                <button type="button" class="btn btn-outline-secondary font-weight-bold"
                        onclick="window.location.href='${pageContext.request.contextPath}/panel'"><i
                        class="far fa-calendar-check"></i> Harmonogram rezerwacji
                </button>
                <button type="button" class="btn btn-outline-secondary font-weight-bold"
                        onclick="window.location.href='${pageContext.request.contextPath}/bookwasher'"><i
                        class="far fa-registered"></i>
                    Zarezerwuj
                </button>
                <button type="button" class="btn btn-outline-secondary font-weight-bold"
                        onclick="window.location.href='${pageContext.request.contextPath}/reservations'"><i
                        class="far fa-registered"></i>
                    Twoje rezerwacji
                </button>
                <button type="button" class="btn btn-secondary font-weight-bold"
                        onclick="window.location.href='${pageContext.request.contextPath}/reportfault'"><i
                        class="fas fa-wrench"></i> Zgłoś usterkę
                </button>
                <button type="button" class="btn btn-outline-secondary font-weight-bold"
                        onclick="window.location.href='${pageContext.request.contextPath}/profil'"><i
                        class="far fa-user"></i>
                    Twój profil
                </button>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid p-sm-0 p-md-5">

    <div class="container-fluid bg-white border p-5">
        <div class="container">
            <div class="row d-flex justify-content-center">
                <div class="col-md-12 col-lg-6">


            <c:if test="${message==true}">
                <div class="alert alert-success alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times</button>
                    <strong>Sukces!</strong> Usterka zgłoszona
                </div>
            </c:if>
            <c:if test="${message==false}">
                <div class="alert alert-danger alert-dismissible">
                    <button type="button" class="close" data-dismiss="alert">&times</button>
                    <strong>Błąd!</strong> Błąd podczas zgłaszania usterki
                </div>
            </c:if>
            <h4 class="text-center pb-2">Zgłoś usterkę</h4>




                        <div class="container p-2">
                        <sf:form id="usersForm" action="/reportfaultaction" modelAttribute="fault"
                                 enctype="multipart/form-data" method="POST">
                            <div class="form-group mx-auto">
                                <label for="lName">Opisz usterkę i miejsce jej wystąpienia:</label>
                                <sf:textarea path="description"  class="form-control" id="lName"/>
                            </div>
                            <div class="form-group d-flex">
                                <input type="submit" value="Zgłoś" class="btn btn-success flex-fill mr-2">
                                <input class="btn btn-danger flex-fill ml-2" type="button" value="Rezygnacja"
                                       onclick="window.location.href='${pageContext.request.contextPath}/panel'">
                            </div>
                        </sf:form>
                    </div>

                </div>
            </div>

        </div>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</body>
</html>