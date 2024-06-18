<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="${pageContext.request.contextPath}/resources/css/regist_success.css" rel="stylesheet">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<title>회원가입 완료</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script src="${pageContext.request.contextPath}/resources/js/confetti_v2.js"></script>
</head>
<style>
	canvas{z-index:10;pointer-events: none;position: fixed;top: 0;transform: scale(1.1);}
 .buttonContainer {
        display: none;
    }

</style>
<body>

<div class="buttonContainer">
	<button class="canvasBtn" id="stopButton">Stop Confetti</button>
	<button class="canvasBtn" id="startButton">Drop Confetti</button>	
</div>

<canvas id="canvas"></canvas>

<img class="success_img" src="${pageContext.request.contextPath}/resources/images/logo.png" alt="logo" style="display: block;">
<div id="holder">
	<h1 style="color:#34A853;">회원가입 완료</h1>
	<h3 class="id_check">${US_NICK}님의 회원가입을 축하합니다.</h3>
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
<script>
$(document).ready(function(){  
	  function reAction(){
	  	$("#startButton").trigger("click");
	  	setTimeout(function(){
	  		$("#stopButton").trigger("click");
	  	}, 6000);
	  }
      reAction();
	});
</script>
</html>