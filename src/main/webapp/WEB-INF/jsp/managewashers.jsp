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
                <h2>Zarządzanie pralkami</h2>
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
                <div class="table-responsive" ng-show="washers.length>0">
                    <table class="table table-striped">
                        <thead>
                        <tr>
                            <th>Numer pralki</th>
                            <th>Dostępna</th>
                            <th>Dotępne akcje</th>
                        </tr>
                        </thead>
                        <tr ng-repeat="w in washers">
                            <td>{{w.numberWasher}}</td>
                            <td>{{w.available==true?"TAK":"NIE"}}</td>
                            <td>
                                <button class="btn btn-outline-primary" ng-click="setAvailable(w.idWasher)" ng-show="!w.available">Odblokuj</button>
                                <button class="btn btn-outline-primary" ng-click="setUnavailable(w.idWasher)" ng-show="w.available">Zablokuj</button>
                                <button class="btn btn-outline-primary" ng-click="edit(w.idWasher)">Edytuj</button>
                            </td>
                        </tr>
                    </table>
                </div>
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

        $scope.setAvailable=function (id) {
            window.location.href='${pageContext.request.contextPath}/unlockwasher/'+id;
        };

        $scope.setUnavailable=function (id) {
            window.location.href='${pageContext.request.contextPath}/blockwasher/'+id;
        };

        $scope.edit=function (id) {
            window.location.href='${pageContext.request.contextPath}/editwasher/'+id;
        };
    });
</script>
</body>
</html>