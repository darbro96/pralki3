<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Panel administracji</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/administrationPanel.css" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
</head>
<body>
<%@include file="/WEB-INF/incl/menu.app" %>
<div class="container-fluid p-0">
    <div class="row m-0">
        <%@include file="/WEB-INF/incl/panel_admin.app" %>
        <div class="col-sm-10 padm shadow bg-light" id="content">
            <div class="p-1" id="title">
                <h1>Panel główny</h1>

                <br>
                <div class="card">
                    <div class="card-header"><h5>Osoby z zablokowanym kontem <span
                            class="badge badge-warning"> ! </span></h5>
                    </div>
                    <div class="card-body">
                        <div class="table-responsive">
                            <table class="table table-striped">
                                <thead>
                                <tr>
                                    <th>Imię</th>
                                    <th>Nazwisko</th>
                                    <th>Pokój</th>
                                    <th>Czy oddano klucz do pralki?</th>
                                    <th></th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach var="u" items="${unactiveUsers}">
                                    <tr>
                                        <td>${u.name}</td>
                                        <td>${u.lastName}</td>
                                        <td>${u.room.number}</td>
                                        <c:choose>
                                            <c:when test="${u.keptKey}">
                                                <td class="text-danger">
                                                    NIE
                                                </td>
                                            </c:when>
                                            <c:otherwise>
                                                <td class="text-success">
                                                    TAK
                                                </td>
                                            </c:otherwise>
                                        </c:choose>
                                        <td>
                                            <button onclick="window.location.href='${pageContext.request.contextPath}/activateuser/${u.idUser}'"
                                                    class="btn btn-outline-primary">Odblokuj
                                            </button>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>


        </div>
    </div>
</div>

</div>


</body>
</html>