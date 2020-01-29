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
                <div class="btn-group">
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/panel'"><i
                            class="fas fa-home"></i> Panel główny
                    </button>
                    <button type="button" class="btn btn-secondary font-weight-bold"><i
                            class="fas fa-wrench"></i> Zgłoś usterkę
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/bookwasher'"><i
                            class="far fa-registered"></i>
                        Zarezerwuj
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/reservations'"><i
                            class="far fa-registered"></i>
                        Podgląd rezerwacji
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
</div>
<div class="container-fluid p-5">

    <div class="container-fluid bg-white border p-5">
        <div class="container">

            <div class="card mt-4">
                <div class="card-header"><h6>Zgłoś usterkę</h6></div>
                <div class="card-body">
                    <div class="row p-2 bg-info">
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
                        <sf:form id="usersForm" action="/reportfaultaction" modelAttribute="fault"
                                 enctype="multipart/form-data" method="POST">
                            <div class="form-group bg-green mx-auto">
                                <label for="lName">Opis usterki:</label>
                                <sf:textarea path="description"  class="form-control" id="lName"/>
                            </div>
                            <div class="form-group">
                                <input type="submit" value="Zgłoś" class="btn btn-outline-primary">
                                <input class="btn btn-outline-primary" type="button" value="Rezygnacja"
                                       onclick="window.location.href='${pageContext.request.contextPath}/panel'">
                            </div>
                        </sf:form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>