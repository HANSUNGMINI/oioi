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

<script type="text/javascript">
	
		/* 상세보기 나오기 */
		function showDetail(){
			let datail= document.querySelector("#detail");
			if (detail.style.display == "none") {
				detail.style.display = "block";
			} else {
				detail.style.display = "none";
			}
		}
		
		/* 거래완료 */
		function transaction() {
			confirm("거래 완료하시겠습니까?");
		}
		
		/* 대화방 나가기 */
		function exit() {
			confirm("*** 님과의 대화방을 나가시겠습니까?");
		}
	</script>

</head>
<body>

	<%-- 뒤로가기 상단바 --%>
   	<div style="background-color:#34A853;">
          <a href="#" onClick="history.back()"><i class="bi bi-chevron-left" style="font-size: 2rem; color: white;"></i></a>
   	</div>
   	
   	
     <div class="chat">
     
     			<%-- 사용자 정보 및 신고 --%>
                <div class="chat-header clearfix">
                    <div class="row">
                        <div class="col-lg-6">
                        	<%-- 사용자 정보 --%>
                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
                                <img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20231201_11%2F1701407251569KtFaW_JPEG%2F2577731462313581_1635528623.jpg&type=sc960_832" alt="avatar">
                            </a>
                            <div class="chat-about">
                                <h6 class="m-b-0">닉네임</h6>
                                <small>상품 : <a href="#">나이키 신발</a></small>
                            </div>
                        </div>
                        
                        <%-- 신고창 및 상세정보 --%>
                        <div class="col-lg-6 hidden-sm text-right">
                            <a href="javascript:void(0);" class="btn btn-danger" data-toggle="modal" data-target="#notify_model">신고</a>
                            <a href="javascript:void(0);" class="btn btn-success" onclick="showDetail()"><i class="bi bi-list"></i></a>
	                        <div id="detail">
	                        	<ul>
		                        	<li><a id="d2" data-toggle="modal" data-target="#regist_model">운송장 등록</a></li>
		                        	<li><a id="d3" onclick="transaction()">거래 완료</a></li>
		                        	<li><a id="d4" data-toggle="modal" data-target="#fraud_model">사기 이력 조회</a></li>
	    	                    	<li><a id="d5" onclick="exit()">대화방 나가기</a></li>
	                        	</ul>
	                        </div>
	                       	<hr>
                        </div>
                    </div>
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
                            <small class="message-data-time" style="margin-right:0px">10:10 AM</small>
                        </li>
                        
                        <li class="clearfix">
                            <div class="message my-message">ㅎㅇ</div>
                            <small class="message-data-time" style="margin-bottom:-20px">10:10 AM</small>                              
                        </li>
                                                       
                        <li class="clearfix">
                            <div class="message my-message">시간왜이래</div><small class="message-data-time">10:10 AM</small>
                        </li>
                        
                    </ul>
                </div>

                <%-- 메세지 전송 --%>
                <div class="chat-message clearfix" style="margin-bottom:0px">
                    <div class="input-group mb-0">
		                <%-- 전송란 --%>
                        <input type="text" class="form-control" placeholder="메세지를 입력하세요">                                    

                        <%-- 전송버튼 --%>
                        <div class="input-group-prepend">
                            <a class="input-group-text"><i class="bi bi-reply-fill"></i></a>
                            <div class="input-group-text">
	                            <a href="#"><i class="bi bi-camera-fill" style="color: #353535;"></i></a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
            <%-- 운송장 등록 --%>
			
			<div class="modal" id="regist_model">
			  <div class="modal-dialog">
			    <div class="modal-content">
			
			      <!-- Modal Header -->
			      <div class="modal-header">
			        <h4 class="modal-title">운송장 등록</h4>
			      </div>
			
			      <!-- Modal body -->
			      <div class="modal-body">
			      
			      	<%-- 택배사 선택 --%>
			        <select name="deliver_category" id="deliver_category" style = "margin-left : 15px">
	 					<option value =""> 택배사 선택 </option>
	 					<option value ="reservation"> 대한통운 </option>
	 					<option value ="function"> 우체국택배 </option>
	 					<option value ="price"> 편의점택배 </option>
	 				</select>
	
			      	<%-- 운송장 번호 --%>
			      	<input type="text" placeholder="운송장번호를 입력해 주세요" id="num" required="required">
			      </div>
			
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-success">등록</button>
			        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			      </div>
			
			    </div>
			  </div>
			</div>     
			
            <%-- 사기 이력 조회 --%>
			
			<div class="modal" id="fraud_model">
			  <div class="modal-dialog">
			    <div class="modal-content">
			
			      <!-- Modal Header -->
			      <div class="modal-header">
			        <h4 class="modal-title">사기 이력 조회</h4>
			      </div>
			
			      <!-- Modal body -->
			      <div class="modal-body">
			      
			      	<%-- 계좌 번호 입력 --%>
			      	계좌번호 조회 &nbsp;
			      	<input type="text" placeholder="계좌번호를 입력해 주세요" id="num"> <button type="submit" class="btn btn-success">조회</button>
					<div id="fraud_result"></div>
					<hr>
			      	휴대번호 조회 &nbsp;
			      	<input type="text" placeholder="휴대번호를 입력해 주세요" id="num"> <button type="submit" class="btn btn-success">조회</button>
			      	<div id="fraud_result"></div>
			      </div>
			
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			      </div>
			
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
			
			      <!-- Modal body -->
			      <div class="modal-body">
			      
			      <%-- 체크박스 --%>
					<input type="radio" name="notify">  &nbsp;욕설 및 비방을 해요 <br>
					<input type="radio" name="notify">  &nbsp;사기인 것 같아요 <br>
					<input type="radio" name="notify">  &nbsp;머하지 또 <br>
					<input type="radio" name="notify">  &nbsp;기타 부적절한 행위가 있어요 <br>
					
					<textarea placeholder="내용을 입력하세요" style = "resize : none" name="notify_content"  id="notify_content" maxlength="600"></textarea>			      
				  </div>
				  
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-success">신고하기</button>
			        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			      </div>
			
			    </div>
			  </div>
			</div>     


            
            <!-- 부트스트랩 -->
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
</body>
</html>