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
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="/resources/css/administrationPanel.css" type="text/css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <title>Edytuj pokój</title>
</head>
<body>
<%@include file="/WEB-INF/incl/menu.app" %>

<div class="container-fluid p-0">
    <div class="row m-0">
        <%@include file="/WEB-INF/incl/panel_admin.app" %>
        <div class="col-sm-9 col-md-10   padm shadow bg-light" id="content">
            <div class="p-1" id="title">
                <h2>Edycja pokoju</h2>
                <p><c:out value="${message }"/></p>
                <sf:form id="usersForm" action="/editroomaction" modelAttribute="room" enctype="multipart/form-data"
                         method="POST">
                    <div class="form-group">
                        <label for="number">Numer pokoju:</label>
                        <sf:input path="number" class="form-control" id="number"/>
                        <sf:hidden path="idRoom"/>
                        <font color="red"><sf:errors path="number"/></font>
                    </div>
                    <div class="form-group">
                        <label for="roomType">Typ pokoju:</label>
                        <sf:select path="idRoomType" class="form-control" id="roomType">
                            <c:forEach var="o" items="${roomTypes}">
                                <sf:option value="${o.idRoomType}" label="${o.type}"/>
                            </c:forEach>
                        </sf:select>
                    </div>
                    <div class="form-group">
                        <label for="dorm">Akademik:</label>
                        <sf:select path="nameOfDormitory" class="form-control" id="dorm">
                            <c:forEach var="o" items="${dormitories}">
                                <sf:option value="${o.name}" label="${o.name}"/>
                            </c:forEach>
                        </sf:select>
                    </div>
                    <div class="form-group">
                        <label for="capacity">Pojemność pokoju:</label>
                        <sf:input path="capacity" class="form-control" id="capacity"/>
                    </div>
                    <div class="form-group">
                        <label for="card">Identyfikator klucza:</label>
                        <sf:input path="idCard" class="form-control" id="card"/>
                    </div>
                    <div class="form-group">
                        <input type="submit" value="Aktualizuj" class="form-control"/>
                        <input type="button" value="<s:message code="button.cancel"/>" class="form-control"
                               onclick="window.location.href='${pageContext.request.contextPath}/panel'"/>
                    </div>
                </sf:form>
                <font color="red"><sf:errors path="name"/></font>
            </div>
        </div>
    </div>
</div>
</body>
</html>