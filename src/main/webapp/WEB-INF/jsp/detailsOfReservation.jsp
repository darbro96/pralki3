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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/administrationPanel.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <title>Dodaj pokój</title>
</head>
<body>
<%@include file="/WEB-INF/incl/menu.app" %>

<div class="container-fluid p-0">
    <div class="row m-0">
        <%@include file="/WEB-INF/incl/panel_admin.app" %>
        <div class="col-sm-9 col-md-10   padm shadow bg-light" id="content">
            <div class="p-1" id="title">
                <p><c:out value="${message }"/></p>
            </div>
            <div class="card mt-4">
                <div class="card-header"><h6>Szczegóły rezerwacji</h6></div>
                <div class="card-body">
                    <div class="row p-2">
                        <div class="col-sm-6">
                            <h5>Osoba: ${reservation.user.name} ${reservation.user.lastName}
                                (${reservation.user.room.number})</h5>
                            <h5>Pralka (pralnia): ${reservation.washer.numberWasher}
                                (${reservation.washer.laundry.numberLaundry})</h5>
                            <h5>Akademik: ${reservation.washer.laundry.dormitory.name}</h5>
                            <h5>Rozpoczęcie: ${reservation.start.toString().replace("T"," ")}</h5>
                            <h5>Zakończenie: ${reservation.stop.toString().replace("T"," ")}</h5>
                        </div>
                        <div class="col-sm-6">
                            <button type="button" class="btn btn-outline-info d-flex m-4"
                                    onclick="window.location.href='${pageContext.request.contextPath}/cancelreservation/${reservation.idReservation}'">
                                Anuluj rezerwację
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>