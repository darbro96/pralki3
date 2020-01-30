<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
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

    <script src="https://unpkg.com/gijgo@1.9.13/js/gijgo.min.js" type="text/javascript"></script>
    <link href="https://unpkg.com/gijgo@1.9.13/css/gijgo.min.css" rel="stylesheet" type="text/css"/>
    <script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
            integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
            crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
            integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
            crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
            integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
            crossorigin="anonymous"></script>
</head>
<body class="bg-background" ng-app="pralki" ng-controller="usersContr">
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
                <button type="button" class="btn btn-secondary font-weight-bold"
                        onclick="window.location.href='${pageContext.request.contextPath}/bookwasher'"><i
                        class="far fa-registered"></i>
                    Zarezerwuj
                </button>
                <button type="button" class="btn btn-outline-secondary font-weight-bold"
                        onclick="window.location.href='${pageContext.request.contextPath}/reservations'"><i
                        class="far fa-registered"></i>
                    Twoje rezerwacji
                </button>
                <button type="button" class="btn btn-outline-secondary font-weight-bold"
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
                    <h4 class="text-center">Zarezerwuj</h4>
                    <c:if test="${error!=null}">
                        <div class="alert alert-danger alert-dismissible">
                            <button type="button" class="close" data-dismiss="alert">&times;</button>
                            <strong>Błąd!</strong> Rezerwacja w wybranym terminie jest niemożliwa. Wybierz inny termin lub pralkę.
                        </div>
                    </c:if>
                    <p><font color="red"><sf:errors path="start"/><c:out value="${message }"/></font></p>


                    <sf:form id="usersForm" action="bookwasheraction" modelAttribute="reservation"
                             enctype="multipart/form-data"
                             method="POST">
                    <sf:hidden path="username" value="${loggedUser.email}"/>
                    <b>Krok 1.</b> Wybierz datę. (Maksymalnie 8 dni później)<br>
                    <sf:input type="date" class="form-control" path="dateStart" min="${today}"
                              max="${max}"/> <br>


                    <b>Krok 2.</b> Wybierz godzinę (Między 6:00 a 21:00) <sf:input path="timeStart" type="time"
                                                                                   min="06:00"
                                                                                   max="21:00" step="1800"
                                                                                   value='{{time}}'
                                                                                   readonly="true"/><br>
                    <button type="button" class="btn btn-outline-secondary m-0 btn-block" data-toggle="modal"
                            data-target="#myModal">
                        Wybierz godzinę rozpoczęcia rezerwacji
                    </button>


                    <!-- Button to Open the Modal -->


                    <!-- The Modal -->
                    <div class="modal fade" id="myModal">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">

                                <!-- Modal Header -->
                                <div class="modal-header">
                                    <h4 class="modal-title">Wybierz godzinę rozpoczęcia rezerwacji</h4>
                                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                                </div>

                                <!-- Modal body -->
                                <div class="modal-body mx-auto">
                                    <div class="btn btn-primary mb-2" ng-click="setTime('06:00')" data-dismiss="modal">
                                        06:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('06:30')" data-dismiss="modal">
                                        06:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('07:00')" data-dismiss="modal">
                                        07:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('07:30')" data-dismiss="modal">
                                        07:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('08:00')" data-dismiss="modal">
                                        08:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('08:30')" data-dismiss="modal">
                                        08:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('09:00')" data-dismiss="modal">
                                        09:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('09:30')" data-dismiss="modal">
                                        09:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('10:00')" data-dismiss="modal">
                                        10:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('10:30')" data-dismiss="modal">
                                        10:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('11:00')" data-dismiss="modal">
                                        11:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('11:30')" data-dismiss="modal">
                                        11:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('12:00')" data-dismiss="modal">
                                        12:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('12:30')" data-dismiss="modal">
                                        12:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('13:00')" data-dismiss="modal">
                                        13:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('13:30')" data-dismiss="modal">
                                        13:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('14:00')" data-dismiss="modal">
                                        14:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('14:30')" data-dismiss="modal">
                                        14:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('15:00')" data-dismiss="modal">
                                        15:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('15:30')" data-dismiss="modal">
                                        15:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('16:00')" data-dismiss="modal">
                                        16:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('16:30')" data-dismiss="modal">
                                        16:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('17:00')" data-dismiss="modal">
                                        17:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('17:30')" data-dismiss="modal">
                                        17:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('18:00')" data-dismiss="modal">
                                        18:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('18:30')" data-dismiss="modal">
                                        18:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('19:00')" data-dismiss="modal">
                                        19:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('19:30')" data-dismiss="modal">
                                        19:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('20:00')" data-dismiss="modal">
                                        20:00
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('20:30')" data-dismiss="modal">
                                        20:30
                                    </div>
                                    <div class="btn btn-primary mb-2" ng-click="setTime('21:00')" data-dismiss="modal">
                                        21:00
                                    </div>
                                </div>

                                <!-- Modal footer -->
                                <div class="modal-footer">
                                    <div type="button" class="btn btn-secondary" data-dismiss="modal">Zamknij</div>
                                </div>

                            </div>
                        </div>
                    </div>

                    <br><b>Krok 3.</b> Wybierz pralkę
                    <sf:select class="form-control" path="washerId">
                        <sf:option value="NONE" label="--- Wybierz ---"/>
                        <c:forEach var="o" items="${washers}">
                            <sf:option value="${o.idWasher}"
                                       label="${o.numberWasher} (pralnia ${o.laundry.numberLaundry})"/>
                        </c:forEach>
                    </sf:select>
                    <br><b>Krok 4.</b> Wybierz czas trwania rezerwacji
                    <sf:select class="form-control" path="duration">
                        <sf:option value="2" label="2 godziny"/>
                        <sf:option value="3" label="3 godziny"/>
                        <sf:option value="4" label="4 godziny"/>
                    </sf:select>

                    <br>
                    <div class="container-fluid d-flex justify-content-center">
                        <input type="submit" value="Rezerwacja" class="formbutton btn btn-success m-2"/>
                        <input type="button" value="<s:message code="button.cancel"/>"
                               class="formbutton btn btn-danger m-2"
                               onclick="window.location.href='${pageContext.request.contextPath}/'"/>
                        </sf:form></div>
                </div>
            </div>

        </div>
    </div>
</div>
<script src="resources/js/angularjs/1.7.9/angular.min.js"></script>
<script>
    angular.module('pralki', []).controller('usersContr', function ($scope, $http, $location) {
        $scope.time = "";
        $scope.setTime = function (val) {
            $scope.time = val;
        };
    });
</script>
</body>
</html>