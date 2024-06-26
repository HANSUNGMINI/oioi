<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<style>
	h1{background-color : #34A853;}
	
</style>
</head>
<body>
<div>
	<h1> 회원 상세 정보 </h1>
	<form>
		<table>
			<tr>
				<td> 프로필 이미지 </td>
				<td class="img"></td>
			</tr>	
			<tr style="display : flex;" >
				<td> 아이디(성별) </td>
				<td> ${user.US_ID } (${user.US_GENDER })</td>
			</tr>	
			<tr>
				<td> 이름(닉네임) </td>
				<td> ${user.US_NAME } (${user.US_NICK })</td>
			</tr>	
			<tr>
				<td> 연락처(이메일) </td>
				<td> ${user.US_PHONE } (${user.US_EMAIL})</td>
			</tr>	
			<tr>
				<td> 상태(플랫폼) </td>
				<td> ${user.US_STATUS } (${user.US_PLATFORM})</td>
			</tr>	
		</table>
	</form>
</div>
</body>
</html>