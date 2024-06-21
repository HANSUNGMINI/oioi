<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
	<link href="https://cdn.jsdelivr.net/npm/@mdi/font@7.4.47/css/materialdesignicons.min.css" rel="stylesheet">
	
	
	<script async src="https://www.googletagmanager.com/gtag/js?id=UA-130795909-1"></script>
	<script>
		window.dataLayer = window.dataLayer || [];
		function gtag(){dataLayer.push(arguments);}
		gtag('js', new Date());
		gtag('config', 'UA-130795909-1');
	</script>
	<style>
		#code_value {
			margin-right: 7px;
			background-color: inherit; /* 부모 요소의 배경색을 상속 */
			outline: none;
		}
		
		.td {
			background-color :white;
			outline :2px solid black;
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
		          		카테고리
		        	</p>
		        	
		        	<select id="type">
		        		<c:forEach var="category" items="${categoryList}">
		        			<option value="${category.name}"> ${category.description}</option>
		        		</c:forEach>
		        	</select>
		      	</header>
		       	<div class="card-content">
		        	<table>
		          		<thead>
		          			<tr>
		            			<th>코드</th>
		            			<th>내용</th>
		            			<th>사용여부</th>
		            			<th>
					            	<div class="buttons right nowrap">
				           				<button class="button small blue --jb-modal" data-target="sample-modal-2" type="button">
				           					<span class="icon"><i class="mdi mdi-plus-box-multiple"></i></span>
				           				</button>
			           				</div>
					            </th>
		         			 </tr>
		          		</thead>
		          		<tbody class="tbody">
		         		</tbody>
		        	</table>
				</div>
			</div>	
		</section>
	</div>
	
	<div id="sample-modal-2" class="modal">
	 	<div class="modal-background --jb-modal-close"></div>
			<div class="modal-card">
	    		<header class="modal-card-head">
	      			<p class="modal-card-title">(관리자용) 항목 추가 하기</p>
	    		</header>
	    		<section class="modal-card-body">
	      			<table>
	      				<tr>
	      					<th>카테고리</th>
	      					<th>코드</th>
	      					<th>내용</th>
	      				</tr>
	      				<tr>
	      					<td id="targetCategory">카테고리</td>
	      					<td><input type="text" class="td" id="code"></td>
	      					<td><input type="text" class="td" id="value"></td>
	      				</tr>
	      			</table>
	    		</section>
	    		<footer class="modal-card-foot">
	      			<button class="button blue --jb-modal-close" id="addRowData">추가하기</button>
	      			<button class="button red --jb-modal-close" id="addCancel">취소</button>
	    		</footer>
	  		</div>
	</div>
	
	
</body>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/resources/js/main.min.js?v=1652870200386"></script>
	<script>
		
		$(function(){
			// 페이지로딩 되자마자 검색
			search();
			
			// 코드 사용여부 전환
			$("#type").on("change", search);
			// 코드 행 추가
			$("#addRowData").on("click", addRowData);
			$("#addCancel").on("click", addCancel);
			
		}); //redey
	
		function search() {
			let target = $("#type").val();
			$.ajax({
				type : "POST",
				url : "selectCode",
				data : {
					"target" : target
				},
				dataType : "JSON",
				success : function (response) {
					var selectBox = document.getElementById("type");
		            var selectedValue = selectBox.options[selectBox.selectedIndex].text;
					$("#targetCategory").text(selectedValue);
					
					$(".tbody").empty();
					
					if(response == '') {
						
						$(".tbody").append(
							'<tr>'
							+'<td colspan="4">'
							+'<div class="card empty">'
						    +'<div class="card-content">'
						    +'<div><span class="icon large"><i class="mdi mdi-emoticon-sad mdi-48px"></i></span></div>'
						    +'<p>조회된 정보가 없습니다</p></div></div>'
						   	+'</td>'
						    +'</tr>'
						);
						
					} else {
						
						for(let code of response) {
							let target = code.code;
							let active = "";
							
							$("#code").val(target);
							
							if(code.hide == 'N') {
								active = "checked";
							}
							
							$(".tbody").append(
								'<tr>'
			           			+ '<td data-label="Name">'+ target + '</td>'
			           			+ '<td data-label="Name">'
			           			+ 	'<input type="text" value="'+ code.value + '" id="code_value" readonlyv>'
			           			+ 	'<button class="button small blue editBtn" type="button" onclick="editCode(\''+ code.value +'\')">'
			           			+ 	'	<span class="icon"><i class="mdi mdi-lead-pencil"></i></span>'
			           			+ 	'</button>'
			           			+ '</td>'
			           			+ '<td>'
			           			+ 	'<label class="toggle">'
							    + 	'<input role="switch" type="checkbox" class="toggle_check"'
							    + 		active
							 	+ 		' onchange="changeHide(\'' + target + '\', this)" />'
							 	+ 	'</label>'
			           			+ '</td>'
			           			+ '<td>'
			           			+ '<div class="buttons right nowrap">'
			           			+ 	'<button class="button small red " type="button" onclick="deleteCode(\''+ target +'\')">'
			           			+ 	'	<span class="icon"><i class="mdi mdi-delete"></i></span>'
			           			+ 	'</button></div>'
			           			+ '</td>'
			           			+ '</tr>'
							);
						}
					};
				} // success 끝
			});
		}
		
		function changeHide(code, checkBox){
			let isChecked = checkBox.checked;
			
			if(confirm("이 항목의 상태를 변경하시겠습니까?")){
				$.ajax({
					type : "POST",
					url : "changeHide",
					data : {
						"target" : code,
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
		
		function editCode(value) {
			$(".editBtn").remove();
			// 수정 할 내용의 리드온리해제, 지금 작성중인 text가 뭔지 구분 가능하게 만드는 css코드 
			let element = $("input[value='" + value + "']");
			element.after(
			 		'<button class="button small blue" onclick="updateCode(this)" type="button" style="margin-right: 5px;">'
      			+ 	'	<span class="icon" type="button"><i class="mdi mdi-content-save"></i></span>'
         		+ 	'</button>'
         		+	'<button class="button small blue" onclick="search()" type="button">'
      			+ 	'	<span class="icon"><i class="mdi mdi-content-save-off"></i></span>'
         		+ 	'</button>'	
			);
			element.prop('readonly', false);
			element.focus();
			element.css('background-color', 'white');
			element.css('outline', '2px solid black');
			
// 			search();
		}
		
		function updateCode(button) {
			// 0.
			let target = $("#type").val();
			// 1. this로 받아온 버튼을 변수에 저장
			let btn = $(button);
			// 2. 버튼의 이전요소 text를 찾고 그 값을 저장
			//    jQuery prev()함수 이전 요소찾기(수정할 value값)
			let value = btn.prev('input[type="text"]').val();
			// 3. 버튼이 속한 tr요소를 찾고 첫 번째td의 값을 가져옴(타겟이되는 코드값)
			let code = btn.closest('tr').find('td:first').text();
			
			$.ajax({
				type : "PATCH",
				url : "common",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify({
					"target" : target,
					"code" : code, 
					"value" : value
				}), 
				dataType : "JSON",
				success : function (response) {
					
					if(response > 0) {
						alert("변경 완료!");
					} else {
						alert("변경실패 다시 시도");
					}
					
					search();
				}
			})
		}
		
		function addRowData(){
			// 카테고리 코드
			let target = $("#type").val();
			//
			let code = $("#code").val();
			let value = $("#value").val();
			
			let obj = {
					"target" : target,
					"code" : code, 
					"value" : value
			};
			
			$.ajax({
				type : "PUT",
				url : "common",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(obj),
				dataType : "JSON",
				success : function (response) {
					if(response < 1) {
						alert('추가 실패');
					}
					addCancel();
					search();
				}
			})
			
		}
		
		function addCancel(){
			$(".td").val('');
		}
		
		
		function deleteCode(target) {
			if(confirm('정말 삭제하시겠습니까?')) {
				$.ajax({
					type : "DELETE",
					url : "common",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						target : target
					}),
					dataType : "JSON",
					success : function (response) {
						if(response < 1) {
							alert('삭제 실패');
						}
						addCancel();
						search();
					}
				})
			}
		}
	</script>
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/admin.css">
</html>
    