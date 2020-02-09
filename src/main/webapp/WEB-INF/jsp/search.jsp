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
    <title>Panel recepcji - SODS</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <link rel="stylesheet" href="/resources/css/mainPanel.css" type="text/css">
</head>
<body class="bg-background" ng-app="pralki" ng-controller="usersContr">
<nav class="navbar navbar-expand-md bg-green navbar-dark navbar-main" id="navbar-main">

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
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/panel'"><i class="fas fa-user-check"></i>
                        Weryfikuj
                    </button>
                    <button type="button" class="btn btn-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/reception/search'"><i
                            class="fas fa-search"></i>
                        Wyszukaj
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/reception/reservations'">
                        <i
                                class="far fa-calendar-check"></i> Rezerwacje
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/reception/faults'"><i
                            class="far fa-registered"></i> Usterki
                    </button>
                    <button type="button" class="btn btn-outline-secondary font-weight-bold"
                            onclick="window.location.href='${pageContext.request.contextPath}/reception/activity'"><i class="fas fa-user-cog"></i> Profil
                    </button>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="container-fluid p-4">

    <div class="container-fluid bg-white border p-5">
        <h3><i class="fas fa-search"></i> Wyszukaj mieszkańca</h3>
        <input class="form-control form-control-lg mt-4" type="text"
               placeholder="Wpisz imię, nazwisko lub numer pokoju..." ng-model="par" ng-change="search()" autofocus>
        <br>

        <div class="table-responsive" ng-show="!showProfil && !showRoom">
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
                    <td>
                        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal"
                                ng-click="setUserToModal(u)">
                            Powiadom
                        </button>
                    </td>
                </tr>
                </tbody>
            </table>
        </div>

        <!-- The Modal -->
        <div class="modal fade" id="myModal" role="dialog" ng-keydown="$event.keyode === 13">
            <div class="modal-dialog modal-xl">
                <div class="modal-content">


                    <!-- Modal body -->
                    <div class="modal-body">
                        <h3 class="text-center pt-4">Wyślij powiadomienie</h3>
                        <h4 class="text-center">dla {{userToModal.name}} {{userToModal.lastName}}</h4>

                        <div class="d-flex flex-row">
                            <button type="button" class="btn btn-outline-info btn-lg flex-fill m-2 p-4"
                                    ng-click="sendNotification(userToModal.idUser,1)">
                                <h5><i class="far fa-envelope"></i><br>List</h5>
                            </button>
                            <button type="button" class="btn btn-outline-info btn-lg flex-fill m-2 p-4"
                                    ng-click="sendNotification(userToModal.idUser,2)">
                                <h5><i class="fas fa-box-open"></i><br>Paczka</h5>
                            </button>
                            <button type="button" class="btn btn-outline-info btn-lg flex-fill m-2 p-4"
                                    ng-click="showFormAct()">
                                <h5><i class="far fa-bell"></i><br>Komunikat</h5>
                            </button>

                        </div>
                        <div class="container" ng-show="showForm">
                            <sf:form id="otherNotification" action="/sendothernotification"
                                     modelAttribute="notification" enctype="multipart/form-data" method="POST">
                                <div class="form-group">
                                    <label for="rola">Treść powiadomienia:</label>
                                    <sf:textarea path="content" id="rola" class="form-control"/>
                                    <sf:input path="idUser" ng-model="idUser" readonly="false" class="form-control"
                                              ng-hide="true"/>
                                    <input type="submit" value="Wyślij komunikat" class="form-control btn btn-success"/>
                                </div>
                            </sf:form>
                        </div>
                        <div class="alert alert-success alert-dismissible" ng-show="sendSuccess">
                            <button type="button" class="close" data-dismiss="alert">&times</button>
                            <strong>Sukces!</strong> Usterka zgłoszona
                        </div>

                    </div>

                    <!-- Modal footer -->
                    <div class="modal-footer">
                        <button type="button" class="btn btn-danger btn-block" data-dismiss="modal"
                                ng-click="hideForm()">Anuluj
                        </button>
                    </div>

                </div>
            </div>
        </div>

        <div class="container-fluid border m-0" ng-show="showProfil">
            <div class="row align-items-center">
                <div class="col-md-6 p-4">
                    <img class="p-4 mx-auto d-block img-fluid img-rounded"
                         src="/userimage/{{vUsers[0].idUser}}.png"
                         alt="Brak zdjęcia" width="220px">
                </div>
                <div class="col-md-6 p-4 text-center">
                    <h1>{{vUsers[0].name}}</h1>
                    <h1>{{vUsers[0].lastName}}</h1><br>
                    <h1>{{vUsers[0].room.number}}</h1>
                    <div ng-show="vUsers[0].keptKey">
                        PRZETRZYMUJE KLUCZ DO PRALKI!
                        <button ng-click="userReturnKey(vUsers[0].idUser)">
                            ZWROT KLUCZA
                        </button>
                    </div>
                    <div ng-show="vUsers[0].active==0">
                        ZABLOKOWANE KONTO
                    </div>
                    <%--                    <h1><span class="badge badge-success">Brak powiadomień</span></h1>--%>

                </div>
            </div>
        </div>

        <div class="d-flex flex-row" ng-show="showRoom">
            <div class="card flex-fill" ng-repeat="r in residents">
                <img class="p-4 mx-auto d-block img-fluid" src="/userimage/{{r.idUser}}.png"
                     alt="Brak zdjęcia" width="220px">
                <div class="card-body">
                    <h4 class="card-title text-center">{{r.name}} {{r.lastName}}</h4>
                    <div ng-show="r.keptKey">
                        PRZETRZYMUJE KLUCZ!
                        <button ng-click="userReturnKey(r.idUser)">
                            ZWROT KLUCZA
                        </button>
                    </div>
                    <div ng-show="r.active==0">
                        ZABLOKOWANE KONTO
                    </div>
                </div>
            </div>
            <%--            <div class="card flex-fill">--%>
            <%--                <img class="card-img-top p-4 mx-auto d-block img-fluid" src="img_avatar1.png"--%>
            <%--                     alt="Card image">--%>
            <%--                <div class="card-body">--%>
            <%--                    <h4 class="card-title text-center">Tomek Tomczak</h4>--%>
            <%--                </div>--%>
            <%--            </div>--%>
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
    angular.module('pralki', []).controller('usersContr', function ($scope, $http, $location) {
        $scope.vUsers = [];
        $scope.showProfil = false;
        $scope.rooms = [];
        $scope.showRoom = false;
        $scope.userToModal = null;
        $scope.buttonsDisable = "";
        $scope.showForm = false;
        $scope.sendSuccess=false;
        $http.get("/api/reception/users/${loggedUser.dormitory.name}").then(function (value) {
            $scope.users = value.data;
        });
        $http.get("/api/rooms/${loggedUser.dormitory.name}").then(function (value) {
            $scope.rooms = value.data;
        });

        $scope.search = function () {
            text = $scope.par;
            $scope.vUsers = [];
            $scope.residents = [];
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
                    if ($scope.users[i].name.toLowerCase().includes($scope.par.toLowerCase()) || $scope.users[i].lastName.toLowerCase().includes($scope.par.toLowerCase()) || nr.toLowerCase().includes($scope.par.toLowerCase())) {
                        $scope.vUsers[j] = $scope.users[i];
                        j++;
                    }
                    if (card === $scope.par) {
                        $scope.showProfil = true;
                        $scope.vUsers = [];
                        $scope.vUsers[0] = $scope.users[i];
                        break;
                    } else {
                        $scope.showProfil = false;
                        $scope.showRoom = false;
                    }
                }
                if ($scope.vUsers.length == 0) {
                    $scope.residents = [];
                    var k = 0;
                    for (i = 0; i < $scope.rooms.length; i++) {
                        if ($scope.rooms[i].idCard === $scope.par) {
                            $http.get("/api/usersfromroom/${loggedUser.dormitory.name}/" + $scope.rooms[i].number).then(function (value) {
                                $scope.residents = value.data;
                            });
                            $scope.showRoom = true;
                            break;
                        }
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
            };
        };

        $scope.setUserToModal = function (u) {
            $scope.userToModal = u;
            $scope.idUser = $scope.userToModal.idUser;
        };

        $scope.sendNotification = function (u, t) {
            $scope.buttonsDisable = "disabled";
            console.log("Sending message... ");
            $http.post("/api/sendnotification/" + u + "/" + t).then(function (value) {
                console.log("success", value);
            }), function (err) {
                console.log("error", err);
            };
            $scope.buttonsDisable = "";
            $scope.showForm = false;
            $scope.sendSuccess=true;
        };

        $scope.showFormAct = function () {
            $scope.showForm = true;
        };

        $scope.hideForm = function () {
            $scope.showForm = false;
        };

        $scope.userReturnKey = function (id) {
            window.location.href = '${pageContext.request.contextPath}/deletekeyretention/' + id;
        };

    });
</script>
</body>
</html>