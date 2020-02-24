<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Rezerwacja</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/incl/menu_user.app" %>
<h1>Rezerwacja pralki</h1>
<p><font color="red"><sf:errors path="start"/><c:out value="${message }"/></font> </p>
<sf:form  id="usersForm" action="bookwasheraction" modelAttribute="reservation" enctype="multipart/form-data" method="POST">
    <sf:hidden path="username" value="${loggedUser.email}"/>
    Krok 1. Wybierz datę.<br>
    <img src="resources/img/kal.png"><sf:input type="date" path="dateStart" min="${today}" max="${max}"/> Maksymalnie 8 dni później<br>
    Krok 2. Wybierz godzinę<br>
    <img src="resources/img/zeg.png"><sf:input path="timeStart" type="time" min="06:00" max="21:00" step="1800" /> Między 6:00 a 21:00<br>
    Krok 3. Wybierz pralkę<br>
    Pralka:
    <sf:select path="washerId">
        <sf:option value="NONE" label="--- Wybierz ---"/>
        <c:forEach var="o" items="${washers}">
            <sf:option value="${o.idWasher}" label="${o.numberWasher} (pralnia ${o.laundry.numberLaundry})"/>
        </c:forEach>
    </sf:select>
    <br>Krok 4. Wybierz czas trwania rezerwacji
    <br>Czas trwania
    <sf:select path="duration">
        <sf:option value="2" label="2 godziny" />
        <sf:option value="3" label="3 godziny" />
        <sf:option value="4" label="4 godziny" />
    </sf:select>
    <br>Krok 5. Kliknij przycisk "Rezerwacja" (w przypadku rezygnacji z rezerwacji kliknij przycisk "Zrezygnuj")
    <br>
    <input type="submit" value="Rezerwacja" class="formbutton"/>
    <input type="button" value="<s:message code="button.cancel"/>" class="formbutton"
           onclick="window.location.href='${pageContext.request.contextPath}/'"/>
</sf:form >
</body>
</html>