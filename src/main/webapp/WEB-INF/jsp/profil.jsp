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
    <link rel="stylesheet" href="resources/css/administrationPanel.css" type="text/css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
</head>
<body>
<%@include file="/WEB-INF/incl/menu.app" %>
<div class="container text-center">
    <h1>Twój profil</h1><br>
    <%--    <p>E-mail:&nbsp;&nbsp;<b><c:out value="${user.email}"/> </b></p>--%>
    <%--    <p>Imię:&nbsp;&nbsp;<b><c:out value="${user.name}"/> </b></p>--%>
    <%--    <p>Nazwisko:&nbsp;&nbsp;<b><c:out value="${user.lastName}"/> </b></p>--%>
    <%--    <p>Czy aktywny?&nbsp;&nbsp;--%>
    <%--        <c:choose>--%>
    <%--            <c:when test="${user.active==1}"><font color="green">TAK</font></c:when>--%>
    <%--            <c:otherwise><font color="green">NIE</font></c:otherwise>--%>
    <%--        </c:choose>--%>
    <%--    </p>--%>
    <%--    <p>Rola:&nbsp;&nbsp;--%>
    <%--        <c:choose>--%>
    <%--            <c:when test="${user.nrRoli==1}">Administrator</c:when>--%>
    <%--            <c:otherwise>Użytkownik</c:otherwise>--%>
    <%--        </c:choose>--%>
    <%--    </p>--%>
    <%--    <p>Akademik:--%>
    <%--        <c:choose>--%>
    <%--            <c:when test="${user.dormitory.name==null}">Nie zdefiniowano</c:when>--%>
    <%--            <c:otherwise><c:out value="${user.dormitory.name}"/> </c:otherwise>--%>
    <%--        </c:choose>--%>
    <%--    </p>--%>
    <%--    <p>--%>
    <%--        <c:if test="${user.room!=null}">--%>
    <%--            Pokój: ${user.room.number}--%>
    <%--        </c:if>--%>
    <%--    </p>--%>

    <div class="card-body">
        <div class="table-responsive">
            <table class="table table-striped">
                <tbody>
                <tr>
                    <td>E-mail</td>
                    <td><b><c:out value="${user.email}"/> </b></td>
                </tr>
                <tr>
                    <td>Imię</td>
                    <td><b><c:out value="${user.name}"/> </b></td>
                </tr>
                <tr>
                    <td>Nazwisko</td>
                    <td><b><c:out value="${user.lastName}"/></td>
                </tr>
                <tr>
                    <td>Rola</td>
                    <td>
                        <b>
                            <c:choose>
                                <c:when test="${user.nrRoli==1}">Administrator</c:when>
                                <c:otherwise>Użytkownik</c:otherwise>
                            </c:choose>
                        </b>
                    </td>
                </tr>
                <tr>
                    <td>Akademik</td>
                    <td>
                        <b>
                            <c:choose>
                                <c:when test="${user.dormitory.name==null}">Nie zdefiniowano</c:when>
                                <c:otherwise><c:out value="${user.dormitory.name}"/> </c:otherwise>
                            </c:choose>
                        </b>
                    </td>
                    </td>
                </tr>
                <c:if test="${user.room!=null}">
                    <tr>
                        <td>Pokój:</td>
                        <td><b>${user.room.number}</b></td>
                    </tr>
                </c:if>
                </tbody>
            </table>
            <p>
                <button onclick="window.location.href='${pageContext.request.contextPath}/editpassword'">Zmiana hasła
                </button>
            </p>
        </div>
    </div>
</div>
</body>
</html>