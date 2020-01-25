<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
<nav class="navbar navbar-expand-md bg-dark navbar-dark navbar-main" id="navbar-main">

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
                    <button type="button" class="btn btn-secondary font-weight-bold" onclick="window.location.href='${pageContext.request.contextPath}/panel'"><i class="fas fa-search"></i>
                        Wyszukaj mieszkańca
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold" onclick="window.location.href='${pageContext.request.contextPath}/reception/reservations'"><i
                            class="far fa-calendar-check"></i> Podgląd rezerwacji
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"><i
                            class="far fa-registered"></i> Twoja aktywność
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid p-5">

    <div class="container-fluid bg-white border p-5">
        <h3><i class="fas fa-search"></i> Wyszukaj mieszkańca</h3>
        <input class="form-control form-control-lg mt-4" type="text"
               placeholder="Wpisz imię, nazwisko lub numer pokoju..." ng-model="par" ng-change="search()">
        <br>

        <div class="table-responsive">
            <table class="table table-bordered table-hover table-striped">
                <thead class="thead-light">
                <tr>
                    <th>Imię</th>
                    <th>Nazwisko</th>
                    <th>Pokój</th>
                    <th></th>
                </tr>
                </thead>
                <tbody id="myTable">
                <tr data-ng-repeat="u in vUsers">
                    <td>{{u.name}}</td>
                    <td>{{u.lastName}}</td>
                    <td>{{u.room.number}}</td>
                    <td></td>
                </tr>
                </tbody>
            </table>
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
<script src="resources/js/angularjs/1.7.9/angular.min.js"></script>
<script>
    angular.module('pralki', []).controller('usersContr', function ($scope, $http, $location) {
        $scope.vUsers = [];
        $http.get("/api/reception/users/${loggedUser.dormitory.name}").then(function (value) {
            $scope.users = value.data;
        });

        $scope.search = function () {
            text = $scope.par;
            $scope.vUsers = [];
            var i;
            var j = 0;
            if (!$scope.par == "") {
                for (i = 0; i < $scope.users.length; i++) {
                    var nr = "";
                    var card = "";
                    if ($scope.users[i].room != null) {
                        nr = $scope.users[i].room.number;
                    }
                    if ($scope.users[i].cardId != null) {
                        card = $scope.users[i].cardId;
                    }
                    if ($scope.users[i].name.toLowerCase().includes($scope.par.toLowerCase()) || $scope.users[i].lastName.toLowerCase().includes($scope.par.toLowerCase()) || nr.toLowerCase().includes($scope.par.toLowerCase()) || card.includes($scope.par)) {
                        $scope.vUsers[j] = $scope.users[i];
                        j++;
                    }
                }
            } else {
                $scope.vUsers = [];
            }
        };

        $scope.resetPassword = function (id) {
            $http.post("/api/resetpassword/" + id).then(function (value) {
                console.log("Success", "Mail sent");
            }), function (err) {
                console.log("Error", err);
            }
        };


    });
</script>
</body>
</html>