<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/regist_success.css" rel="stylesheet">
<meta charset="UTF-8">
<title>회원가입 완료</title>
</head>
<body>
<div id="holder">
	<h1 style="color:#00AAFF;">회원가입 완료</h1>
	<h3 class="id_check">${member_id}님으로 회원가입이 완료되었습니다.</h3>
	<div class="button">
	    <p class="btnText" >로그인하기</p>
	    <div class="btnTwo">
	      <p class="btnText2" onclick="location.href='login'">GO!</p>
	    </div>
	 </div>
	<div class="button">
	    <p class="btnText">메인페이지로</p>
	    <div class="btnTwo">
	      <p class="btnText2"onclick="location.href='./'">GO!</p>
	    </div>
	 </div>
</div>
</body>
</html>