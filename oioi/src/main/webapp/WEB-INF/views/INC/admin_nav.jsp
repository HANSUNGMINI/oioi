<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
	$(document).ready(function() {
		var socket = new WebSocket('ws://localhost:8081/oi/push');
	    socket.onmessage = function(event) {
	    	alert(event.data);
	    };
	});

</script>
<body>
	<nav id="navbar-main" class="navbar is-fixed-top">
		<div class="navbar-brand">
			<a class="navbar-item mobile-aside-button">
	      		<span class="icon"><i class="mdi mdi-forwardburger mdi-24px"></i></span>
	   		</a>
	  	</div>
		<div class="navbar-brand is-right">
			<a class="navbar-item --jb-navbar-menu-toggle" data-target="navbar-menu">
				<span class="icon"><i class="mdi mdi-dots-vertical mdi-24px"></i></span>
		  </a>
		</div>
		<div class="navbar-menu" id="navbar-menu">
		
		<p id="p">접속중인 계정 : 바로 나야 ㅋ / 현재 접속중인 유저 수 /</p> 
		
			<div class="navbar-end">
		    	<div class="navbar-item dropdown has-divider">
		      		<a class="navbar-link">
			        	<span class="icon"><i class="mdi mdi-menu"></i></span>
			        	<span>${admin.AD_NAME}</span>
			        	<span class="icon"><i class="mdi mdi-chevron-down"></i></span>
		      		</a>
		      		<div class="navbar-dropdown">
		        		<hr class="navbar-divider">
		        		<a href="logout" class="navbar-item">
		          			<span class="icon"><i class="mdi mdi-logout"></i></span>
		          			<span>Log Out</span>
		        		</a>
		      		</div>
		    	</div>
		  </div>
		</div>
	</nav>
</body>
</html>