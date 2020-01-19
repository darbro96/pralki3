<sec:authorize access="hasRole('ROLE_USER')">
<%@include file="/WEB-INF/incl/menu_user.app" %>
</sec:authorize>
<sec:authorize access="hasRole('ROLE_ADMIN')">
<%@include file="/WEB-INF/incl/menu_admin.app" %>
</sec:authorize>