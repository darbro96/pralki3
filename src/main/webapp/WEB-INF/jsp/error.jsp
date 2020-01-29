<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="s" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="pl">
<head>
    <meta charset="UTF-8">
    <title>Błąd</title>
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
</head>
<body class="bg-secondary">
<div class="container-fluid bg-secondary h-100">
    <div class="container bg-light mx-auto mt-5 p-5 text-center"><img src="/resources/img/blad2.png"
                                                                      class="img-fluid m-5" width="200px">
        <h1>Ooops! Coś poszło nie tak...</h1>
        <button type="button" class="btn btn-info btn-lg m-5"
                onclick="window.location.href='${pageContext.request.contextPath}/panel'"><h3>Powrót na stronę
            główną</h3></button>
    </div>
</div>
</body>
</html>