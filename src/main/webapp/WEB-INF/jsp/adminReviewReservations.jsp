<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
    <title>Edycja użytkownika</title>
</head>
<body ng-app="pralki" ng-controller="washerManagement">
<%@include file="/WEB-INF/incl/menu.app" %>
<div class="container-fluid p-0">
    <div class="row m-0">
        <%@include file="/WEB-INF/incl/panel_admin.app" %>
        <div class="col-sm-9 col-md-10   padm shadow bg-light" id="content">
            <div class="p-1" id="title">
                <h2>Zarządzanie rezerwacjami</h2>
                <div class="form-group">
                    <label for="step1">Akademik:</label>
                    <select class="form-control" id="step1" ng-model="dorm" ng-change="searchLaundry()">
                        <option ng-repeat="d in dorms" value="{{d.name}}"/>
                        {{d.name}}</select>
                    </select>
                </div>
                <div class="form-group" ng-show="laundries.length>0">
                    <label for="step2">Pralnia:</label>
                    <select class="form-control" id="step2" ng-model="laundry" ng-change="searchWashers()">
                        <option ng-repeat="l in laundries" value="{{l.idLaundry}}"/>
                        {{l.numberLaundry}}</select>
                    </select>
                </div>
                <div class="form-group" ng-show="washers.length>0">
                    <label for="step3">Pralka:</label>
                    <select class="form-control" id="step3" ng-model="washer" ng-change="selectWasher()">
                        <option ng-repeat="w in washers" value="{{w.idWasher}}"/>
                        {{w.numberWasher}}</select>
                    </select>
                </div>
                <c:if test="${timetables != null}">
                    <p><c:out value="${message}"/></p>
                    <c:set var="timetable" value="0"/>
                    <c:set var="sr" value="0"/>
                    <c:set var="size" value="${timetables.size()-1}"/>
                    <div class="table-responsive">
                        <table class="table-bordered w-100 text-center">
                            <tr>
                                <td></td>
                                <c:forEach var="t" items="${timetables}">
                                    <td><b>${t.day.toString().substring(0,5)}</b></td>
                                </c:forEach>
                            </tr>
                            <c:set var="t" value="${timetables.get(timetable)}"/>
                            <c:forEach var="h" items="${hours}">
                                <tr>
                                    <td>${h}</td>
                                    <c:forEach var="tm" items="${timetables}">
                                        <td bgcolor="${t.specialReservations.get(sr).color}"
                                        <c:if test="${t.specialReservations.get(sr).reservation.idReservation!=null}"> onclick="window.location.href='${pageContext.request.contextPath}/reservationdetails/${t.specialReservations.get(sr).reservation.idReservation}'" </c:if></td>
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
                </c:if>
            </div>
        </div>
    </div>
</div>
<script src="/resources/js/angularjs/1.7.9/angular.min.js"></script>
<script>
    angular.module('pralki', []).controller('washerManagement', function ($scope, $http, $location) {
        $scope.dorms = [];
        $scope.laundries = [];
        $scope.washers = [];
        $http.get("/api/dorms").then(function (value) {
            $scope.dorms = value.data;
        });

        $scope.searchLaundry = function () {
            $http.get("/api/laundries/" + $scope.dorm).then(function (value) {
                $scope.laundries = value.data;
            });
        };

        $scope.searchWashers = function () {
            $http.get("/api/washers/" + $scope.laundry).then(function (value) {
                $scope.washers = value.data;
            });
        };

        $scope.selectWasher=function () {
            window.location.href='${pageContext.request.contextPath}/reviewwasher?washer='+$scope.washer;
        }
    });
</script>
</body>
</html>