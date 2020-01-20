<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Panel recepcji</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <link rel="stylesheet" href="resources/css/receptionPanel.css" type="text/css">
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-md bg-university navbar-dark sticky-top" id="navbar-main">
    <!-- Brand -->
    <a class="navbar-brand font-weight-bold" href="#"><i class="fas fa-home"></i> Panel recepcji</a>

    <!-- Toggler/collapsibe Button -->
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#collapsibleNavbar">
        <span class="navbar-toggler-icon"></span>
    </button>


    <div class="collapse navbar-collapse" id="collapsibleNavbar">

        <ul class="navbar-nav ml-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbardrop" data-toggle="dropdown">
                    Zalogowany jako: <b>Damian Gmys</b>
                </a>
                <div class="dropdown-menu">
                    <a class="dropdown-item" href="#">Twój profil</a>
                    <a class="dropdown-item" href="#">Zgłoś błąd</a>
                    <a class="dropdown-item bg-gold" href="#">Wyloguj <i class="fas fa-lock"></i></a>
                </div>
            </li>
        </ul>
    </div>
</nav>


<div class="container pt-5">
    <ul class="nav nav-tabs nav-justified">
        <li class="nav-item">
            <a class="nav-link active" href="#"><img src="resources/img/004-wrench-1.png" class="img-fluid mx-auto d-block" ><h5 class=" pt-2">Zgłoś awarie</h5></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><img src="resources/img/006-washer.png" class="img-fluid mx-auto d-block" ><h5 class=" pt-2">Rezerwój pralkę</h5></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><img src="resources/img/004-wrench-1.png" class="img-fluid mx-auto d-block" ><h5 class=" pt-2">Główna</h5></a>
        </li>
        <li class="nav-item">
            <a class="nav-link" href="#"><img src="resources/img/003-shield.png" class="img-fluid mx-auto d-block" ><h5 class=" pt-2">Twój profil</h5></a>
        </li>
    </ul>
    <div class="container bg-white border border-top-0">
        <h2>Form control: select</h2>
        <p>The form below contains two dropdown menus (select lists):</p>
        <form action="/action_page.php">
            <div class="form-group">
                <label for="sel1">Select list (select one):</label>
                <select class="form-control" id="sel1" name="sellist1">
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                </select>
                <br>
                <label for="sel2">Mutiple select list (hold shift to select more than one):</label>
                <select multiple class="form-control" id="sel2" name="sellist2">
                    <option>1</option>
                    <option>2</option>
                    <option>3</option>
                    <option>4</option>
                    <option>5</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Submit</button>
        </form>
    </div>

    <!--        <div class="card-columns">
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="img/004-wrench-1.png" class="img-fluid mx-auto d-block" >
                        <h5 class=" pt-2">Zgłoś awarie</h5>
                    </div>
                </div>
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="img/006-washer.png" class="img-fluid mx-auto d-block" >
                        <h5 class=" pt-2">Twoje zgłoszenia</h5>
                    </div>
                </div>
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="img/006-washer.png" class="img-fluid mx-auto d-block" >
                        <h5 class=" pt-2">Zarezerwój pranie</h5>
                    </div>
                </div>
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="img/004-wrench-1.png" class="img-fluid mx-auto d-block" >
                        <h4 class=" pt-2">Twoje zgłoszenia</h4>
                    </div>
                </div>
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="img/003-shield.png" class="img-fluid mx-auto d-block" >
                        <h4 class=" pt-2">Twoje zgłoszenia</h4>
                    </div>
                </div>
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="img/003-shield.png" class="img-fluid mx-auto d-block" >
                        <h4 class=" pt-2">Twoje zgłoszenia</h4>
                    </div>
                </div>
            </div>

        <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
            Open modal
        </button> -->

    <!-- The Modal -->
    <div class="modal fade" id="myModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">

                <!-- Modal Header -->
                <div class="modal-header">
                    <h4 class="modal-title">Modal Heading</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <!-- Modal body -->
                <div class="modal-body">
                    Modal body..
                </div>

                <!-- Modal footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>


</div>




<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>