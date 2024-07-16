<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>    
<!DOCTYPE html>
<html class="no-js">
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<title>🥒챗봇🥒</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<!-- 아이콘 사용 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
		
<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatting/chattingRoom.css">

<!-- 글씨체 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">
<style type="text/css"></style>
<style type="text/css">
	
 	.input-group-text { 
 		cursor: pointer;
 	} 
	
 	 .m-b-0 { 
 	  font-family: "Noto Sans KR", sans-serif; 
 	  font-optical-sizing: auto; 
 	  font-style: normal; 
 	} 
	
 	#intro { 
 		margin-left:130px; 
 	} 
		
	/* 로고창*/
 	.logo-container {
 	    display: flex; 
 	    flex-direction: column; 
 	    align-items: center; 
 	    margin-top: 50px; 
 	    margin-bottom: 30px; 
 	}  
 	/* 로고 이미지 */ 
  	 #frame .content #chat-form .chat .logo-container .logo-image {  
  	    width: 100px ; /* 이미지 크기는 적절히 조정 */  
  	    height: 100px ; 
  	    object-fit: cover ; 
  	}  
	/* 로고 텍스트 */
 	.logo-text { 
 		margin-top: 20px; 
 	    font-size: 20px; /* 텍스트 크기는 적절히 조정 */ 
 	    font-weight: bold; 
 	    text-align: center;
 	} 
 	/* 챗봇 채팅 이미지 */
 	#frame .content .chat #chat-container .sent img{ 
 		width: 50px; /* 이미지 크기는 적절히 조정 */ 
 	    height: 50px; 
 	} 
 	/* 유저 채팅 이미지*/
 	#frame .content .chat #chat-container .replies img{ 
 		width: 50px; /* 이미지 크기는 적절히 조정 */ 
 	    height: 50px; 
 	    float: right;
 	} 
 	/* 유저 채팅 */
 	#frame .content .chat ul li.replies p{ 
 		background: #f5f5f5; 
   		float: right; 
 	} 
 	
 	
	#frame .content .chat li {
		list-style: none;
	}
	
	.chat {
	    height: calc(100vh - 150px); /* 적절한 높이로 설정 */
	    overflow-y: auto;
	    padding-bottom: 10px; /* 입력창과의 간격 추가 */
	}
	.chat-message {
	    position: fixed;
	    bottom: 0;
	    width: 100%;
	    background: white; /* 배경색 설정 */
	    padding: 10px;
	    box-shadow: 0 -2px 5px rgba(0,0,0,0.1); /* 약간의 그림자 효과 */
	}
		 
</style>
<script src="https://cdn.jsdelivr.net/npm/@google/generative-ai/dist/esm/index.min.js"></script>

<script type="text/javascript">

	window.onbeforeunload = function() {
	  return "창을 닫으시겠습니까?";
	};
	
</script>
</head>
<body>

	<%-- 뒤로가기 상단바 --%>
   	<div style="background-color:#34A853; height:50px; display: flex; justify-content: center; align-items: center;">
   		<span style="color:white; padding : 5px;"> 🥒 Oi 챗봇 🥒</span>
   	</div>
   	
     <div id="frame">
		<div class="content">
			<div class="contact-profile">
<%-- 				<img src="${pageContext.request.contextPath }/resources/images/chatbot.png" alt="" /> --%>
<!-- 				<p>피클</p> -->
			</div>
			<form action="" method="post" id="chat-form">
				<div class="chat">
					<div class="logo-container"  >
						<img class="logo-image" src="${pageContext.request.contextPath }/resources/images/chatbot2.PNG" alt="" />
						<h2 class="logo-text">피클이한테 문의하기</h2>
					</div>
					<ul class="m-b-0" id="chat-container">
						<li class="sent">
							<img src="${pageContext.request.contextPath }/resources/images/chatbot2.PNG" alt="" />
							<p>안녕하세요. 피클입니다!<br> 
							궁금한게 있으시다면 피클한테 물어보면 바로 대답해 드릴게요!<br>
						</li>
					</ul>
					
				</div>
				<div class="chat-message clearfix" style="margin-bottom:0px">
					<div class="input-group mb-0">
						<input type="text" class="form-control" placeholder="메세지를 입력하세요" id="msg_input">              
						<button type="submit" id="msg_btn">
							<i class="bi bi-reply-fill" aria-hidden="true"></i>
						</button>
						<input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
<%-- 						<c:choose> --%>
<%-- 							<c:when test="${not empty member.member_img}"> --%>
<%-- 								<input type="hidden" id="member_img" value="${pageContext.request.contextPath}/resources/upload/${member.member_img}"> --%>
<%-- 							</c:when> --%>
<%-- 							<c:otherwise> --%>
<%-- 								<input type="hidden" id="member_img" value="${pageContext.request.contextPath}/resources/img/default_user_img.png"> --%>
<%-- 							</c:otherwise> --%>
<%-- 						</c:choose> --%>
					</div>
				</div>
			</form>
		</div>
	</div>
	<script type="importmap">
      {
        "imports": {
          "@google/generative-ai": "https://esm.run/@google/generative-ai"
        }
      }
    </script>
            <!-- 부트스트랩 -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
    <script type="module" src="${pageContext.request.contextPath }/resources/js/chat_module.js"></script>
</body>
</html>