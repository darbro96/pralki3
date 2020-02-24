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
<body ng-app="pralki" ng-controller="roomManagement">
<%@include file="/WEB-INF/incl/menu.app" %>
<div class="container-fluid p-0">
    <div class="row m-0">
        <%@include file="/WEB-INF/incl/panel_admin.app" %>
        <div class="col-sm-9 col-md-10   padm shadow bg-light" id="content">
            <div class="p-1" id="title">
                <h2>Zarządzanie pokojami</h2>
                <p>${message}</p>
                <div class="card">
                    <div class="card-body">
                        <button type="button" class="btn btn-primary"
                                onclick="window.location.href='${pageContext.request.contextPath}/addroom'">Dodaj pokój
                        </button>
                    </div>
                </div>
                <div class="card">
                    <div class="card-body">
                        <div class="form-group">
                            <sf:form id="usersForm" action="searchroombycard" modelAttribute="room"
                                     enctype="multipart/form-data"
                                     method="POST">
                                <label for="card">Przyłóż kartę do czytnika, aby wyszukać pokój:</label>
                                <sf:input path="idCard" id="card" class="form-control"/>
                            </sf:form>
                        </div>
                    </div>
                </div>
                lub wybierz z formularza poniżej
                <div class="card">
                    <div class="card-body">
                        <div class="form-group">
                            <label for="step1">Akademik:</label>
                            <select class="form-control" id="step1" ng-model="dorm">
                                <option ng-repeat="d in dorms" value="{{d.name}}"/>
                                {{d.name}}</select>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="step2">Piętro:</label>
                            <input class="form-control" id="step2" ng-model="floor">
                        </div>
                        <div class="form-group">
                            <button class="btn btn-outline-primary" ng-click="showRooms()">Pokaż</button>
                        </div>
                        <div ng-show="rooms_1.length>0">
                            <table border="1">
                                <tr>
                                    <td ng-repeat="r in rooms_1"><a
                                            href="/editroom/{{r.room.idRoom}}">{{r.room.number}}</a>
                                    </td>
                                </tr>
                                <tr>
                                    <td ng-repeat="r in rooms_1">
                                        <table border="1">
                                            <tr ng-repeat="u in r.users">
                                                <td>{{u.name}} {{u.lastName}}</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                        <br>
                        <div ng-show="rooms_2.length>0">
                            <table border="1">
                                <tr>
                                    <td ng-repeat="r in rooms_1">{{r.room.number}}</td>
                                </tr>
                                <tr>
                                    <td ng-repeat="r in rooms_1">
                                        <table border="1">
                                            <tr ng-repeat="u in r.users">
                                                <td>{{u.name}} {{u.lastName}}</td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<script src="/resources/js/angularjs/1.7.9/angular.min.js"></script>
<script>
    angular.module('pralki', []).controller('roomManagement', function ($scope, $http, $location) {
        $scope.dorms = [];
        $scope.rooms = [];
        $scope.rooms_1 = [];
        $scope.rooms_2 = [];
        $http.get("/api/dorms").then(function (value) {
            $scope.dorms = value.data;
        });

        $scope.showRooms = function () {
            $http.get("/api/rooms/" + $scope.dorm + "/" + $scope.floor).then(function (value) {
                $scope.rooms = value.data;
                if ($scope.rooms.length > 13) {
                    for (i = 0; i < 13; i++) {
                        $scope.rooms_1[i] = $scope.rooms[i];
                    }
                    $scope.j = 0;
                    for (i = 13; i < $scope.rooms.length; i++) {
                        $scope.rooms_2[j] = $scope.rooms[i];
                        $scope.j++;
                    }
                } else {
                    $scope.rooms_1 = $scope.rooms;
                }
            });
        };
    });
</script>
</body>
</html>