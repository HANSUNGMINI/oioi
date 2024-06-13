<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
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
		
<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatting/chattingRoom.css">

<style type="text/css">
	.input-group-text {
		cursor: pointer;
	}
</style>

<script type="text/javascript">

	window.onbeforeunload = function() {
	  return "창을 닫으시겠습니까?";
	};
	
</script>
</head>
<body>

	<%-- 뒤로가기 상단바 --%>
   	<div style="background-color:#34A853; height:50px">
   	</div>
   	
     <div class="chat">
     
     			<%-- 사용자 정보 및 신고 --%>
                <div class="chat-header clearfix">
				    <div class="row">
				        <div class="col-lg-12">
				            <div class="chat-about text-center">
				                <h6 class="m-b-0">안녕하세요. 오이마켓 고객센터 챗봇입니다. <br>
									아래 주요 메뉴를 선택하거나, 궁금한 내용을 질문해 보세요.</h6>
				            </div>
				        </div>
				    </div>
				    <hr>
				</div>
                
                <%-- 채팅 내역 --%>
                <div class="chat-history" >
                    <ul class="m-b-0">
                        
                        <li class="clearfix">
                            <div class="message-data text-right">
                            	<%-- 로그인 한 사람 이미지 --%>
                                <img src="https://img.freepik.com/premium-vector/cucumber-character-with-angry-emotions-grumpy-face-furious-eyes-arms-legs-person-with-irritated-expression-green-vegetable-emoticon-vector-flat-illustration_427567-3816.jpg?w=360" alt="avatar">
                            </div>
                            <div class="message other-message float-right"> 안녕 </div>
                        </li>
                        
                        <li class="clearfix">
                            <div class="message my-message">ㅎㅇ</div>
                        </li>
                                                       
                        <li class="clearfix">
                            <div class="message my-message">시간왜이래</div>
                        </li>
                        
                    </ul>
                </div>

                <%-- 메세지 전송 --%>
                <form action="">
	                <div class="chat-message clearfix" style="margin-bottom:0px">
	                    <div class="input-group mb-0">
			                <%-- 전송란 --%>
	                        <input type="text" class="form-control" placeholder="메세지를 입력하세요">                                    
	
	                        <%-- 전송버튼 --%>
	                        <div class="input-group-prepend">
	                            <a class="input-group-text"><i class="bi bi-reply-fill"></i></a>
	                        </div>
	                    </div>
	                </div>
                </form>
            </div>
            
            <!-- 부트스트랩 -->
            
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
</body>
</html>