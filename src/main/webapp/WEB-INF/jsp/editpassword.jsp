<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Pralki</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/administrationPanel.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/incl/menu.app" %>
<div class="container-fluid p-0">
    <div class="row m-0">
        <sec:authorize access="hasRole('ROLE_ADMIN')">
        <%@include file="/WEB-INF/incl/panel_admin.app" %>
        <div class="col-sm-9 col-md-10   padm shadow bg-light" id="content">
            </sec:authorize>
            <sec:authorize access="hasRole('ROLE_USER')">
            <div class="col-sm-9 col-md-12   padm shadow bg-light" id="content">
                </sec:authorize>
                <div class="p-1" id="title">
                    <h2>Zmiana hasła</h2>
                    <p><c:out value="${message}"/></p>
                    <sf:form id="usersForm" action="updatepass" modelAttribute="user" enctype="multipart/form-data"
                             method="POST">
                        <sf:hidden path="email"/>
                        <div id="tresc">
                            <p>Nowe hasło:&nbsp;&nbsp;<sf:password path="newPassword" class="form-control"/></p>
                        </div>
                        <font color="red"> <sf:errors path="newPassword"/></font>
                        <input type="submit" value="Zmiana hasła" class="btn btn-outline-primary">
                        <input class="btn btn-outline-primary" type="button" value="Rezygnacja"
                               onclick="window.location.href='${pageContext.request.contextPath}/profil'">
                    </sf:form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>