<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="sec"
           uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <link rel="stylesheet" href="resources/css/loginPage.css" type="text/css">
    <title><s:message code="logowanie.pageName" /></title>
</head>

<%--<body onLoad="clearForms()" onUnload="clearForms()">--%>

<%--<div class="container">--%>
<%--    <sec:authorize access="hasRole('ANONYMOUS')">--%>
<%--    <form id="loginForm" method="post" action="/login">--%>
<%--        <h1><img src="/resources/img/logo.png" width="60">Panel logowania</h1>--%>
<%--        <c:if test="${not empty param.error}">--%>
<%--            <font color="red"><s:message code="error.logowanie"/></font>--%>
<%--        </c:if>--%>
<%--        <input placeholder="login" type="text" required="" name="email" id="email">--%>
<%--        <input placeholder="hasło" type="password" required="" name="password" id="password">--%>

<%--        <input type="submit" value="Zaloguj"/>--%>
<%--        <a href="/help">--%>
<%--        <div class="pomoc"> Jak uzyskać/odzyskać dostęp?</div></a>--%>

<%--    </form>--%>
<%--    </sec:authorize>--%>
<%--</div>--%>

<%--</body>--%>

<body class="bg-dark" onLoad="clearForms()" onUnload="clearForms()">

<div class="container">
    <div class="row align-items-center justify-content-center" style="height: 100vh;">
        <div class="col-lg-6 col-md-12 align-items-center justify-content-center p-3">
            <form class="card p-4 bg-light" id="loginForm" method="post" action="/login">
                <div class="card-header border-bottom-0 bg-light">
                    <img src="resources/img/logo_header.png" class="img-fluid mx-auto d-block">
                </div>
                <div class="card-body">
                    <c:if test="${not empty param.error}">
                        <p class="text-danger text-center"><s:message code="error.logowanie"/></p>
                    </c:if>
                    <div class="form-group">
                        <label>Login:</label>
                        <input type="email" name="email" required class="form-control" />
                    </div>
                    <div class="form-group">
                        <label>Hasło:</label>
                        <input type="password" name="password" required class="form-control" />
                    </div>
                </div>
                <div class="card-footer border-top-0 bg-light">
                    <button type="submit" class="btn btn-danger btn-block">Zaloguj</button>
                </div>
            </form>
        </div>
    </div>
</div>




<script src="https://code.jquery.com/jquery-3.4.1.slim.min.js" integrity="sha384-J6qa4849blE2+poT4WnyKhv5vZF5SrPo0iEjwBvKU7imGFAV0wwj1yYfoRSJoZ+n" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.0/dist/umd/popper.min.js" integrity="sha384-Q6E9RHvbIyZFJoft+2mJbHaEWldlvI9IOYy5n3zV9zzTtmI3UksdQRVvoxMfooAo" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js" integrity="sha384-wfSDF2E50Y2D1uUdj0O3uMBJnjuUD4Ih7YwaYd1iqfktj0Uod8GCExl3Og8ifwB6" crossorigin="anonymous"></script>
<script type="text/javascript">
    function clearForms()
    {
        var i;
        for (i = 0; (i < document.forms.length); i++) {
            document.forms[i].reset();
        }
    }
</script>
</body>

</html>