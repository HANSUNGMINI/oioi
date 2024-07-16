<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 추가</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
<script>

function addAdmin(){
	$.ajax({
		type : "POST",
		url : "addAdmin",
		data : $("#form").serialize(),
		dataType : "JSON",
		success : function(response){
			if (response > 0) {
				window.opener.location.reload();
				window.close();
			}
		}
	}); // ajax
	
}
</script>
</head>
<body>
	<div>
		<form id="form">
			<input type="text" name="AD_NAME"placeholder="관리자 이름">		
			<input type="text" name="AD_ID" placeholder="아이디">		
			<input type="password" name="AD_PW"placeholder="사용할 비밀번호">
			<select name="RL_TYPE">
        		<c:forEach var="role" items="${roleSelectBox}">
        			<option value="${role.code}"> ${role.value}</option>
        		</c:forEach>
        	</select>
        	<input type="button" value="등록" onclick="addAdmin()">
        	<input type="button" value="취소" onclick="window.close()">
		</form>
	</div>
</body>
</html>