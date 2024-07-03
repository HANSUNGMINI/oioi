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

        socket.onopen = function() {
            console.log("웹소켓 연결 성공");
        };
	
	    socket.onmessage = function(event) {
	        console.log(event.data);
	    };
	
	    socket.onerror = function(error) {
	        console.error("웹소켓 오류 발생:", error);
	    };
	
	    socket.onclose = function(event) {
	        console.log("웹소켓 연결 종료", event);
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