<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="zxx">
<head>
<!-- Meta Tag -->
   <meta charset="utf-8">
   <meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name='copyright' content=''>
<meta http-equiv="X-UA-Compatible" content="IE=edge">
   <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- Title Tag  -->
   <title>Auction</title>
<!-- Favicon 
     인터넷 위에보면 아이콘 넣기 가능 이미지만 바꾸며ㅑㄴ댐-->
<%--    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png"> --%>
<!-- Web Font -->
<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">

<!-- css(채팅) -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatting/chattingRoom.css">

<!-- Bootstrap -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
<!-- Magnific Popup -->
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/magnific-popup.min.css">
<!-- Font Awesome -->
   <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.css">
<!-- Fancybox -->
<%--    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.fancybox.min.css"> --%>
<!-- Themify Icons -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/themify-icons.css">
<!-- Nice Select CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/niceselect.css">
<!-- Animate CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/animate.css">
<!-- Flex Slider CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flex-slider.min.css">
<!-- Owl Carousel -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl-carousel.css">
<!-- Slicknav -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slicknav.min.css">

<!-- Eshop StyleSheet -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/responsive.css">

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/color.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/auction/auctionDetail.css">
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<script type="text/javascript">
   var socket = null;
   var us_id = "${apdDetail.US_ID}";
   var apd_idx = "${apdDetail.APD_IDX}";
   var at_idx = "${apdDetail.AT_IDX}";
   var session_id = "${sessionScope.US_ID}";
   console.log("session_id : " + session_id);

   $(function(){
     connect();
     
     
      $('#sendMsg').on('keypress',function(et) {
         let keyCode = et.keyCode;
         if(keyCode == 13) {
               sendMessage(et);
            }
      });
      
      $('#btnSend').on('click',function(et) {
         sendMessage(et);
       });
      
      
      function sendMessage(event){
    	  if(${empty apdDetail.US_ID}){
              alert("로그인 후 사용하세요");
              return;
           }
           event.preventDefault();
           if(socket.readyState !== 1) return;
            
           let msg = $('input#sendMsg').val();
           if (!msg.trim()) return;
            
           var dataSend = {
               US_ID: us_id,
               APD_IDX: apd_idx,
               MSG: msg
           };
           
           saveMessage(dataSend);
           
           socket.send(JSON.stringify(dataSend));
           appendMessage(us_id, msg, "right");
           $('input#sendMsg').val('');
      }
      
      var minValue = $('#nowPrice').val();
      var maxValue = "${apdDetail.APD_BUY_NOW_PRICE}";
         
      $('#bidding').on('click', function(){
         nowValue = $('#nowPrice').val();
         console.log(nowValue);
         
         if(${empty sessionScope.US_ID}){
            alert("로그인 후 입찰하세요.");
            $('#nowPrice').val(minValue);
            return false;
         }
         console.log("nowValue : " + nowValue);
            console.log("minValue : " + minValue);
            console.log("maxValue : " + maxValue);
         if(minValue >= nowValue || nowValue > maxValue){
               alert("입찰가가 현재 입찰가 보다 크고 즉시 구매가 보다 작아야합니다.");
               $('#nowPrice').val(minValue);
               return false;
            }else if(nowValue == maxValue){
               //입찰가가 즉시구매가랑 같을때 경매 종료
               $.ajax({
                  url : "auctionClose",
                  type : "post",
                  data : {
                     AT_IDX : apd_idx,
                     BID_USER : session_id,
                     BID_PRICE : nowValue
                  },
                  dataType : "JSON",
                  success: function(response) {
                     console.log("성공 : " + response);
                  }
               });
               
            }
         
         $.ajax({
            url : "auctionBid",
            type : "post",
            data : {
               APD_IDX : apd_idx,
               AT_IDX : at_idx,
               FINAL_BID_USER : us_id,
               FINAL_BID_PRICE : nowValue
            },
            dataType : "JSON",
                 success: function(response) {
                      console.log('저장 성공 : ' + response);
                      var html ='';
                      html += '<li class="clearfix" class="chatViewMe">' + 
                      '<div class="message other-message float-right">' +
                      us_id +
                      '님께서' +
                      response +
                      '원에 입찰하였습니다.' +
                      '</div>' +
                       '</li>';
                     $('.chatView').append(html);
                  }
         });
      });
      
      //배송상태를 가져오기
      var t_key = $('#t_key').val();
      var t_code = $('#t_code').val();
      var t_invoice = $('#t_invoice').val();
      
//       $('#deliveryAlert').on('click', function(){
//         console.log("확인");
        
//         $.ajax({
//             url : "https://info.sweettracker.co.kr/api/v1/trackingInfo",
//             type : "GET",
//             data: {
//                  t_key: t_key,
//                  t_code: t_code,
//                  t_invoice: t_invoice
//              },
//              success: function(response) {
//                 console.log(response);
//                 var latestStatus = response.trackingDetails[response.trackingDetails.length - 1];
//                  var deliveryLevel = latestStatus.level;
                 
//                  // 배송 상태 출력
//                  console.log("Delivery Level: " + deliveryLevel);
//              }
//           });
//       });
      
    
      
    
    });
   
   function connect() {
      ws = new WebSocket("ws://localhost:8081/oi/replyEcho?APD_IDX=" + encodeURIComponent(apd_idx));
      var us_id = "${apdDetail.US_ID}";
      socket = ws;
   ws.onopen = function() {
   console.log('경매 연결');
   appendMessage("System", ">> 채팅방에 입장하였습니다 <<", "center");
//    socket.send(toJsonString("ENTER", ""));
   
//    socket.send(JSON.stringify(dataSend));
   };
   
   ws.onmessage = function(event) {
       var response = JSON.parse(event.data);
       console.log('받은 메시지 :', response.SESSION_SIZE);
       console.log('받은 메시지 :', response.type);
		       
  	   
       if (response.type === "ENTER" || response.type === "LEAVE") {
           appendMessage("System", response.msg, "center");
       } else if (response.type === "SESSION_SIZE") {
           $('#sessionSize').empty().append('<span>접속자 수 : <a style="margin-top: -1px;" class="cat">' + response.SESSION_SIZE + '명</a></span>');
       } else if (response.type === "TALK") {
           var res = JSON.parse(response.DATA);
           console.log("res : " + res);
           if (res.US_ID === session_id) {
               appendMessage(res.US_ID, res.MSG, "right");
           } else {
               appendMessage(res.US_ID, res.MSG, "left");
           }
           saveMessage(res);
       } else if(response.type === 'USER_LIST'){
    	   //신고할 사람(접속한 사람)
           console.log('접속한 사람 :' + response.users);
           var users = response.users;
           console.log('접속한 사람 파싱:' + users);
           $('#reportUser').empty();
           $.each(users, function(index, us) {
        	   $('#reportUser').append('<option value="' + us + '">' + us + '</option>');
           });
           
          // 접속자 수 표시
   		  console.log("SESSION_SIZE : " + response.SESSION_SIZE);
          
          $('#sessionSize').empty();
       	  $('#sessionSize').append('<span>접속자 수 : <a style="margin-top: -1px;" class="cat">' +
                  response.SESSION_SIZE + '명</a></span>');
          
       } 
   };
   
   ws.onclose = function(event) {
       console.log('종료');
   };

   ws.onerror = function(error) {
       console.log('error: ' + error);
   };

   }

   function appendMessage(sender, msg, align_type) {
	   var seller = "${apdDetail.APD_OWNER}";
	   console.log("us_id(sender비교전) : " + seller);
	   console.log("sender(sender비교전) : " + sender);
       var html = '';
       if(seller == sender){
		   sender = sender + '(판매자)';
	   }
       
       console.log("sender(sender비교전) : " + sender);
       if (align_type === "right") {
           html += '<li class="clearfix chatViewMe">' +
               '<div class="message other-message float-right">' +
               msg +
               '</div>' +
               '</li>';
       } else if (align_type === "left") {
    	   
    	   
           html += '<li class="clearfix chatViewYou">' +
               '<div class="message-avatar">' +
               '<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20231201_11%2F1701407251569KtFaW_JPEG%2F2577731462313581_1635528623.jpg&type=sc960_832" alt="">' +
               sender +
               '</div>' +
               '<div class="message my-message">' +
               msg +
               '</div>' +
               '</li>';
       } else if (align_type === "center") {
           html += '<li class="clearfix chatViewMe">' +
               '<div class="messageCenter">' +
               msg +
               '</div>' +
               '</li>';
       }
       $('.chatView').append(html);
       $(".chatView").scrollTop($(".chatView")[0].scrollHeight);
   }

   function saveMessage(res) {
       $.ajax({
           url: "saveMsg",
           type: "post",
           data: {
               ACR_IDX: res.APD_IDX,
               ACM_CONTENT: res.MSG,
               ACM_USER: res.US_ID
           },
           dataType: "JSON",
           success: function(response) {
               console.log('DB저장 성공' + response);
           }
       });
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
   
   
</head>
<body class="js">
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
   <header><jsp:include page="../INC/top.jsp"></jsp:include></header>
      
      <!-- Breadcrumbs -->
      <div class="breadcrumbs">
         <div class="container">
            <div class="row">
               <div class="col-12">
                  <div class="bread-inner">
                     <ul class="bread-list">
                        <li><a href="./">Home<i class="ti-arrow-right"></i></a></li>
                        <li class="active"><a href="notice">경매<i class="ti-arrow-right"></i></a></li>
                        <li class="active"><a href="notice">상세페이지</a></li>
                     </ul>
                  </div>
               </div>
            </div>
         </div>
      </div>
      <!-- End Breadcrumbs -->
      
            
      <!-- Shop Single -->
      <section class="shop single section">
               <div class="container">
                  <div class="row"> 
                     <div class="col-12">
                        <div class="row">
                           <div class="col-lg-6 col-12">
                              <!-- Product Slider -->
                              <div class="product-gallery">
                                 <!-- Images slider -->
<%--                                  <img class="hover-img" src="<%= request.getContextPath() %>/resources/upload/${apd.image1 }"> --%>
                                 <div class="flexslider-thumbnails">
                                    <ul class="slides">
                                       <li data-thumb="<%= request.getContextPath() %>/resources/upload/${apdDetail.image1}" rel="adjustX:10, adjustY:">
                                          <img src="<%= request.getContextPath() %>/resources/upload/${apdDetail.image1}" alt="#">
                                       </li>
                                       <li data-thumb="https://via.placeholder.com/570x520">
                                          <img src="https://via.placeholder.com/570x520" alt="#">
                                       </li>
                                       <li data-thumb="https://via.placeholder.com/570x520">
                                          <img src="https://via.placeholder.com/570x520" alt="#">
                                       </li>
                                       <li data-thumb="https://via.placeholder.com/570x520">
                                          <img src="https://via.placeholder.com/570x520" alt="#">
                                       </li>
                                    </ul>
                                 </div>
                                 <div>
                                       <canvas id="myChart"></canvas>
                                       <script type="text/javascript">
                                          $(function() {
                                             console.log("차트");
                                             
                                             $.ajax({
                                                url : "biddingChart",
                                                type : "post",
                                                data : {
                                                   APD_IDX : "${apdDetail.APD_IDX}"
                                                },
                                                dataType : "json",
                                                success : function(data){
                                                   console.log("data : " + data);
                                                   var BID_PRICE = data.map(item => item.BID_PRICE);
                                                   var BID_TIME = data.map(item => item.BID_TIME);
                                                   
                                                   console.log("BID_PRICE : " + BID_PRICE);
                                                   console.log("BID_TIME : " + BID_TIME);
                                                   //차트
                                                      const ctx = document.getElementById('myChart').getContext('2d');
                                               new Chart(ctx, {
                                                   type: 'line',
                                                   data: {
                                                       labels: BID_TIME,
                                                       datasets: [{
                                                           label: '경매 입찰표',
                                                           data: BID_PRICE,
                                                           borderWidth: 1,
                                                           borderColor: 'rgba(75, 192, 192, 1)', // 선 색상
                                                           backgroundColor: 'rgba(75, 192, 192, 0.2)', // 채우기 색상
                                                           fill: false // 채우기 여부 (선 차트의 경우 false)
                                                       }]
                                                   },
                                                   options: {
                                                       scales: {
                                                           y: {
                                                               beginAtZero: true
                                                           }
                                                       }
                                                   }
                                               });
                                                }
                                             });
                                          });
                                       
                                          
                                       </script>
                                    </div>
                                 <!-- End Images slider -->
                              </div>
                              <!-- End Product slider -->
                           </div>
                           <div class="col-lg-6 col-12">
                              <div class="product-des">
                                 <!-- Description -->
                                 <div class="short">
                                    <h4>${apdDetail.APD_NAME}</h4>
                                    <p class="cat" style="margin-top: -1px;">Category : ${apdDetail.APD_CATEGORY}</p>
                                         
                                    
                                    <hr>
<%--                                     <p class="price"><span class="discount">시작 가격 </span>￦<fmt:formatNumber value="${apdDetail.APD_START_PRICE}" pattern="#,###"/></p> --%>
<%--                                     <p class="price"><span class="discount">현재 가격 </span>￦<fmt:formatNumber value="${apdDetail.APD_BUY_NOW_PRICE}" pattern="#,###"/></p> --%>
                                    <div class="priceAlign">
                                       <div>
                                          <p class="cat" style="margin-top: -1px;">판매시작가</p>
                                          <p class="price" style="margin-top: -2px;"><fmt:formatNumber value="${apdDetail.APD_START_PRICE}" pattern="#,###"/>원</p>
                                       </div>
                                       <div>
                                          <p class="cat" style="margin-top: -1px;">즉시구매가</p>
                                          <p class="price" style="margin-top: -2px;"><fmt:formatNumber value="${apdDetail.APD_BUY_NOW_PRICE}" pattern="#,###"/>원</p>
                                       </div>
                                       <div>
                                          <p class="cat" style="margin-top: -1px;">현재입찰가</p>
                                          <p class="price" style="margin-top: -2px;"><fmt:formatNumber value="${apdDetail.FINAL_BID_PRICE}" pattern="#,###"/>원</p>
                                       </div>
                                    </div>
<!--                                     <p class="description"> -->
                                       
<!--                                     </p> -->
                                    <div class="chat" style="margin-top: 10px;">
                                       <%-- 채팅 내역 --%>
                                           <div class="chat-history" style="background-color: #e9e9e9; padding: 20px;">
<!--                                           <div class="chatNo"> -->
<!--                                              진행중인 대화가 없습니다. -->
<!--                                           </div> -->
                                               <ul class="chatView" style="height: 410px; overflow-y: auto;">
                                                   <li class="clearfix" id="chatViewYou">
<!--                                                       <div class="message-avatar"> -->
<!--                                                    <img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20231201_11%2F1701407251569KtFaW_JPEG%2F2577731462313581_1635528623.jpg&type=sc960_832" alt=""> -->
<!--                                                    한숑 -->
<!--                                                 </div> -->
<!--                                                        <div class="message my-message"> -->
<!--                                                           이자민 바보 -->
<!--                                                           <small class="message-data-time" style="margin-bottom:-20px">10:10 AM</small> -->
<!--                                                        </div> -->
                                                   

                                                   </li>
                                               </ul>
                                           </div>
                                       
                                       
                                           <%-- 메세지 전송 --%>
                                           <div class="" style="margin-bottom:0px;">
                                          
                                               <div class="input-group">
                                                 <%-- 전송란 --%>
                                                   <input type="text" class="m-b-0" style="width: 461px;" id="sendMsg" placeholder="메세지를 입력하세요">                                    
                           
                                                   <%-- 전송버튼 --%>
                                                   <div class="">
<!--                                                        <a id="btnSend"><i class="bi bi-reply-fill"></i></a> -->
<!--                                                        <div class="input-group-text"> -->
<!--                                                           <a href="#" onclick="document.file_1.click();"><i class="bi bi-camera-fill" style="color: #353535;"></i></a> -->
<!--                                                 <label for="file-input" class="input-group-text file-input-label"> -->
<!--                                                      <i class="bi bi-camera-fill" style="color: #353535;"></i> -->
                                                     
<!--                                                  </label> -->
<!--                                                  <input type="file" id="file-input" style="display: none;"> -->
<!--                                                        </div> -->

                                                
                                                   </div>
                                                   <button class="btn" id ="btnSend">전송</button>
                                                   <br>
                                               </div>
                                           </div>
                                            <div id="sessionSize">
                                            </div>
                                            
                                            <!-- ------------------------------------------------------------ -->
                                           <div class="modal fade" id="notify_model" tabindex="-1" role="dialog" aria-labelledby="notifyModelLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <!-- Modal Header -->
            <div class="modal-header">
                <h4 class="modal-title" id="notifyModelLabel">신고하기</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <form action="report" method="post" enctype="multipart/form-data">
                <!-- Modal Body -->
                <div class="modal-body">
                    <!-- 셀렉트 박스 -->
                    <input type="hidden" name="TO_ID" value="${sessionScope.US_ID}">
                    <div class="form-group">
                        <label for="deliver_category">신고할 사람</label>
                        <select name="FROM_US_ID" id="reportUser" class="form-control" style="width: 200px;">
                        </select>
                    </div>
                    <!-- 라디오박스 -->
                    <div class="form-group">
                        <label>신고 사유</label><br>
                        <c:forEach var="report" items="${reportMap}">
				      		<c:set var="i" value="${i+1}"></c:set>
							<label for="n${i}"><input type="radio" name="RP_CATEGORY" id="n${i}" value="${report.code}">  &nbsp;${report.value}</label> <br>
				      	</c:forEach>
                    </div>
                    <!-- 파일 -->
                    <div class="form-group">
                        <label for="fileInput">이미지는 최대 2장 등록 가능합니다</label>
                        <input type="file" id="fileInput" name="RP_IMG" accept=".png, .jpeg" multiple class="form-control-file">
                    </div>
                    <!-- 내용 입력 -->
                    <div class="form-group">
                        <label for="RP_CONTENT">내용을 입력하세요</label>
                        <textarea name="RP_CONTENT" id="RP_CONTENT" class="form-control" rows="3" maxlength="300" placeholder="내용을 입력하세요"></textarea>
                    </div>
                </div>
                <!-- Modal Footer -->
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

                                            
                                            
                                            
                                            
                                            <!-- ------------------------------------------------------------ -->
                                    </div>
                                 </div>
                                 <div class="product-buy">
                                    <div class="quantity">
                                       <h6>입찰가 입력 :</h6>
                                       <div class="input-group">
                                          <input type="text" class="input-number" id="nowPrice" value="${apdDetail.FINAL_BID_PRICE}">
                                       </div>
                                    </div>
                                    <div class="add-to-cart">
                                       <a class="btn" id="bidding">입찰하기</a>
                                       <a href="#" class="btn min"><i class="ti-heart"></i></a>
                                    </div>
                                    <br>
                                    <div class="quantity" style="margin-top: 5px;">
                                       <h6>즉시 구매가 :</h6>
                                       <div class="input-group">
                                          <input type="text" class="input-number" value="${apdDetail.APD_BUY_NOW_PRICE}" readonly>
                                       </div>
                                    </div>
                                    <div class="add-to-cart">
                                       <a href="#" class="btn" onclick="auctionBuy('${apdDetail.APD_IDX}')">즉시구매</a>
                                       <script type="text/javascript">
                                       		function auctionBuy(APD_IDX){
                                       			let us_id = "${sessionScope.US_ID}";
                                       			let buy_price = "${apdDetail.APD_BUY_NOW_PRICE}";
                                       			if (!us_id || us_id === 'null') {
                                       				Swal.fire({
                                    		            title: '로그인 후 이용이 가능합니다.',         // Alert 제목
                                    		            text: '로그인 후 충전하시고 구매하셔야합니다',  // Alert 내용
                                    		            icon: 'warning',                         // Alert 타입
                                    		        });
                                    		        return false;
                                                }
                                       			$.ajax({
                                                    url : "auctionBuy",
                                                    type : "post",
                                                    data : {
                                                       APD_IDX : APD_IDX,
                                                       Buyer : us_id,
                                                       FINAL_BID_PRICE : buy_price
                                                    },
                                                    dataType : "JSON",
                                                    success: function(response) {
                                                       console.log("성공 : " + response);
                                                    }
                                                 });
                                       		}
                                       </script>
                                       <a href="javascript:void(0);" class="btn btn-danger" data-toggle="modal" data-target="#notify_model">신고</a>
                                    </div>
                                    <div class="add-to-cart" style="margin-top: 5px;">
                                       <form action="https://info.sweettracker.co.kr/tracking/5" method="post">
                                      <input type="hidden" id="t_key" name="t_key" value="4ipWvXbpAF8xJuQEvZYWFQ">
                                      <input type="hidden" name="t_code" id="t_code" value="04">
                                      <input type="hidden" name="t_invoice" id="t_invoice" value="${apdDetail.APD_DELIVERY}">
                                    <button type="submit" class="btn">배송조회</button>
                                </form>
                                    </div>
                                    <input type="button" id="deliveryAlert" value="배송정보 확인">
                                 </div>
                                 <!--/ End Product Buy -->
                              </div>
                           </div>
                        </div>
                        <div class="row">
                           <div class="col-12">
                              <div class="product-info">
                                 <div class="nav-main">
                                    <!-- Tab Nav -->
                                    <ul class="nav nav-tabs" id="myTab" role="tablist">
                                       <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#description" role="tab">상품설명</a></li>
                                       <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#reviews" role="tab">Reviews</a></li>
                                    </ul>
                                    <!--/ End Tab Nav -->
                                 </div>
                                 <div class="tab-content" id="myTabContent">
                                    <!-- Description Tab -->
                                    <div class="tab-pane fade show active" id="description" role="tabpanel">
                                       <div class="tab-single">
                                          <div class="row">
                                             <div class="col-12">
                                                <div class="single-des">
                                                   <p>simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with deskto</p>
                                                </div>
                                                <div class="single-des">
                                                   <p>Suspendisse consequatur voluptates lorem nobis accumsan natus mattis. Optio pede, optio qui metus, delectus! Ultricies impedit, minus tempor fuga, quasi, pede felis commodo bibendum voluptas nisi? Voluptatem risus tempore tempora. Quaerat aspernatur? Error praesent laoreet, cras in fames hac ea, massa montes diamlorem nec quaerat, quos occaecati leo nam aliquet corporis, ab recusandae parturient, etiam fermentum, a quasi possimus commodi, mollis voluptate mauris mollis, quisque donec</p>
                                                </div>
<!--                                                 <div class="single-des"> -->
<!--                                                    <h4>Product Features:</h4> -->
<!--                                                    <ul> -->
<!--                                                       <li>long established fact.</li> -->
<!--                                                       <li>has a more-or-less normal distribution. </li> -->
<!--                                                       <li>lmany variations of passages of. </li> -->
<!--                                                       <li>generators on the Interne.</li> -->
<!--                                                    </ul> -->
<!--                                                 </div> -->
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                    <!--/ End Description Tab -->
                                    <!-- Reviews Tab -->
                                    <div class="tab-pane fade" id="reviews" role="tabpanel">
                                       <div class="tab-single review-panel">
                                          <div class="row">
                                             <div class="col-12">
                                                <div class="ratting-main">
                                                   <div class="avg-ratting">
                                                      <h4>4.5 <span>(Overall)</span></h4>
                                                      <span>Based on 1 Comments</span>
                                                   </div>
                                                   <!-- Single Rating -->
                                                   <div class="single-rating">
                                                      <div class="rating-author">
                                                         <img src="https://via.placeholder.com/200x200" alt="#">
                                                      </div>
                                                      <div class="rating-des">
                                                         <h6>Naimur Rahman</h6>
                                                         <div class="ratings">
                                                            <ul class="rating">
                                                               <li><i class="fa fa-star"></i></li>
                                                               <li><i class="fa fa-star"></i></li>
                                                               <li><i class="fa fa-star"></i></li>
                                                               <li><i class="fa fa-star-half-o"></i></li>
                                                               <li><i class="fa fa-star-o"></i></li>
                                                            </ul>
                                                            <div class="rate-count">(<span>3.5</span>)</div>
                                                         </div>
                                                         <p>Duis tincidunt mauris ac aliquet congue. Donec vestibulum consequat cursus. Aliquam pellentesque nulla dolor, in imperdiet.</p>
                                                      </div>
                                                   </div>
                                                   <!--/ End Single Rating -->
                                                   <!-- Single Rating -->
                                                   <div class="single-rating">
                                                      <div class="rating-author">
                                                         <img src="https://via.placeholder.com/200x200" alt="#">
                                                      </div>
                                                      <div class="rating-des">
                                                         <h6>Advin Geri</h6>
                                                         <div class="ratings">
                                                            <ul class="rating">
                                                               <li><i class="fa fa-star"></i></li>
                                                               <li><i class="fa fa-star"></i></li>
                                                               <li><i class="fa fa-star"></i></li>
                                                               <li><i class="fa fa-star"></i></li>
                                                               <li><i class="fa fa-star"></i></li>
                                                            </ul>
                                                            <div class="rate-count">(<span>5.0</span>)</div>
                                                         </div>
                                                         <p>Duis tincidunt mauris ac aliquet congue. Donec vestibulum consequat cursus. Aliquam pellentesque nulla dolor, in imperdiet.</p>
                                                      </div>
                                                   </div>
                                                   <!--/ End Single Rating -->
                                                </div>
                                                <!-- Review -->
                                                <div class="comment-review">
                                                   <div class="add-review">
                                                      <h5>Add A Review</h5>
                                                      <p>Your email address will not be published. Required fields are marked</p>
                                                   </div>
                                                   <h4>Your Rating</h4>
                                                   <div class="review-inner">
                                                      <div class="ratings">
                                                         <ul class="rating">
                                                            <li><i class="fa fa-star"></i></li>
                                                            <li><i class="fa fa-star"></i></li>
                                                            <li><i class="fa fa-star"></i></li>
                                                            <li><i class="fa fa-star"></i></li>
                                                            <li><i class="fa fa-star"></i></li>
                                                         </ul>
                                                      </div>
                                                   </div>
                                                </div>
                                                <!--/ End Review -->
                                                <!-- Form -->
                                                <form class="form" method="post" action="mail/mail.php">
                                                   <div class="row">
                                                      <div class="col-lg-6 col-12">
                                                         <div class="form-group">
                                                            <label>Your Name<span>*</span></label>
                                                            <input type="text" name="name" required="required" placeholder="">
                                                         </div>
                                                      </div>
                                                      <div class="col-lg-6 col-12">
                                                         <div class="form-group">
                                                            <label>Your Email<span>*</span></label>
                                                            <input type="email" name="email" required="required" placeholder="">
                                                         </div>
                                                      </div>
                                                      <div class="col-lg-12 col-12">
                                                         <div class="form-group">
                                                            <label>Write a review<span>*</span></label>
                                                            <textarea name="message" rows="6" placeholder="" ></textarea>
                                                         </div>
                                                      </div>
                                                      <div class="col-lg-12 col-12">
                                                         <div class="form-group button5">   
                                                            <button type="submit" class="btn">Submit</button>
                                                         </div>
                                                      </div>
                                                   </div>
                                                </form>
                                                <!--/ End Form -->
                                             </div>
                                          </div>
                                       </div>
                                    </div>
                                    <!--/ End Reviews Tab -->
                                 </div>
                              </div>
                           </div>
                        </div>
                     </div>
                  </div>
               </div>
      </section>
      <!--/ End Shop Single -->
      
      <!-- Start Most Popular -->
   <div class="product-area most-popular related-product section">
        <div class="container">
            <div class="row">
            <div class="col-12">
               <div class="section-title">
                  <h2>연관 상품</h2>
               </div>
            </div>
            </div>
            <div class="row">
                <div class="col-12">
                    <div class="owl-carousel popular-slider">
                  <!-- Start Single Product -->
                  <div class="single-product">
                     <div class="product-img">
                        <a href="product-details.html">
                           <img class="default-img" src="https://via.placeholder.com/550x750" alt="#">
                           <img class="hover-img" src="https://via.placeholder.com/550x750" alt="#">
                           <span class="out-of-stock">Hot</span>
                        </a>
                        <div class="button-head">
                           <div class="product-action">
                              <a data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
                              <a title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
                              <a title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
                           </div>
                           <div class="product-action-2">
                              <a title="Add to cart" href="#">Add to cart</a>
                           </div>
                        </div>
                     </div>
                     <div class="product-content">
                        <h3><a href="product-details.html">Black Sunglass For Women</a></h3>
                        <div class="product-price">
                           <span class="old">$60.00</span>
                           <span>$50.00</span>
                        </div>
                     </div>
                  </div>
                  <!-- End Single Product -->
                  <!-- Start Single Product -->
                  <div class="single-product">
                            <div class="product-img">
                                <a href="product-details.html">
                                    <img class="default-img" src="https://via.placeholder.com/550x750" alt="#">
                                    <img class="hover-img" src="https://via.placeholder.com/550x750" alt="#">
                                </a>
                        <div class="button-head">
                           <div class="product-action">
                              <a data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
                              <a title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
                              <a title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
                           </div>
                           <div class="product-action-2">
                              <a title="Add to cart" href="#">Add to cart</a>
                           </div>
                        </div>
                            </div>
                            <div class="product-content">
                                <h3><a href="product-details.html">Women Hot Collection</a></h3>
                                <div class="product-price">
                                    <span>$50.00</span>
                                </div>
                            </div>
                        </div>
                  <!-- End Single Product -->
                  <!-- Start Single Product -->
                  <div class="single-product">
                            <div class="product-img">
                                <a href="product-details.html">
                                    <img class="default-img" src="https://via.placeholder.com/550x750" alt="#">
                                    <img class="hover-img" src="https://via.placeholder.com/550x750" alt="#">
                           <span class="new">New</span>
                                </a>
                        <div class="button-head">
                           <div class="product-action">
                              <a data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
                              <a title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
                              <a title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
                           </div>
                           <div class="product-action-2">
                              <a title="Add to cart" href="#">Add to cart</a>
                           </div>
                        </div>
                            </div>
                            <div class="product-content">
                                <h3><a href="product-details.html">Awesome Pink Show</a></h3>
                                <div class="product-price">
                                    <span>$50.00</span>
                                </div>
                            </div>
                        </div>
                  <!-- End Single Product -->
                  <!-- Start Single Product -->
                  <div class="single-product">
                            <div class="product-img">
                                <a href="product-details.html">
                                    <img class="default-img" src="https://via.placeholder.com/550x750" alt="#">
                                    <img class="hover-img" src="https://via.placeholder.com/550x750" alt="#">
                                </a>
                        <div class="button-head">
                           <div class="product-action">
                              <a data-toggle="modal" data-target="#exampleModal" title="Quick View" href="#"><i class=" ti-eye"></i><span>Quick Shop</span></a>
                              <a title="Wishlist" href="#"><i class=" ti-heart "></i><span>Add to Wishlist</span></a>
                              <a title="Compare" href="#"><i class="ti-bar-chart-alt"></i><span>Add to Compare</span></a>
                           </div>
                           <div class="product-action-2">
                              <a title="Add to cart" href="#">Add to cart</a>
                           </div>
                        </div>
                            </div>
                            <div class="product-content">
                                <h3><a href="product-details.html">Awesome Bags Collection</a></h3>
                                <div class="product-price">
                                    <span>$50.00</span>
                                </div>
                            </div>
                        </div>
                  <!-- End Single Product -->
                    </div>
                </div>
            </div>
        </div>
    </div>
   <!-- End Most Popular Area -->
   
   <!-- Modal -->
    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span class="ti-close" aria-hidden="true"></span></button>
                    </div>
                    <div class="modal-body">
                        <div class="row no-gutters">
                            <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                                <!-- Product Slider -->
                           <div class="product-gallery">
                              <div class="quickview-slider-active">
                                 <div class="single-slider">
                                    <img src="https://via.placeholder.com/569x528" alt="#">
                                 </div>
                                 <div class="single-slider">
                                    <img src="https://via.placeholder.com/569x528" alt="#">
                                 </div>
                                 <div class="single-slider">
                                    <img src="https://via.placeholder.com/569x528" alt="#">
                                 </div>
                                 <div class="single-slider">
                                    <img src="https://via.placeholder.com/569x528" alt="#">
                                 </div>
                              </div>
                           </div>
                        <!-- End Product slider -->
                            </div>
                            <div class="col-lg-6 col-md-12 col-sm-12 col-xs-12">
                                <div class="quickview-content">
                                    <h2>Flared Shift Dress</h2>
                                    <div class="quickview-ratting-review">
                                        <div class="quickview-ratting-wrap">
                                            <div class="quickview-ratting">
                                                <i class="yellow fa fa-star"></i>
                                                <i class="yellow fa fa-star"></i>
                                                <i class="yellow fa fa-star"></i>
                                                <i class="yellow fa fa-star"></i>
                                                <i class="fa fa-star"></i>
                                            </div>
                                            <a href="#"> (1 customer review)</a>
                                        </div>
                                        <div class="quickview-stock">
                                            <span><i class="fa fa-check-circle-o"></i> in stock</span>
                                        </div>
                                    </div>
                                    <h3>$29.00</h3>
                                    <div class="quickview-peragraph">
                                        <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia iste laborum ad impedit pariatur esse optio tempora sint ullam autem deleniti nam in quos qui nemo ipsum numquam.</p>
                                    </div>
                           <div class="size">
                              <div class="row">
                                 <div class="col-lg-6 col-12">
                                    <h5 class="title">Size</h5>
                                    <select>
                                       <option selected="selected">s</option>
                                       <option>m</option>
                                       <option>l</option>
                                       <option>xl</option>
                                    </select>
                                 </div>
                                 <div class="col-lg-6 col-12">
                                    <h5 class="title">Color</h5>
                                    <select>
                                       <option selected="selected">orange</option>
                                       <option>purple</option>
                                       <option>black</option>
                                       <option>pink</option>
                                    </select>
                                 </div>
                              </div>
                           </div>
                                    <div class="quantity">
                              <!-- Input Order -->
                              <div class="input-group">
                                 <div class="button minus">
                                    <button type="button" class="btn btn-primary btn-number" disabled="disabled" data-type="minus" data-field="quant[1]">
                                       <i class="ti-minus"></i>
                                    </button>
                                 </div>
                                 <input type="text" name="quant[1]" class="input-number"  data-min="1" data-max="1000" value="1">
                                 <div class="button plus">
                                    <button type="button" class="btn btn-primary btn-number" data-type="plus" data-field="quant[1]">
                                       <i class="ti-plus"></i>
                                    </button>
                                 </div>
                              </div>
                              <!--/ End Input Order -->
                           </div>
                           <div class="add-to-cart">
                              <a href="#" class="btn">Add to cart</a>
                              <a href="#" class="btn min"><i class="ti-heart"></i></a>
                              <a href="#" class="btn min"><i class="fa fa-compress"></i></a>
                           </div>
                                    <div class="default-social">
                              <h4 class="share-now">Share:</h4>
                                        <ul>
                                            <li><a class="facebook" href="#"><i class="fa fa-facebook"></i></a></li>
                                            <li><a class="twitter" href="#"><i class="fa fa-twitter"></i></a></li>
                                            <li><a class="youtube" href="#"><i class="fa fa-pinterest-p"></i></a></li>
                                            <li><a class="dribbble" href="#"><i class="fa fa-google-plus"></i></a></li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
    </div>
            
   <footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>
 
   <!-- Jquery -->
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-migrate-3.0.0.js"></script>
   <script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
   <!-- Popper JS -->
   <script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
   <!-- Bootstrap JS -->
   <script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
   <!-- Color JS -->
   <script src="${pageContext.request.contextPath}/resources/js/colors.js"></script>
   <!-- Slicknav JS -->
   <script src="${pageContext.request.contextPath}/resources/js/slicknav.min.js"></script>
   <!-- Owl Carousel JS -->
   <script src="${pageContext.request.contextPath}/resources/js/owl-carousel.js"></script>
   <!-- Magnific Popup JS -->
   <script src="${pageContext.request.contextPath}/resources/js/magnific-popup.js"></script>
   <!-- Fancybox JS -->
   <script src="${pageContext.request.contextPath}/resources/js/facnybox.min.js"></script>
   <!-- Waypoints JS -->
   <script src="${pageContext.request.contextPath}/resources/js/waypoints.min.js"></script>
   <!-- Countdown JS -->
   <script src="${pageContext.request.contextPath}/resources/js/finalcountdown.min.js"></script>
   <!-- Nice Select JS -->
<%--    <script src="${pageContext.request.contextPath}/resources/js/nicesellect.js"></script> --%>
   <!-- Ytplayer JS -->
   <script src="${pageContext.request.contextPath}/resources/js/ytplayer.min.js"></script>
   <!-- Flex Slider JS -->
   <script src="${pageContext.request.contextPath}/resources/js/flex-slider.js"></script>
   <!-- ScrollUp JS -->
   <script src="${pageContext.request.contextPath}/resources/js/scrollup.js"></script>
   <!-- Onepage Nav JS -->
   <script src="${pageContext.request.contextPath}/resources/js/onepage-nav.min.js"></script>
   <!-- Easing JS -->
   <script src="${pageContext.request.contextPath}/resources/js/easing.js"></script>
   <!-- Active JS -->
   <script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
</body>
</html>