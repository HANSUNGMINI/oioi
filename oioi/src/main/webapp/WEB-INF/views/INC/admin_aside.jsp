<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
	$("#test").on("click", function(){
		$(".section").load("user");
	})

</script>
<div class="aside-tools">
	    <div>오이마켓</div>
	  </div>
	  <div class="menu is-menu-main">
	    <p class="menu-label">LIST</p>
	    <ul class="menu-list">
	      <li class="active">
	        <a href="admin">
	          <span class="icon"><i class="mdi mdi-desktop-mac"></i></span>
	          <span class="menu-item-label">메인화면</span>
	        </a>
	      </li>
	    </ul>
	    <p class="menu-label">Examples</p>
	    <ul class="menu-list">
	    	<!--  최고 관리자  -->
	    	<c:if test="${isMaster eq true}">
	    		<li>
			        <a class="dropdown">
						<span class="icon"><i class="mdi mdi-view-list"></i></span>
						<span class="menu-item-label">사이트 관리</span>
						<span class="icon"><i class="mdi mdi-plus"></i></span>
			        </a>
        			<ul>
	          			<li>
	            			<a href="master_admin">
	             				<span>관리자 조회</span>
	            			</a>
	          			</li>
	          			<li>
	            			<a href="master_category">
	              				<span>카테고리 변경</span>
	            			</a>
	          			</li>
	        		</ul>
	      		</li>
        	</c:if>
        	<!--  최고 관리자  -->
	      	<li>
		        <a class="dropdown">
		          <span class="icon"><i class="mdi mdi-view-list"></i></span>
		          <span class="menu-item-label">유저관리</span>
		          <span class="icon"><i class="mdi mdi-plus"></i></span>
		        </a>
	        <ul>
	          <li>
	            <a href="admin_user">
	              <span>유저 조회</span>
	            </a>
	          </li>
	          <li>
	            <a href="#" id="test">
	              <span>Sub-item Two</span>
	            </a>
	          </li>
	        </ul>
	      </li>
	      <!-- 리스트 한개 -->
	      <li>
	        <a class="dropdown">
	          <span class="icon"><i class="mdi mdi-view-list"></i></span>
	          <span class="menu-item-label">상품관리</span>
	          <span class="icon"><i class="mdi mdi-plus"></i></span>
	        </a>
	        <ul>
	          <li>
	            <a href="admin_product">
	              <span>상품조회</span>
	            </a>
	          </li>
	          <li>
	            <a href="#void">
	              <span>Sub-item Two</span>
	            </a>
	          </li>
	        </ul>
	      </li>
	      <li>
	        <a class="dropdown">
	          <span class="icon"><i class="mdi mdi-view-list"></i></span>
	          <span class="menu-item-label">채팅관리</span>
	          <span class="icon"><i class="mdi mdi-plus"></i></span>
	        </a>
	        <ul>
	          <li>
	            <a href="admin_chat">
	              <span>채팅 내역 조회</span>
	            </a>
	          </li>
	        </ul>
	      </li>
	      <li>
	        <a class="dropdown">
	          <span class="icon"><i class="mdi mdi-view-list"></i></span>
	          <span class="menu-item-label">게시글관리</span>
	          <span class="icon"><i class="mdi mdi-plus"></i></span>
	        </a>
	        <ul>
	          <li>
	            <a href="admin_board">
	              <span>게시글 조회</span>
	            </a>
	          </li>
	          <li>
	            <a href="#void">
	              <span>Sub-item Two</span>
	            </a>
	          </li>
	        </ul>
	      </li>
	      <li>
	        <a class="dropdown">
	          <span class="icon"><i class="mdi mdi-view-list"></i></span>
	          <span class="menu-item-label">페이관리</span>
	          <span class="icon"><i class="mdi mdi-plus"></i></span>
	        </a>
	        <ul>
	          <li>
	            <a href="#void">
	              <span>Sub-item One</span>
	            </a>
	          </li>
	          <li>
	            <a href="#void">
	              <span>Sub-item Two</span>
	            </a>
	          </li>
	        </ul>
	      </li>
	      <li>
	        <a class="dropdown">
	          <span class="icon"><i class="mdi mdi-view-list"></i></span>
	          <span class="menu-item-label">고객센터</span>
	          <span class="icon"><i class="mdi mdi-plus"></i></span>
	        </a>
	        <ul>
	          <li>
	            <a href="#void">
	              <span>Sub-item One</span>
	            </a>
	          </li>
	        </ul>
	      </li>
	      
	    </ul>
	    <p class="menu-label">About</p>
	  </div>