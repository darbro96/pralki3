<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Panel recepcji</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css" integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
<%--    <link rel="stylesheet" href="resources/css/receptionPanel.css" type="text/css">--%>
</head>
<body class="bg-light">
<nav class="navbar navbar-expand-sm bg-dark navbar-dark fixed-top">
    <a class="navbar-brand" href="#">Logo</a>
</nav>


<div class="container">
    <div class="row align-items-center justify-content-center pt-2" style="height: 100vh;">
        <div class="align-items-center justify-content-center">

            <div class="card-columns">
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="resources/img/1.png" class="img-fluid mx-auto d-block" >
                        <h4 class="card-text pt-2">Zgłoś awarie</h4>
                    </div>
                </div>
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="resources/img/2.png" class="img-fluid mx-auto d-block" >
                        <h4 class="card-text pt-2">Twoje zgłoszenia</h4>
                    </div>
                </div>
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="resources/img/3.png" class="img-fluid mx-auto d-block" >
                        <h4 class="card-text pt-2">Twoje zgłoszenia</h4>
                    </div>
                </div>
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="resources/img/4.png" class="img-fluid mx-auto d-block" >
                        <h4 class="card-text pt-2">Twoje zgłoszenia</h4>
                    </div>
                </div>
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="resources/img/5.png" class="img-fluid mx-auto d-block" >
                        <h4 class="card-text pt-2">Twoje zgłoszenia</h4>
                    </div>
                </div>
                <div class="card bg-white p-3">
                    <div class="card-body text-center">
                        <img src="resources/img/6.png" class="img-fluid mx-auto d-block" >
                        <h4 class="card-text pt-2">Twoje zgłoszenia</h4>
                    </div>
                </div>
            </div>

            <button type="button" class="btn btn-primary" data-toggle="modal" data-target="#myModal">
                Open modal
            </button>

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
    </div>
</div>



<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
</body>
</html>