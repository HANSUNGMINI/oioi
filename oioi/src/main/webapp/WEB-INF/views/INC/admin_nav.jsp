<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
	let colors = ['#34A853','pink', 'red']
	
	$(document).ready(function() {
		
// 		var socket = new WebSocket('ws://localhost:8081/oi/push');
		var socket = new WebSocket('ws://c3d2401t1.itwillbs.com/oioi/push');
	    socket.onopen = function() {
        	console.log("웹소켓 연결 성공");
        };
	    socket.onmessage = function(event) {
	    	let data = JSON.parse(event.data);
	    	let msg = data.msg;
	    	if(msg == "checkReport") {
	    		appendNotify("신고가", "admin_report");
	    	} else if (msg == "checkApd"){
	    		appendNotify("경매물품이", "admin_auction");
	    	}
	    };
	});
	
	function appendNotify(msg, link){
		// 각 객체 고유 클래스만들기
		var uniqueClass = 'notify-' + Date.now();
		// 컬러 랜덤
		var randomNumber = Math.floor(Math.random() * 4);
    	var newNotification = $('<li class="notify ' + uniqueClass + '">'
	           + '새로운 <span class="emphasize">' + msg + '</span> 등록되었습니다.'
	           + '<input type="button" value="바로가기" onclick="location.href=\'' + link + '\'">'
	           + '</li>'
	    );
	    newNotification.css('background-color', colors[randomNumber]);
	
	    $("#notify").append(newNotification);
	
	    setTimeout(function() {
	    	$('.' + uniqueClass).fadeOut(1000, function() {
	        	$(this).remove();
	    	});
	    }, 3000); // 3초 대기
	}
	
	
// 	function getRandomColor() {
// 		var letters = '0123456789ABCDEF';
//         var color = '#';
//         for (var i = 0; i < 6; i++) {
//         	color += letters[Math.floor(Math.random() * 16)];
//         }
//         return color;
//     }
	
	
	
</script>
<style>
	.cnt {
		width : 10px;
	}
	
	.emphasize {
		color : blue;
		font-weight: 700;
	}
	.notify {
		margin-bottom : 7px;
		padding-top : 10px;
		text-align : center;
		width : 500px;
		height: 50px;
		border-radius : 10px;
		background-color : pink;
		font-size: 18px;
	}
	
	input[type="button"] {
		color : white;
		font-weight: 700;
		margin-left : 20px;
	}

</style>
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
			<ul style="margin : auto;" id="notify">
			</ul>
			<div class="navbar-end" style="margin : 0px">
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