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
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
</head>
<body ng-app="pralki" ng-controller="washerManagement">
<%@include file="/WEB-INF/incl/menu.app" %>
<div class="container-fluid p-0">
    <div class="row m-0">
        <%@include file="/WEB-INF/incl/panel_admin.app" %>
        <div class="col-sm-9 col-md-10   padm shadow bg-light" id="content">
            <div class="p-1" id="title">
                <div id="accordion">
                    <div class="card">
                        <div class="card-header">
                            <a class="card-link" data-toggle="collapse" href="#collapseOne">
                                Zarządzanie pralkami
                            </a>
                        </div>
                        <div id="collapseOne" class="collapse show" data-parent="#accordion">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="step1">Akademik:</label>
                                    <select class="form-control" id="step1" ng-model="dorm" ng-change="searchLaundry()">
                                        <option ng-repeat="d in dorms" value="{{d.name}}"/>
                                        {{d.name}}</select>
                                    </select>
                                </div>
                                <div class="form-group" ng-show="laundries.length>0">
                                    <label for="step2">Pralnia:</label>
                                    <select class="form-control" id="step2" ng-model="laundry"
                                            ng-change="searchWashers()">
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
                                                <button class="btn btn-outline-primary"
                                                        ng-click="setAvailable(w.idWasher)"
                                                        ng-show="!w.available">Odblokuj
                                                </button>
                                                <button class="btn btn-outline-primary"
                                                        ng-click="setUnavailable(w.idWasher)" ng-show="w.available">
                                                    Zablokuj
                                                </button>
                                                <button class="btn btn-outline-primary" ng-click="edit(w.idWasher)">
                                                    Edytuj
                                                </button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <a class="collapsed card-link" data-toggle="collapse" href="#collapseTwo">
                                Dodawanie nowej pralki
                            </a>
                        </div>
                        <div id="collapseTwo" class="collapse" data-parent="#accordion">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="step1_new_washer">Akademik:</label>
                                    <select class="form-control" id="step1_new_washer" ng-model="dorm"
                                            ng-change="searchLaundry()">
                                        <option ng-repeat="d in dorms" value="{{d.name}}"/>
                                        {{d.name}}</select>
                                    </select>
                                    <div class="form-group" ng-show="laundries.length>0">
                                        <label for="step2_new_washer">Pralnia:</label>
                                        <select class="form-control" id="step2_new_washer" ng-model="laundry"
                                                ng-change="searchWashers()">
                                            <option ng-repeat="l in laundries" value="{{l.idLaundry}}"/>
                                            {{l.numberLaundry}}</select>
                                        </select>
                                    </div>
                                    <div class="form-group" ng-show="laundry!=null">
                                        <label for="step3_new_washer">Numer pralki:</label>
                                        <input type="text" id="step3_new_washer" ng-model="newWasherNumber"
                                               class="form-control">
                                        <button class="btn btn-outline-primary" ng-click="addNewWasher()">
                                            Dodaj nową pralkę
                                        </button>
                                        <div class="alert alert-success alert-dismissible" ng-show="successAddWasher">
                                            <strong>Sukces</strong> Pralka dodana!
                                        </div>
                                        <div class="alert alert-danger alert-dismissible" ng-show="errorAddWasher">
                                            <strong>Błąd</strong> Błąd podczas dodawania pralki!
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <a class="collapsed card-link" data-toggle="collapse" href="#collapseThree">
                                Zarządzanie pralniami
                            </a>
                        </div>
                        <div id="collapseThree" class="collapse" data-parent="#accordion">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="step1_laundry">Akademik:</label>
                                    <select class="form-control" id="step1_laundry" ng-model="dorm"
                                            ng-change="searchLaundry()">
                                        <option ng-repeat="d in dorms" value="{{d.name}}"/>
                                        {{d.name}}
                                    </select>
                                </div>
                                <div class="table-responsive" ng-show="laundries.length>0">
                                    <table class="table table-striped">
                                        <thead>
                                        <tr>
                                            <th>Numer pralni</th>
                                            <th>Dotępne akcje</th>
                                        </tr>
                                        </thead>
                                        <tr ng-repeat="w in laundries">
                                            <td>{{w.numberLaundry}}</td>
                                            <td>
                                                <button class="btn btn-outline-primary"
                                                        ng-click="editLaundry(w.idLaundry)">
                                                    Edytuj
                                                </button>
                                                <button class="btn btn-outline-primary"
                                                        ng-click="deleteLaundry(w.idLaundry)"
                                                        title="UWAGA! Usunięcie pralni spowoduje usunięcie wszystkich pralek w pralni oraz rezerwacji powiązanych z pralkami z pralni"
                                                        data-toggle="popover" data-trigger="hover">
                                                    Usuń
                                                </button>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card">
                        <div class="card-header">
                            <a class="collapsed card-link" data-toggle="collapse" href="#collapseFour">
                                Dodawanie pralni
                            </a>
                        </div>
                        <div id="collapseFour" class="collapse" data-parent="#accordion">
                            <div class="card-body">
                                <div class="form-group">
                                    <label for="step1_new_laundry">Akademik:</label>
                                    <select class="form-control" id="step1_new_laundry" ng-model="dorm"
                                            ng-change="searchLaundry()">
                                        <option ng-repeat="d in dorms" value="{{d.name}}"/>
                                        {{d.name}}
                                    </select>
                                </div>
                                <div class="form-group" ng-show="dorm!=null">
                                    <label for="lName">Numer pralni:</label>
                                    <input type="text" ng-model="nameOfNewLaundry" class="form-control" id="lName">
                                    <button class="btn btn-outline-primary" ng-click="addNewLaundry()">
                                        Dodaj nową pralnię
                                    </button>
                                    <div class="alert alert-success alert-dismissible" ng-show="successAddLaundry">
                                        <strong>Sukces</strong> Pralnia dodana!
                                    </div>
                                    <div class="alert alert-danger alert-dismissible" ng-show="errorAddLaundry">
                                        <strong>Błąd</strong> Błąd podczas dodawania pralni!
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js"
        integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n"
        crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js"
        integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo"
        crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"
        integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6"
        crossorigin="anonymous"></script>
<script src="/resources/js/angularjs/1.7.9/angular.min.js"></script>
<script>
    angular.module('pralki', []).controller('washerManagement', function ($scope, $http, $location) {
        $scope.dorms = [];
        $scope.laundries = [];
        $scope.washers = [];
        $scope.successAddWasher = false;
        $scope.errorAddWasher = false;
        $scope.successAddLaundry = false;
        $scope.errorAddLaundry = false;
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

        $scope.setAvailable = function (id) {
            window.location.href = '${pageContext.request.contextPath}/unlockwasher/' + id;
        };

        $scope.setUnavailable = function (id) {
            window.location.href = '${pageContext.request.contextPath}/blockwasher/' + id;
        };

        $scope.edit = function (id) {
            window.location.href = '${pageContext.request.contextPath}/editwasher/' + id;
        };

        $scope.addNewWasher = function () {
            $http.post("/api/addWasher?laundry=" + $scope.laundry + "&washerNum=" + $scope.newWasherNumber).then(function (value) {
                    if (value.status == 200) {
                        $scope.successAddWasher = true;
                        $scope.errorAddWasher = false;
                        $scope.newWasherNumber = "";
                        $scope.washer = null;
                        $scope.washers = [];
                    } else {
                        $scope.errorAddWasher = true;
                        $scope.successAddWasher = false;
                    }
                }, function (err) {
                    $scope.errorAddWasher = true;
                }
            )
        };

        $scope.editLaundry = function (id) {
            window.location.href = '${pageContext.request.contextPath}/editlaundry/' + id;
        };

        $scope.addNewLaundry = function () {
            $http.post("/api/addlaundry?dormitory=" + $scope.dorm + "&laundry=" + $scope.nameOfNewLaundry).then(function (value) {
                if (value.status == 200) {
                    $scope.laundry = null;
                    $scope.washer = null;
                    $scope.washers = [];
                    $scope.laundries = [];
                    $scope.nameOfNewLaundry = null;
                    $scope.successAddLaundry = true;
                    $scope.errorAddLaundry = false;
                } else {
                    $scope.successAddLaundry = false;
                    $scope.errorAddLaundry = true;
                }
            }, function (reason) {
                $scope.successAddLaundry = false;
                $scope.errorAddLaundry = true;
            })
        };
    });
</script>
<script>
    $(document).ready(function () {
        $('[data-toggle="popover"]').popover();
    });
</script>
</body>
</html>