<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">
<!-- 아이콘 사용 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
<!-- 파비콘 -->
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
		
<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatting/chattingRoom.css">

<!-- 글씨체 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

 <!-- SweetAlert CSS -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
 
 <!-- j -->
 <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script type="text/javascript">

	/*
		[ 함수 정리 ]
		1. connectChat() 					: 웹소켓 연결
		2. sendMessage()					: 메세지를 서버로 전송
		3. appendMessage(msg, align_type) 	: 메세지를 DIV에 추가하여 보여준다
		4. toJsonString(type, msg) 			: 문자열을 JSON 타입으로 변환
		5. purchase(TO_ID, PD_IDX)			: 안전결제 창으로 넘어감
		6. sysMessage(msg)					: 시스템 메세지 출력
		7. saveInfo(data.msg)				: ajax로 DB에 저장			*/

    $(function(){
	    connectChat();
	    window.scrollTo(0, document.body.scrollHeight);
	    
		let US_ID = "${param.US_ID}"
		let TO_ID = "${param.TO_ID}"
		let CR_ID = "${chatRoom.CR_ID}"
	    let FROM_ID = '';
		
	    if(TO_ID == US_ID) {
	    	FROM_ID = "${chatRoom.FROM_ID}"
	    }

	   // alert(CR_ID)
    	// 클릭 시 보내기
	     $('#sendMsg').on('click', function(evt) {
	    	let msg = $("#textMsg").val();
	    	console.log("msg : " + msg);
	    	sendMessage("TALK", TO_ID, FROM_ID, CR_ID, msg, PD_IDX);
	     });
	    
	   // 채팅 입력창에 키를 누를 때마다 이벤트 핸들링
	   
		$("#textMsg").on("keypress",function(event){
			let msg = $("#textMsg").val();
			let keyCode = event.keyCode;
			if(keyCode == 13) {
				sendMessage("TALK", TO_ID, FROM_ID, CR_ID, msg, PD_IDX);
			}
		});
	   
	   
    });
		
		
    let ws; // 웹소켓 객체가 저장될 변수
	let US_ID = "${param.US_ID}"
	let TO_ID = "${param.TO_ID}"
	let CR_ID = "${chatRoom.CR_ID}"
	let PD_IDX = "${param.PD_IDX}"
    let FROM_ID = '';
	
    if(TO_ID == US_ID) {
    	FROM_ID =  "${chatRoom.FROM_ID}";
    };
    
    function connectChat() {
        ws = new WebSocket("ws://c3d2401t1.itwillbs.com/oioi/productChat?TO_ID=" + encodeURIComponent('${param.TO_ID}') + "&PD_IDX=" + encodeURIComponent('${param.PD_IDX}'));
        ws.onopen = onOpen; // 연결 시 발생
		ws.onclose = onClose; // 연결해제 시 발생
		ws.onmessage = onMessage; // 메세지 보냈을 때 발생
		ws.onerror = onError; // 에러 발생 시 발생
    }
    
    // -------------------------------------------------------
    
    function onOpen() {
    	startChat();
		console.log("웹 소켓 연결")
    }
    
    function onClose() {
		console.log("onClose()");
	}
	function onMessage(event) { // 다른 사람 거 나오기
		let data = JSON.parse(event.data);
		appendMessage(data.msg, "left","my");
	}
	
	function onError() {
		console.log("onError()");
	}
    
    // -------------------------------------------------------
    
    function startChat() {
    	let TO_ID = "${param.TO_ID}";
    	let PD_IDX = "${param.PD_IDX}";

    	sendMessage("INIT", TO_ID, FROM_ID, CR_ID, "", PD_IDX);
    }
    
    // -------------------------------------------------------
	function saveInfo(message) {
    }
    	
    // -------------------------------------------------------
    function toJsonString(type, TO_ID, FROM_ID, CR_ID, msg, PD_IDX){ // 파라미터들을 객체로 묶은 후 전달
    	let data = {
    		type : type,
    		TO_ID : TO_ID,
    		FROM_ID : FROM_ID,
			CR_ID : CR_ID,
    		msg : msg,
    		PD_IDX : PD_IDX
    	};
    
    	return JSON.stringify(data)
    }
    
    // -----------------------------------------------------------
    function sendMessage(type, TO_ID, FROM_ID, CR_ID, msg, PD_IDX) {
		// 입력하지 않았을 경우
		if (msg == "") {
			/* alert("메세지 입력 필수") */
			$("#textMsg").focus();
			return;
		}
    	
    	ws.send(toJsonString(type, TO_ID, FROM_ID, CR_ID, msg, PD_IDX));
    	
		appendMessage(msg,"right","other");
		
		// 채팅창 초기화 및 포커스 요청
		$("#textMsg").val("");
		$("#textMsg").focus();
    }
    
    // -----------------------------------------------------------
	function sysMessage(msg){
    	
    }    
    
    // -----------------------------------------------------------
    function appendMessage(msg, align_type, who) {
    	
    	let userImg = ''
    		
    	if(align_type == "right") {
    		userImg = '${myInfo.US_PROFILE}'
    	} else { 
    		userImg = "${info.US_PROFILE}"
    	}
    	
    	let chat = ' <li class="clearfix" id="userMsg">'
    				+'	<div class="message-data text-' + align_type +'">'
    				+'	 <img src="'+ userImg +'">'
    				+ '	</div>'
    				+ '	<div class="message ' + who +'-message float-' + align_type +'">' + msg + '</div>'
    				+ '	<small class="message-data-time" style="margin-right:0px">10:10 AM</small>'
    				+ '</li>'		
    	
    	$("#chatArea").append(chat);
    				
    	// 채팅 메세지 출력창 스크롤바를 항상 맨밑으로 유지
		$('#chat-history').scrollTop($('#chat-history').prop('#chat-history'));
    	
    }

    // -----------------------------------------------------------
    
    function purchase(TO_ID, PD_IDX) {
 	   window.open('purchase?TO_ID=' + TO_ID + '&PD_IDX=' + PD_IDX , '_blank', 'width=600, height=700, left=720, top=200, resizable=no'); 
 	   
    }
</script>
</head>
<body>
	 <!-- SweetAlert JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

	<%-- 뒤로가기 상단바 --%>
   	<div style="background-color:#34A853;">
          <a href="#" onClick="location.href='ChatList?US_ID=${sessionScope.US_ID}'"><i class="bi bi-chevron-left" style="font-size: 2rem; color: white;"></i></a>
   	</div>
   	
   	
     <div class="chat">
     
     			<%-- 사용자 정보 및 신고 --%>
                <div class="chat-header clearfix">
                    <div class="row">
                        <div class="col-lg-6">
                        	<%-- 사용자 정보 --%>
                            <a href="javascript:void(0);" onclick="goStore()">
                                <img src="${info.US_PROFILE}" alt="avatar">
                            </a>
                            <div class="chat-about">
                            
                                <h6 class="m-b-0">
                                	<c:choose>
                                		<c:when test="${empty info.US_NICK}"> 탈퇴한 회원입니다 </c:when>
                                		<c:otherwise>${info.US_NICK}</c:otherwise>
                                	</c:choose>
                            	</h6>
                                <small> 신선도 : 38.5 </small>
                            </div>
                        </div>
                        
                        <%-- 신고창 및 상세정보 --%>
                        <div class="col-lg-6 hidden-sm text-right">
                            <a href="javascript:void(0);" class="btn btn-danger" data-toggle="modal" data-target="#notify_model">신고</a>
                            <a href="javascript:void(0);" class="btn btn-success" onclick="showDetail()"><i class="bi bi-list"></i></a>
                            
	                        <div id="detail">
	                        	<ul>
	                        		
<%-- 	                        	<c:if test="${param.TO_ID eq sessionScope.US_ID}"> --%>
			                        	<li><a id="d1" data-toggle="modal" data-target="#regist_model">운송장 등록</a></li>
			                        	<li><a id="d2" onclick="soldout()">판매 완료</a></li>
<%-- 	                        	</c:if> --%>

									<c:if test="${info.PD_STATUS eq 'PDS01'}">
		                        		<li><a id="d3" onclick="purchase('${param.TO_ID}','${param.PD_IDX}')">안전 결제</a></li>
		                        	</c:if>
	    	                    	<li><a id="d4" onclick="transaction()">구매확정</a></li>
	    	                    	<li><a id="d5" onclick="exit()">대화방 나가기</a></li>
	                        	</ul>
	                        </div>
	                        
	                        <div id="review">
	                        	<ul>
		                        	<li><a id="d6" data-toggle="modal" data-target="#review_model"> 후기 작성하러 가기 </a></li>
	                       		</ul>
	                        </div>
	                       	<hr>
                        </div>
                    </div>
                </div>
                
                <%-- 채팅 내역 --%>
                <div class="chat-history" >
					<div style="background-color:#EAEAEA; text-align: center; padding : 3px; margin-top: -20px; margin-bottom:10px">
						<a href="javascript:void(0);" onclick="goProductDetail()">${info.PD_SUBJECT}</a>에 대한 이야기를 시작해 보세요
					</div>

                    <ul class="m-b-0" id="chatArea">
                        <%--
                        <li class="clearfix">
                            <div class="message-data text-right">
                                <img src="https://img.freepik.com/premium-vector/cucumber-character-with-angry-emotions-grumpy-face-furious-eyes-arms-legs-person-with-irritated-expression-green-vegetable-emoticon-vector-flat-illustration_427567-3816.jpg?w=360" alt="avatar">
                            </div>
                            <div class="message other-message float-right"> 바보 </div>
                            <small class="message-data-time" style="margin-right:0px">10:10 AM</small>
                        </li>
                        
                         --%>
                    </ul>
                </div>
				
				
                <%-- 메세지 전송 --%>
                <div class="chat-message clearfix" style="margin-bottom:0px">
                 	<!-- 사진 미리보기 영역 -->
					<div id="preview-container" style="display: flex; margin-top: 3px; margin-bottom:10px"></div>
					
                    <div class="input-group mb-0">
		                <%-- 전송란 --%>
                        <input type="text" class="form-control" placeholder="메세지를 입력하세요" id="textMsg">                                    

                        <%-- 전송버튼 --%>
                        <div class="input-group-prepend">
                            <a class="input-group-text" id="sendMsg"><i class="bi bi-reply-fill"></i></a>
<!--                             <div class="input-group-text"> -->
<!-- 	                            <a href="#" onclick="document.file_1.click();"><i class="bi bi-camera-fill" style="color: #353535;"></i></a> -->
							<label for="file-input" class="input-group-text file-input-label">
						        <i class="bi bi-camera-fill" style="color: #353535;" onclick="fileUpload()"></i>
						    </label>
						    <input type="file" id="file-input" style="display: none;">
<!--                             </div> -->
                        </div>
                    </div>
                </div>
            </div>
            
            <%-- 운송장 등록 --%>
			
			<div class="modal" id="regist_model">
			  <div class="modal-dialog">
			    <div class="modal-content">
			
				<form action="delivery" method="post">
				      <!-- Modal Header -->
				      <div class="modal-header">
				        <h4 class="modal-title">운송장 등록</h4>
				      </div>
				
				      <!-- Modal body -->
				      <div class="modal-body">
				      
				      	<%-- 택배사 선택 --%>
				        <select name="DV_METHOD" id="deliver_category" style = "margin-left : 15px">
		 					<option value =""> 택배사 선택 </option>
		 					<option value ="daehan"> 대한통운 </option>
		 					<option value ="post"> 우체국택배 </option>
		 					<option value ="gs"> GS 편의점택배 </option>
		 					<option value ="cu"> CU 편의점택배 </option>
		 				</select>
		
				      	<%-- 운송장 번호 --%>
				      	<input type="text" name="DV_NUM" placeholder="운송장번호를 입력해 주세요" id="num" required="required">
				      </div>
				
				      <!-- Modal footer -->
				      <div class="modal-footer">
				        <button type="submit" class="btn btn-success">등록</button>
				        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
				        <input type="hidden" name="US_ID" value="${param.TO_ID}">
						<input type="hidden" name="PD_IDX" value="${param.PD_IDX}">
				      </div>
			     </form>
			    </div>
			  </div>
			</div>     
			
           
			
            <%-- 신고하기 --%>
		
			
			
			<div class="modal" id="notify_model">
			  <div class="modal-dialog">
			    <div class="modal-content">
			
			      <!-- Modal Header -->
			      <div class="modal-header">
			        <h4 class="modal-title">신고하기</h4>
			      </div>
			
		      	<form action="report" method="post" enctype="multipart/form-data"  onsubmit="return validateReport()">
			      <!-- Modal body -->
			      <div class="modal-body">
			      	
				      <%-- 라디오박스 --%>
				      	<c:forEach var="report" items="${reportMap}">
				      		<c:set var="i" value="${i+1}"></c:set>
							<label for="n${i}"><input type="radio" name="RP_CATEGORY" id="n${i}" value="${report.code}">  &nbsp;${report.value}</label> <br>
				      	</c:forEach>
						
						<%-- 파일 --%>
						<div style="padding:5px;">
		                    <small>이미지는 최대 2장 등록 가능합니다</small>
		                    
					         <input type="file" id="fileInput" style="display: none;" name="RP_IMG" accept=".png, .jpeg" multiple>
							<div class="preView">
								<img src="${pageContext.request.contextPath}/resources/images/submitIMG.png" name="reportImg" class="tempImg addImg" id="uploadTrigger">
							</div>
						</div>
						
						<%-- 내용 입력 --%>
						<textarea placeholder="내용을 입력하세요"
						
						
						 style = "resize : none" name="RP_CONTENT"  id="RP_CONTENT" maxlength="300"></textarea>
				  </div>
				  
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-success">신고하기</button>
			        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			      </div>
					<input type="hidden" name="TO_ID" value="${param.TO_ID}">
					<input type="hidden" name="PD_IDX" value="${param.PD_IDX}">
				</form>			      
			    </div>
			  </div>
			</div>     
			
            <%-- 리뷰 작성하기 --%>
			
			<div class="modal" id="review_model">
			  <div class="modal-dialog">
			    <div class="modal-content">
			
			      <!-- Modal Header -->
			      <div class="modal-header">
			        <h4 class="modal-title">리뷰 작성하기</h4>
			      </div>
			
		       <form action="reviewWrite" method="post" name="review_fr" onsubmit="return validateReview()">
			      <!-- Modal body -->
			      <div class="modal-body">
			       		<div id="review_category" style="text-align: justify;">
				       		<%-- 체크박스 --%>
				       		<c:forEach var="review" items="${reviewMap}">
				       			<c:set var="i" value="${i+1}"></c:set>
					       		<label for="chk${i}"><input type="checkbox" name="RV_CATEGORY" id="chk${i}" value="${review.code}"> &nbsp;${review.value}</label><br>
				       		</c:forEach>
				       		 <input type="hidden" name="RV_CATEGORYS" id="RV_CATEGORYS">
			       		</div>
			      		<hr>
			       
		       		    <div id="rating">
					        <fieldset>
		                        <div id="emojiDisplay" style="font-size: 20px"></div>
<!-- 					            <legend>별점을 선택해 주세요</legend> -->
					            <input type="radio" name="RV_STAR" value="5" id="rate1"><label for="rate1">⭐</label>
					            <input type="radio" name="RV_STAR" value="4" id="rate2"><label for="rate2">⭐</label>
					            <input type="radio" name="RV_STAR" value="3" id="rate3"><label for="rate3">⭐</label>
					            <input type="radio" name="RV_STAR" value="2" id="rate4"><label for="rate4">⭐</label>
					            <input type="radio" name="RV_STAR" value="1" id="rate5"><label for="rate5">⭐</label>
					        </fieldset>
                        </div>
						<textarea placeholder="내용을 입력하세요" style = "resize : none" name="RV_CONTENT"  id="review_content" maxlength="600" required="required"></textarea>			      
				  </div>
				  
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-success">리뷰 작성하기</button>
			        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			        <input type="hidden" name="TO_US_ID" value="${param.TO_ID}">
			        <input type="hidden" name="FROM_US_ID" value="${param.US_ID}">
			        <input type="hidden" name="PD_IDX" value="${param.PD_IDX}">
			      </div>
			
                   </form>
			    </div>
			  </div>
			</div>     

            <!-- 부트스트랩 -->
            
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    
    
    
    <script type="text/javascript">
		/*
		     [함수 정리] 
		1. showDetail() 				: 상세보기 나오기
		2. transaction()				: 판매완료
		3. exit()						: 대화방 나가기
		4. setRating(value, reservIdx) 	: 별점 매기기
		5. goStore()					: 상점 바로가기
		6. goProductDetail()			: 거래 상품 디테일 바로라기
		7. validateReview() 			: 리뷰 유효성 검사 및 체크박스 합치기
		8. validateReport()				: 신고 유효성 검사
		9. soldout()					: 판매 완료
		*/
    
		
		/* 상세보기 나오기 */
		function showDetail(){
			let datail= document.querySelector("#detail");
			if (detail.style.display == "none") {
				detail.style.display = "block";
			} else {
				detail.style.display = "none";
			}
		}
		
		/* [ 판매 완료 ] */
		function soldout() {
			let nick = '${info.US_NICK}';
			let existReview = '${info.existReview }';
			
			Swal.fire({
				   title: '판매 완료로 변경하시겠습니까?',
				   text: '확인 버튼 클릭 시, '+ nick + ' 님과의 거래가 성사됩니다.',
				   icon: 'warning',
				   
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '완료', // confirm 버튼 텍스트 지정
				   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
				   
				   reverseButtons: false, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   
				      Swal.fire('판매 완료되었습니다.', '감사합니다', 'success');
//				   		location.href="tradeDecide?PD_IDX=${param.PD_IDX}";
						document.querySelector("#detail").style.display = "none";
						
						if(existReview == 'no') {
							document.querySelector("#review").style.display = "block";
						}
				   }
				});
			
		}
		/* [ 신고 ] */
		function validateReport() {
		    const radios = document.getElementsByName('RP_CATEGORY');
		    let isChecked = false;
		    
		    for (const radio of radios) {
		        if (radio.checked) {
		            isChecked = true;
		            break;
		        }
		    }
		    
		    if (!isChecked) {
		    	Swal.fire({
                    title: '카테고리를 선택해 주세요',
                    icon: 'warning',
                });
		        return false;
		    }
		    
		    return true;
		}		
		
		/* [ 리뷰 ] */
		/* 별점 개수에 따른 이모지 */
		document.addEventListener('DOMContentLoaded', (event) => {
	    const emojiDisplay = document.getElementById('emojiDisplay');
	    const ratings = document.getElementsByName('RV_STAR');
	    const checkboxes = document.getElementsByName('RV_CATEGORY');
	    
	    // 이모지
	    const emojis = {
	        5: "아주 좋았어요 🥰",
	        4: "좋아요 😃",
	        3: "그냥 그랬어요 😐",
	        2: "별로였어요 😕",
	        1: "최악이였어요 😢"
	    };
	
	    ratings.forEach(rating => {
	        rating.addEventListener('change', (event) => {
	            const selectedValue = event.target.value;
	            emojiDisplay.textContent = emojis[selectedValue];
	        });
	    });
	    
	    // 체크박스 선택 제한
	    checkboxes.forEach(checkbox => {
	        checkbox.addEventListener('change', (event) => {
	            const selectedCheckboxes = Array.from(checkboxes).filter(checkbox => checkbox.checked);
	            if (selectedCheckboxes.length > 4) {
	                Swal.fire({
	                    title: '최대 4개까지 선택하실 수 있습니다',
	                    icon: 'warning',
	                });
	                event.target.checked = false;
	            }
	        });
	    });
	});
		
		/* 리뷰 유효성 검사 및 체크박스 합치기 */
		function validateReview() {
		    const checkboxes = document.getElementsByName('RV_CATEGORY');
		    const isChecked = Array.from(checkboxes).some(checkbox => checkbox.checked);
		
		    const ratings = document.getElementsByName('RV_STAR');
		    const isRatingSelected = Array.from(ratings).some(rating => rating.checked);
		    
		    if (!isChecked) {
		        Swal.fire({
		            title: '리뷰 카테고리를 선택해 주세요',         // Alert 제목
		            text: '하나 이상 선택해 주세요.',  // Alert 내용
		            icon: 'warning',                         // Alert 타입
		        });
		        return false;
		    }
		    
		    if (!isRatingSelected) {
		        Swal.fire({
		            title: '별점을 선택해 주세요.',         // Alert 제목
		            icon: 'warning',                         // Alert 타입
		        });
		        return false;
		    }
		
		    // 체크된 체크박스 값을 결합하여 숨겨진 입력 필드에 설정
		    const selectedValues = Array.from(checkboxes)
		                                .filter(checkbox => checkbox.checked)
		                                .map(checkbox => checkbox.value)
		                                .join('/');
		    document.getElementById('RV_CATEGORYS').value = selectedValues;
		    
		    return true;
		}
		
		/* 구매확정 */
		function transaction() {
			let nick = '${info.US_NICK}';
			
			Swal.fire({
				   title: '구매 확정하시겠습니까?',
				   text: '구매 확정 시, 돈이 송금되며 취소 불가능합니다.',
				   icon: 'warning',
				   
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '완료', // confirm 버튼 텍스트 지정
				   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
				   
				   reverseButtons: false, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   
				      Swal.fire('거래 완료되었습니다.', '감사합니다', 'success');
// 				   		location.href="tradeDecide?PD_IDX=${param.PD_IDX}";
				   }
				});
			
		}
		
		/* 대화방 나가기 */
		function exit() {
			
			Swal.fire({
				   title: '대화방을 나가시겠습니까?',
				   text: '대화 내용이 모두 삭제됩니다',
				   icon: 'warning',
				   
				   showCancelButton: true, // cancel버튼 보이기. 기본은 원래 없음
				   confirmButtonColor: '#3085d6', // confrim 버튼 색깔 지정
				   cancelButtonColor: '#d33', // cancel 버튼 색깔 지정
				   confirmButtonText: '나가기', // confirm 버튼 텍스트 지정
				   cancelButtonText: '취소', // cancel 버튼 텍스트 지정
				   
				   reverseButtons: false, // 버튼 순서 거꾸로
				   
				}).then(result => {
				   // 만약 Promise리턴을 받으면,
				   if (result.isConfirmed) { // 만약 모달창에서 confirm 버튼을 눌렀다면
				   		// 채팅방 나가기
				   }
				});
			
		}

	
		/* 상점 바로가기 */
		function goStore(){
			window.opener.location.href="myStore?userId=${param.TO_ID}"; 
			window.close();
		}
		
		/* 제품 상세보기 바로가기 */
		function goProductDetail() {
			let idx = '${param.PD_IDX}'
			
			window.opener.location.href="productDetail?PD_IDX=" + idx ; 
			window.close();	
		}
 		
		/* 파일 업로드 */
		document.addEventListener("DOMContentLoaded", function() {
		    const fileInput = document.getElementById('fileInput');
		    const uploadTrigger = document.getElementById('uploadTrigger');
		    const previewContainer = document.querySelector('.preView');
		
		    uploadTrigger.addEventListener('click', function() {
		        if (document.querySelectorAll('.previewImg').length < 2) {
		            fileInput.click();
		        } else {
		            alert("이미지 파일은 최대 2개까지 첨부할 수 있습니다.");
		        }
		    });
		
		    fileInput.addEventListener('change', function(event) {
		        const files = event.target.files;
		        if (files.length + document.querySelectorAll('.previewImg').length > 2) {
		            alert("이미지 파일은 최대 2개까지 첨부할 수 있습니다.");
		            fileInput.value = "";
		            return;
		        } else {
		        	document.querySelector("#uploadTrigger").style.display = "none";
		        }
		        
		        Array.from(files).forEach(file => {
		            if (file.type.startsWith('image/')) {
		                const reader = new FileReader();
		                reader.onload = function(e) {
		                    const imgWrapper = document.createElement('div');
		                    imgWrapper.classList.add('previewImgWrapper');

		                    const img = document.createElement('img');
		                    img.src = e.target.result;
		                    img.classList.add('previewImg');

		                    const deleteBtn = document.createElement('button');
		                    deleteBtn.textContent = 'X';
		                    deleteBtn.classList.add('deleteBtn');
		                    deleteBtn.addEventListener('click', function() {
		                        imgWrapper.remove();
		                        if (document.querySelectorAll('.previewImgWrapper').length < 2) {
		                            document.querySelector("#uploadTrigger").style.display = "block";
		                        }
		                    });

		                    imgWrapper.appendChild(img);
		                    imgWrapper.appendChild(deleteBtn);
		                    previewContainer.appendChild(imgWrapper);
		                }
		                reader.readAsDataURL(file);
		            }
		        });
		    });
		});
		
		
		
	</script>
    
</body>
</html>