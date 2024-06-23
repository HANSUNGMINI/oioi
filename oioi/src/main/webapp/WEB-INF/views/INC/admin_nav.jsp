<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
</head>
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