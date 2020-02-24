<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Pralki</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/administrationPanel.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

</head>
<body ng-app="pralki" ng-controller="usersContr">
<%@include file="/WEB-INF/incl/menu.app" %>

<div class="container-fluid p-0">
    <div class="row m-0">
        <%@include file="/WEB-INF/incl/panel_admin.app" %>
        <div class="col-sm-9 col-md-10   padm shadow bg-light" id="content">
            <div class="p-1" id="title">
                <h1>Użytkownicy</h1>

                <br>
                <div class="card">
                    <div class="card-header"><h5>Wyszukaj użytkownika <span
                            class="badge badge-warning"> ! </span><br><input type="text" ng-model="par"
                                                                             ng-change="search()"/></h5></div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Imię</th>
                                    <th>Nazwisko</th>
                                    <th>Pokój</th>
                                    <th>Akademik</th>
                                    <th>Czy aktywny?</th>
                                    <th>Karta</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <tr data-ng-repeat="u in vUsers">
                                    <td>{{u.name}}</td>
                                    <td>{{u.lastName}}</td>
                                    <td>{{u.room.number}}</td>
                                    <td>{{u.dormitory.name}}</td>
                                    <td>{{u.active==1?"TAK":"NIE"}}</td>
                                    <td>{{u.cardId}}</td>
                                    <td>
                                        <button ng-click="editUser(u.idUser)" class="btn btn-outline-primary">
                                            Edytuj
                                        </button>&nbsp;
                                        <button ng-click="assignCard(u.idUser)" class="btn btn-outline-primary"
                                                ng-show="u.cardId==null">
                                            Przypisz kartę
                                        </button>
                                        <button ng-click="unassignCard(u.idUser)" class="btn btn-outline-primary"
                                                ng-show="u.cardId!=null">
                                            Usuń kartę
                                        </button>
                                        <button ng-click="resetPassword(u.idUser)" class="btn btn-outline-primary">
                                            Resetuj hasło
                                        </button>
                                        <button ng-click="blockUser(u.idUser)" class="btn btn-outline-primary"
                                                ng-show="u.active==1">
                                            Zablokuj
                                        </button>
                                        <button ng-click="unblockUser(u.idUser)" class="btn btn-outline-primary"
                                                ng-hide="u.active==1">
                                            Odblokuj
                                        </button>
                                    </td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<script src="resources/js/angularjs/1.7.9/angular.min.js"></script>
<script>
    angular.module('pralki', []).controller('usersContr', function ($scope, $http, $location) {
        $scope.vUsers = [];
        $http.get("/api/users").then(function (value) {
            $scope.users = value.data;
        });

        $scope.editUser = function (idUser) {
            window.location.href = '${pageContext.request.contextPath}/edituser/' + idUser;
        };

        $scope.assignCard = function (idUser) {
            window.location.href = '${pageContext.request.contextPath}/assigncard/' + idUser;
        };

        $scope.unassignCard = function (idUser) {
            window.location.href = '${pageContext.request.contextPath}/unassigncard/' + idUser;
        };

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

        $scope.blockUser=function (id) {
            window.location.href='${pageContext.request.contextPath}/deactivateuser/'+id;
        }

        $scope.unblockUser=function (id) {
            window.location.href='${pageContext.request.contextPath}/activateuser/'+id;
        }

    });
</script>
</body>
</html>