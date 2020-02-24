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
    <title><s:message code="menu.register"/></title>
</head>
<body>
<%@include file="/WEB-INF/incl/menu.app" %>
<div class="container-fluid p-0">
    <div class="row m-0">
        <%@include file="/WEB-INF/incl/panel_admin.app" %>
        <div class="col-sm-9 col-md-10   padm shadow bg-light" id="content">
            <div class="p-1" id="title">

                <h2><s:message code="menu.register"/></h2>

                <p align="center">
                    <c:out value="${message }"/>
                </p>

                <sf:form id="usersForm" action="adduser" modelAttribute="user"
                         enctype="multipart/form-data" method="POST">

                <div id="tresc">
                    <div class="form-group">
                        <label for="usr">Imię:</label>
                        <sf:input path="name" type="text" class="form-control" id="usr"/>
                    </div>
                    <div class="form-group">
                        <label for="lName">Nazwisko:</label>
                        <sf:input path="lastName" type="text" class="form-control" id="lName"/>
                    </div>
                    <div class="form-group">
                        <label for="plec">Płeć:</label>
                        <sf:select path="sex" class="form-control" id="plec">
                            <sf:option value="K" label="Kobieta" />
                            <sf:option value="M" label="Mężczyzna" />
                        </sf:select>
                    </div>
                    <div class="form-group">
                        <label for="nat">Narodowość:</label>
                        <sf:select path="nationality" class="form-control" id="nat">
                            <sf:option value="PL" label="Polska" />
                            <sf:option value="Z" label="Zagraniczny" />
                        </sf:select>
                    </div>
                    <div class="form-group">
                        <label for="email">E-mail:</label>
                        <sf:input path="email" type="text" class="form-control" id="email"/>
                    </div>
                    <div class="form-group">
                        <label for="akademik">Akademik:</label>
                        <sf:select path="nameOfDormitory" class="form-control" id="akademik">
                            <c:forEach var="o" items="${dorms}">
                                <sf:option value="${o.name}" label="${o.name}"/>
                            </c:forEach>
                        </sf:select>
                    </div>
                    <div class="form-group">
                        <label for="room">Pokój:</label>
                        <sf:input path="numberOfRoom" type="text" class="form-control" id="room"/>
                    </div>
                    <div class="form-group">
                        <label for="rola">Rola:</label>
                        <sf:select path="nameOfRole" id="rola" class="form-control">
                            <sf:option value="NONE" label="--- Wybierz ---"/>
                            <c:forEach var="o" items="${roles}">
                                <sf:option value="${o.role}" label="${o.description}"/>
                            </c:forEach>
                        </sf:select>
                    </div>
                    <div class="form-group">
                        <label for="imgUsr">Zdjęcie:</label>
                        <input path="fileName" id="imgUsr" class="form-control" type="file" name="fileupload" />
                    </div>
                    <div class="form-group">
                        <input type="submit" value="<s:message code="button.register"/>" class="form-control"/>
                        <input type="button" value="<s:message code="button.cancel"/>" class="form-control"
                               onclick="window.location.href='${pageContext.request.contextPath}/'"/>
                    </div>

                    </sf:form>
                </div>
            </div>
        </div>
    </div>
</div>

</body>
</html>