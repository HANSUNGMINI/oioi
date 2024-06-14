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
	<link rel="apple-touch-icon" sizes="180x180" href="apple-touch-icon.png"/>
	<link rel="icon" type="image/png" sizes="32x32" href="favicon-32x32.png"/>
	<link rel="icon" type="image/png" sizes="16x16" href="favicon-16x16.png"/>
	<link rel="stylesheet" href="https://cdn.materialdesignicons.com/4.9.95/css/materialdesignicons.min.css">
	
	
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130795909-1"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());
		gtag('config', 'UA-130795909-1');
	</script>
	<style>
		#submitBtn:hover {
			background-color :#34A853; 
		}
		
		.clickID {
			cursor : pointer;
		}
		
		
		.toggle {
		  display: inline-flex;
		  align-items: center;
		  gap: 0.5rem;
		  cursor: pointer;
		}

	.toggle_check {
	  appearance: none;
	  position: relative;
	  border: max(2px, 0.1em) solid gray;
	  border-radius: 1.25em;
	  width: 2.25em;
	  height: 1.25em;
	}
	
	.toggle_check::before {
	  content: "";
	  position: absolute;
	  left: 0;
	  width: 1em;
	  height: 1em;
	  border-radius: 50%;
	  transform: scale(0.8);
	  background-color: gray;
	  transition: left 250ms linear;
	}
	
	.toggle_check:checked {
	  background-color: #34A853;
	  border-color: #34A853;
	}
	
	.toggle_check:checked::before {
	  background-color: white;
	  left: 1em;
	}
	
	.toggle_check:disabled {
	  border-color: lightgray;
	  opacity: 0.7;
	  cursor: not-allowed;
	}
	
	.toggle_check:disabled:before {
	  background-color: lightgray;
	}
	
	.toggle_check:disabled + span {
	  opacity: 0.7;
	  cursor: not-allowed;
	}
	
	.toggle_check:focus-visible {
	  outline-offset: max(2px, 0.1em);
	  outline: max(2px, 0.1em) solid tomato;
	}
	
	.toggle_check:enabled:hover {
	  box-shadow: 0 0 0 max(4px, 0.2em) lightgray;
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
				<li>슈퍼 관리자</li>
				<li>내가 짱이야</li>
			</ul>
		</div>
	</section>
	<section class="section main-section">
	    <div class="card has-table">
	    	<header class="card-header">
	        	<p class="card-header-title" style="width:90%">
	          	<span class="icon"><i class="mdi mdi-account-multiple"></i></span>
	          		관리자
	        	</p>
	        	<a href="#" target="_blank" class="button blue">
			      <span>관리자 등록</span>
    			</a>
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
				            <th>관리자 등록일</th>
				            <th>관리자 역할 </th>
				            <th>관리자 권한 </th>
	         			 </tr>
	          		</thead>
	          		<tbody class="tbody">
	         		</tbody>
	        	</table>
	        		<!--  테이블 끝, 페이징 버튼 구역 -->
				<div class="table-pagination">
					<div class="flex items-center justify-between">
				    	<div class="buttons">
				    		<button type="button" class="button active">1</button>
				      		<button type="button" class="button">2</button>
				      		<button type="button" class="button">3</button>
				      		<!-- 일단 남겨둠2 -->
				            
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
	<script>
		
		$(function(){
			
			search();
			
			// 새로고침 버튼
			$("#refreshBtn").on("click", search);
		});
	
		function search() {
			
			$.ajax({
				type : "POST",
				url : "masterAdmin",
				data : {
					"isMaster" : "${isMaster}"
				},
				dataType : "JSON",
				success : function (response) {
					$(".tbody").empty();
					
					if(response == null) {
						
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
						
						for(let admin of response) {
							let active = "";
							
							if(admin.AD_ACTIVE === 'Y') {
								active = "checked";
							}
							
							$(".tbody").append(
								'<tr>'
			            		+ '<td class="checkbox-cell"><label class="checkbox"><input type="checkbox"><span class="check">'
			            		+ '</span></label></td>'
			            		+ '<td class="image-cell">'
			           			+ '	<div class="image">'
			           			+ '	<img src="https://avatars.dicebear.com/v2/initials/rebecca-bauch.svg" class="rounded-full">'
			           			+ '	</div>'
			           			+ '</td>'
			           			+ '<td data-label="Name">'+ admin.AD_ID + '</td>'
			           			+ '<td data-label="Company">'+ admin.AD_NAME +'</td>'
			           			+ '<td data-label="City">'+ admin.AD_DATE +'</td>'
			           			+ '<td data-label="City">'+ admin.RL_NAME +'</td>'
			           			+ '<td>'
			           			+ '<label class="toggle">'
							    + '<input role="switch" type="checkbox" class="toggle_check"'
							    + active
							 	+ 'onchange="changeActive(\'' + admin.AD_ID + '\', this)" />'
							 	+ '</label>'
			           			+ '</td>'
			           			+ '<td class="actions-cell">'
			           			+ '<div class="buttons right nowrap">'
			           			+ '<button class="button small blue --jb-modal" data-target="sample-modal-2" type="button">'
			           			+ '<span class="icon"><i class="mdi mdi-eye"></i></span></button>'
			           			+ '</td>'
							);
						};
						
					}
					
					
				} // success 끝
			});
		}
		
		function changeActive(id, checkBox){
			let isChecked = checkBox.checked;
			
			if(confirm("관리자 상태를 변경하시겠습니까?")){
				$.ajax({
					type : "POST",
					url : "changeActive",
					data : {
						"target" : id,
						"value" : isChecked
					},
					dataType : "JSON",
					success : function(response) {
						if(response > 0) {
							alert("변경 완료!");
						} else {
							alert("변경실패 다시 시도");
						}
					}
				}) //끝
				
				
			} else {
				// 상태 안바뀌게
				checkBox.checked = !isChecked;
			}
		};
		
		
	</script>
	
</html>
    