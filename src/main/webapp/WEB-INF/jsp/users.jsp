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
    <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.7.0/css/all.css"
          integrity="sha384-lZN37f5QGtY3VHgisS14W3ExzMWZxybE1SJSEsQp9S+oqd12jhcu+A56Ebc1zFSJ" crossorigin="anonymous">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <script type="text/javascript">
        function startSerach(pParam) {
            var searchWord = document.getElementById('searchString').value;
            var page = parseInt(document.getElementById('cp').value) + parseInt(pParam);
            if (searchWord.length < 1) {
                document.getElementById("errorSearch").innerHTML = "<s:message code="error.searchString.toShort"/>";
                return false;
            } else {
                document.getElementById("errorSearch").innerHTML = "";
                var searchLink = '${pageContext.request.contextPath}/users/search/' + searchWord + '/' + page;
                window.location.href = searchLink;
            }
        }
    </script>
</head>
<body>
<%@include file="/WEB-INF/incl/menu.app" %>
<div>
    <h1>Lista użytkowników</h1>
    <c:set var="count" value="0" scope="page"/>
    <input type="hidden" name="cp" id="cp" value="${currentPage}"/>
    <input type="text" id="searchString"/>&nbsp;&nbsp;<input type="button" id="buttonSearch"
                                                             value="<s:message code="button.search"/>"
                                                             onclick="startSerach(0);"/><br/>
    <span id="errorSearch" style="color: red;"></span>
    <table border="1" cellpadding="6" cellspacing="0">
        <tr align="center">
            <td>Id</td>
            <td>Imie</td>
            <td>Nazwisko</td>
            <td>Email</td>
            <td>Czy aktywny?</td>
            <td>Rola</td>
            <td>Akademik</td>
            <td>Karta</td>
        </tr>
        <c:forEach var="u" items="${users}">
            <c:set var="count" value="${count+1}" scope="page"/>
            <tr>
                <td><c:out value="${u.idUser}"/></td>
                <td><c:out value="${u.name}"/></td>
                <td><c:out value="${u.lastName}"/></td>
                <td><c:out value="${u.email}"/></td>
                <td>
                    <c:choose>
                        <c:when test="${u.active==1}">
                            <font color="green">TAK</font>
                        </c:when>
                        <c:otherwise>
                            <font color="red">NIE</font>
                        </c:otherwise>
                    </c:choose>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${u.nrRoli==1}">
                            Administrator
                        </c:when>
                        <c:otherwise>
                            Użytkownik
                        </c:otherwise>
                    </c:choose>
                </td>
                <td><c:out value="${u.dormitory.name}"/></td>
                <td><c:out value="${u.cardId}"/></td>
                <td>
                    <button onclick="window.location.href='${pageContext.request.contextPath}/edituser/${u.idUser}'">
                        Edytuj
                    </button>&nbsp;
                    <c:if test="${u.nrRoli==2}">
                        <button onclick="window.location.href='${pageContext.request.contextPath}/deleteuser/${u.idUser}'">
                            Usuń
                        </button>
                        &nbsp
                        <c:if test="${u.active==1}">
                            <button onclick="window.location.href='${pageContext.request.contextPath}/deactivateuser/${u.idUser}'">
                                Dezaktywuj
                            </button>
                        </c:if>
                        <c:if test="${u.active==0}">
                            <button onclick="window.location.href='${pageContext.request.contextPath}/activateuser/${u.idUser}'">
                                Aktywuj
                            </button>
                        </c:if>
                    </c:if>
                    <c:if test="${u.cardId==null}">
                        <button onclick="window.location.href='${pageContext.request.contextPath}/assigncard/${u.idUser}'">
                            Przypisz kartę
                        </button>
                    </c:if>
                    <c:if test="${u.cardId!=null}">
                        <button onclick="window.location.href='${pageContext.request.contextPath}/unassigncard/${u.idUser}'">
                            Usuń kartę
                        </button>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>
    <c:if test="${currentPage>1}">
        <input type="button" onclick="window.location.href='${pageContext.request.contextPath}/users/${currentPage-1}'"
               value="Poprzedni">&nbsp;&nbsp;
    </c:if>
    <c:if test="${currentPage<totalPages}">
        <input type="button" onclick="window.location.href='${pageContext.request.contextPath}/users/${currentPage+1}'"
               value="Następny">
    </c:if>
</div>
</body>
</html>