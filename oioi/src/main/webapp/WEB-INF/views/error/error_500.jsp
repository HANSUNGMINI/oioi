<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 외부 CSS 파일 연결하기(css/default.css) --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body>
<!-- 	<header> -->
<%-- 		<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/INC/top.jsp"></jsp:include> --%>
<!-- 	</header> -->
	<article>
		<h3>죄송합니다.<br>일시적인 오류가 발생하였습니다.</h3>
		<h3>잠시 후 다시 접속하여 주시기 바랍니다.</h3>
	</article>
<!-- 	<footer> -->
<%-- 		<jsp:include page="${pageContext.request.contextPath}/WEB-INF/views/INC/bottom.jsp"></jsp:include> --%>
<!-- 	</footer> -->
</body>
</html>










