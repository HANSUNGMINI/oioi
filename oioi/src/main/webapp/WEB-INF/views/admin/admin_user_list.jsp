<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en" class="">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Tables - Admin One Tailwind CSS Admin Dashboard</title>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/main.css?v=1652870200386">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png"/>
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png"/>
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png"/>
	<link href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css" rel="stylesheet">
	
	
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130795909-1"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());
		gtag('config', 'UA-130795909-1');
	</script>
	<style>
		#buttons {
			margin : 0px auto;
		}
	
	</style>
</head>
<body>
	<div id="app">
	<nav class="app-header navbar navbar-expand bg-body" ><jsp:include page="../INC/admin_nav.jsp"></jsp:include></nav>
	<aside class="aside is-placed-left is-expanded"><jsp:include page="../INC/admin_aside.jsp"></jsp:include></aside>
	<section class="is-title-bar">
		<div class="flex flex-col md:flex-row items-center justify-between space-y-6 md:space-y-0">
			<ul>
				<li>Admin</li>
				<li>Tables</li>
			</ul>
		</div>
	</section>
	<section class="section main-section">
    	<div class="notification blue">
      		<div class="flex flex-col md:flex-row items-center justify-between space-y-3 md:space-y-0">
	        	<div>
	          		<span class="icon"><i class="mdi mdi-buffer"></i></span>
	          			<b>일단 남겨둠</b>
	        	</div>
      		</div>
   		</div>
	    <div class="card has-table">
	    	<header class="card-header">
	        	<p class="card-header-title">
	          	<span class="icon"><i class="mdi mdi-account-multiple"></i></span>
	          		회원목록
	        	</p>
	        	
	        	<select id="type">
	        		<option value="US_NAME">이름</option>
	        		<option value="US_ID">아이디</option>
	        		<option value="US_NICK">닉네임</option>
	        	</select>
	        	<input type="text" id="keyword" placeholder="검색어 입력">
	        	<input type="button" id="submitBtn" value="검색">
	        	
	        	<a href="#" id="refreshBtn" class="card-header-icon">
          			<span class="icon"><i class="mdi mdi-reload"></i></span>
        		</a>
	      	</header>
	       	<div class="card-content">
	        	<table>
	          		<thead>
	          			<tr>
	            			<th class="checkbox-cell">
	            				<label class="checkbox"><input type="checkbox"><span class="check"></span></label>
	            			</th>
				            <th class="image-cell"></th>
				            <th>아이디</th>
				            <th>이름</th>
				            <th>닉네임</th>
				            <th>가입일</th>
	         			 </tr>
	          		</thead>
	          		<tbody class="tbody">
	         		</tbody>
	        	</table>
	        		<!--  테이블 끝, 페이징 버튼 구역 -->
				<div class="table-pagination">
					<div class="flex items-center justify-between">
				    	<div class="buttons" id="buttons">
				    	</div>
					</div>
				</div>
			</div>
		</div>	
	</section>
    
    <!-- 모달창 -->
	<div id="sample-modal" class="modal">
		<div class="modal-background --jb-modal-close"></div>
		<div class="modal-card">
			<header class="modal-card-head">
			  <p class="modal-card-title">Sample modal</p>
			</header>
			<section class="modal-card-body">
			  <p>Lorem ipsum dolor sit amet <b>adipiscing elit</b></p>
			  <p>This is sample modal</p>
			</section>
			<footer class="modal-card-foot">
			  <button class="button --jb-modal-close">Cancel</button>
			  <button class="button red --jb-modal-close">Confirm</button>
			</footer>
		</div>	
	</div>
	<!-- 빨간 모달 -->
	<div id="sample-modal-2" class="modal">
	  <div class="modal-background --jb-modal-close"></div>
	  <div class="modal-card">
	    <header class="modal-card-head">
	      <p class="modal-card-title">Sample modal</p>
	    </header>
	    <section class="modal-card-body">
	      <p>Lorem ipsum dolor sit amet <b>adipiscing elit</b></p>
	      <p>This is sample modal</p>
	    </section>
	    <footer class="modal-card-foot">
	      <button class="button --jb-modal-close">Cancel</button>
	      <button class="button blue --jb-modal-close">Confirm</button>
	    </footer>
	</div>
		</div>
	</div>
</body>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.min.js?v=1652870200386"></script>
<%--     <script src="${pageContext.request.contextPath}/resources/js/admin_user_list.js"></script> --%>
	<script>
		
		let pageNum = 1;
		
		$(function(){
			
			search(pageNum, true);
			
			// 새로고침 버튼
			$("#refreshBtn").on("click", function(){
				search(1 , true);
			});
			
			// 검색버튼
			$("#submitBtn").on("click", function(){
				search(1 , false);
			});
			

		});
	
		function search(pageNum, selectAll) {
			let type = "";
			let keyword = "";
			
			if(!selectAll) {
				type = $("#type").val();
				keyword = $("#keyword").val();
			}
			
			$.ajax({
				type : "POST",
				url : "UserList",
				data : {
					"type" : type,
					"keyword" : keyword,
					"pageNum" : pageNum
				},
				dataType : "JSON",
				success : function (response) {
					let userList = response.userList;
					let pageInfo = response.pageInfo;
					$(".tbody").empty();
					$("#buttons").empty();
					
					if(userList == '') {
						
						$(".tbody").append(
							'<tr>'
							+'<td colspan="7">'
							+'<div class="card empty">'
						    +'<div class="card-content">'
						    +'<div><span class="icon large"><i class="mdi mdi-emoticon-sad mdi-48px"></i></span></div>'
						    +'<p>조회된 정보가 없습니다</p></div></div>'
						   	+'</td>'
						    +'</tr>'
						);
						
						
					} else {
						
						for(let user of userList) {
							
							$(".tbody").append(
								'<tr>'
			            		+ '<td class="checkbox-cell"><label class="checkbox"><input type="checkbox"><span class="check">'
			            		+ '</span></label></td>'
			            		+ '<td class="image-cell">'
			           			+ '	<div class="image">'
			           			+ '	<img src="https://avatars.dicebear.com/v2/initials/rebecca-bauch.svg" class="rounded-full">'
			           			+ '	</div>'
			           			+ '</td>'
			           			+ '<td data-label="Name">'+ user.US_ID + '</td>'
			           			+ '<td data-label="Company">'+ user.US_NAME +'</td>'
			           			+ '<td data-label="City">'+ user.US_NICK +'</td>'
			           			+ '<td data-label="City">'+ user.US_REG_DATE +'</td>'
			           			+ '<td class="actions-cell">'
			           			+ '<div class="buttons right nowrap">'
			           			+ '<button class="button small blue --jb-modal" data-target="sample-modal-2" type="button"'
			           			+ 'onclick="detail(\'' + user.US_ID + '\')">'
			           			+ '<span class="icon"><i class="mdi mdi-account-edit"></i></span></button>'
			           			+ '</td>'
							);
						};
						
						$("#buttons").append(
					    		'<button type="button" class="button" '
					    		+ 'onclick="search('+ (pageNum - 1) + ', false)"'
					    		+ '><span class="icon"><i class="mdi mdi-arrow-left"></i></span></button>'
						);
						
						for(let btn = pageInfo.startPage; btn <= pageInfo.endPage; btn++) {
							
							if(btn == pageNum) {
								$("#buttons").append(
										'<button type="button" class="button active">'+ btn +'</button>'
								);
								
							} else {
								$("#buttons").append(
										'<button type="button" class="button">'+ btn +'</button>'
								);
							}
							
							
						}
						
						$("#buttons").append(
					    		'<button type="button" class="button" '
					    		+ 'onclick="search('+ (pageNum + 1) + ', false)"'
					    		+ '><span class="icon"><i class="mdi mdi-arrow-right"></i></span></button>'
						);
						
						pageNum++;
					}
					
					
				} // success 끝
			});
		}
		
		function detail(US_ID) {
			
			$.ajax({
				type : "POST",
				url : "UserDetail",
				data : {
					"US_ID" : US_ID
				},
				dataType : "JSON",
				success : function(response){
					alert("어디까지 조회할지 생각중");
				}
			})
			
			
		}
		
	</script>
</html>
    