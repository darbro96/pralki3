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
    <link rel="stylesheet" type="text/css" href="/resources/css/_style.css" />
    <title><s:message code="logowanie.pageName" /></title>
</head>

<body onLoad="clearForms()" onUnload="clearForms()">

<div class="container">
    <sec:authorize access="hasRole('ANONYMOUS')">
    <form id="loginForm" method="post" action="/login">
        <h1><img src="/resources/img/logo.png" width="60">Panel logowania</h1>
        <c:if test="${not empty param.error}">
            <font color="red"><s:message code="error.logowanie"/></font>
        </c:if>
        <input placeholder="login" type="text" required="" name="email" id="email">
        <input placeholder="hasło" type="password" required="" name="password" id="password">

        <input type="submit" value="Zaloguj"/>
        <a href="/help">
        <div class="pomoc"> Jak uzyskać/odzyskać dostęp?</div></a>

    </form>
    </sec:authorize>
</div>
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