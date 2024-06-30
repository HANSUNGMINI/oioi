<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet" >
</head>
<body>
<form action="updateAPD" method="post">
<select name="APD_STATUS">
	<c:forEach var="item" items="${apdStatusSelectBox}">
		<option value="${item.code}" <c:if test="${item.value eq product.APD_STATUS}"> selected</c:if>> ${item.value} </option>
	</c:forEach>
	
</select>
<select name="APD_REJECTION">
	<c:forEach var="item" items="${apdRejectionSelectBox}">
		<option value="${item.code }" <c:if test="${item.value eq product.APD_REJECTION}"> selected</c:if>> ${item.value }</option>
	</c:forEach>
</select>
<input type="submit" value="수정하기">
</form>

</body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</html>