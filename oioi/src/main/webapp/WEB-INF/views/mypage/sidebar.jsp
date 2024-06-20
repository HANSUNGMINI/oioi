<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="main-sidebar">
    <div class="single-widget category">
        <h3 class="title">나의 정보 관리</h3>
        <ul class="categor-list">
            <li><a href="userUpdate">회원정보 수정</a></li>
        </ul>
    </div>
<!--     <div class="single-widget category"> -->
<!--         <h3 class="title">나의 문의 내역</h3> -->
<!--         <ul class="categor-list"> -->
<!--             <li><a href="myQnA">나의 1:1 문의 내역</a></li> -->
<!--         </ul> -->
<!--     </div> -->
<!--     <div class="single-widget category"> -->
<!--         <h3 class="title">나의 신고 내역</h3> -->
<!--         <ul class="categor-list"> -->
<!--             <li><a href="myReport">나의 신고 내역</a></li> -->
<!--             <li><a href="myFault">나의 신고된 내역</a></li> -->
<!--         </ul> -->
<!--     </div> -->
    <div class="single-widget category">
        <h3 class="title"><a href="userLogout">로그아웃</a></h3>
    </div>
    <div class="single-widget category">
        <h3 class="title"><a href="${pageContext.request.contextPath}/deleteAccount.do">회원탈퇴</a></h3>
    </div>
</div>
