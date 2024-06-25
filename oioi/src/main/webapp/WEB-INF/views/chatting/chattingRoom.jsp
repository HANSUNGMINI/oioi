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
		
<!-- CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/chatting/chattingRoom.css">

<!-- 글씨체 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

 <!-- SweetAlert CSS -->
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">

<style>
		.tempImg {
            display: block;
            margin: 10px 0;
             width: 100px;
            height: 100px;
        }
        .addImg {
            cursor: pointer;
        }
        .preView {
            display: flex;
            gap: 10px;
        }
        .previewImg {
            width: 100px;
            height: 100px;
        }
        
        .previewImgWrapper {
	    position: relative;
	    display: inline-block;
	    margin: 5px;
		}
		
		.deleteBtn {
		    position: absolute;
		    top: 5px;
		    right: 5px;
		    background-color: red;
		    color: white;
		    border: none;
		    border-radius: 50%;
		    cursor: pointer;
		    font-size: 12px;
		    width: 20px;
		    height: 20px;
		    text-align: center;
		    line-height: 18px;
		}
</style>

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
			
			Swal.fire({
				   title: '거래 완료하시겠습니까?',
				   text: '거래 완료 버튼 클릭 시, 페이가 송금되며 취소 불가능합니다',
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
						document.querySelector("#detail").style.display = "none";
						document.querySelector("#review").style.display = "block";
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

		/* 별점 매기기 */
		function setRating(value, reservIdx) {
		    var ratingValueId = "ratingValue" + reservIdx;
		    document.getElementById(ratingValueId).value = value;
		    
		    var stars = document.querySelectorAll("#rating" + reservIdx + " span");
		    for (var i = 0; i < stars.length; i++) {
		        if (i < value) {
		            stars[i].innerHTML = '<i class="bi bi-star-fill" style="color: #FFE000;"></i>';
		        } else {
		            stars[i].innerHTML = '<i class="bi bi-star-fill"></i>';
		        }
		    }
		}
		
		/* 상점 바로가기 */
		function goStore(){
			window.opener.location.href="myStore"; 
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

</head>
<body>
	 <!-- SweetAlert JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>

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
                            <a href="javascript:void(0);" onclick="goStore()">
                                <img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20231201_11%2F1701407251569KtFaW_JPEG%2F2577731462313581_1635528623.jpg&type=sc960_832" alt="avatar">
                            </a>
                            <div class="chat-about">
                                <h6 class="m-b-0">닉네임</h6>
                                <small> 신선도 : 38.5 </small>
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
						<a href="javascript:void(0);" data-toggle="modal" data-target="#detail_model">나이키 신발</a>에 대한 이야기를 시작해 보세요
					</div>

                    <ul class="m-b-0">
                        
                        <li class="clearfix">
                            <div class="message-data text-right">
                            	<%-- 로그인 한 사람 이미지 --%>
                                <img src="https://img.freepik.com/premium-vector/cucumber-character-with-angry-emotions-grumpy-face-furious-eyes-arms-legs-person-with-irritated-expression-green-vegetable-emoticon-vector-flat-illustration_427567-3816.jpg?w=360" alt="avatar">
                            </div>
                            <div class="message other-message float-right"> 김유신 바보 </div>
                            <small class="message-data-time" style="margin-right:0px">10:10 AM</small>
                        </li>
                        
                        <li class="clearfix">
                            <div class="message my-message"> 이자민 바보 </div>
                            <small class="message-data-time" style="margin-bottom:-20px">10:10 AM</small>                              
                        </li>
                                                       
                        <li class="clearfix">
                            <div class="message my-message"> 이시윤 바보</div><small class="message-data-time">10:10 AM</small>
                        </li>
                        <li class="clearfix">
                            <div class="message my-message"> 다 바보</div><small class="message-data-time">10:10 AM</small>
                        </li>
                        
                    </ul>
                </div>
				
				
                <%-- 메세지 전송 --%>
                <div class="chat-message clearfix" style="margin-bottom:0px">
                 	<!-- 사진 미리보기 영역 -->
					<div id="preview-container" style="display: flex; margin-top: 3px; margin-bottom:10px"></div>
					
                    <div class="input-group mb-0">
		                <%-- 전송란 --%>
                        <input type="text" class="form-control" placeholder="메세지를 입력하세요">                                    

                        <%-- 전송버튼 --%>
                        <div class="input-group-prepend">
                            <a class="input-group-text"><i class="bi bi-reply-fill"></i></a>
<!--                             <div class="input-group-text"> -->
<!-- 	                            <a href="#" onclick="document.file_1.click();"><i class="bi bi-camera-fill" style="color: #353535;"></i></a> -->
							<label for="file-input" class="input-group-text file-input-label">
						        <i class="bi bi-camera-fill" style="color: #353535;"></i>
						    </label>
						    <input type="file" id="file-input" style="display: none;">
<!--                             </div> -->
                        </div>
                    </div>
                    
                   
                </div>
            </div>
            
            <script>
            
            	/* 사진 미리 보기*/
	            document.getElementById('file-input').addEventListener('change', function(event) {
			    const previewContainer = document.getElementById('preview-container');
			    previewContainer.innerHTML = ''; // 이전 미리보기 초기화
			
			    const files = event.target.files;
			
			    for (let i = 0; i < files.length; i++) {
			        const file = files[i];
			
			        if (file.type.startsWith('image/')) {
			            const reader = new FileReader();
			
			            reader.onload = function(e) {
			                const previewItem = document.createElement('div');
			                previewItem.classList.add('preview-item');
			
			                const img = document.createElement('img');
			                img.src = e.target.result;
			
			                const deleteButton = document.createElement('button');
			                deleteButton.innerText = '×';
			                deleteButton.classList.add('delete-button');
			                deleteButton.addEventListener('click', function() {
			                    previewContainer.removeChild(previewItem);
			                    // 파일 입력값 초기화
			                    document.getElementById('file-input').value = '';
			                });
			
			                previewItem.appendChild(img);
			                previewItem.appendChild(deleteButton);
			                previewContainer.appendChild(previewItem);
			            }
			
			            reader.readAsDataURL(file);
			        }
			    }
			});
			</script>
            
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
			        <h4 class="modal-title">신고 이력 조회</h4>
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
			      	<form enctype="multipart/form-data">
			      	
				      <%-- 라디오박스 --%>
				      	<c:forEach var="report" items="${reportMap}">
				      		<c:set var="i" value="${i+1}"></c:set>
							<label for="n${i}"><input type="radio" name="RP_CATEGORY" id="n${i}" value="${report.code}">  &nbsp;${report.value}</label> <br>
				      	</c:forEach>
						
						<%-- 파일 --%>
						<div style="padding:5px;">
		                    <small>이미지는 최대 2장 등록 가능합니다</small>
		                    
					         <input type="file" id="fileInput" style="display: none;" accept=".png, .jpeg" multiple>
							<div class="preView">
								<img src="${pageContext.request.contextPath}/resources/images/submitIMG.png"  class="tempImg addImg" id="uploadTrigger">
							</div>
						</div>
						
						<%-- 내용 입력 --%>
						<textarea placeholder="내용을 입력하세요" style = "resize : none" name="RP_CONTENT"  id="RP_CONTENT" maxlength="300"></textarea>
					</form>			      
				  </div>
				  
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-success">신고하기</button>
			        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			      </div>
			
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
			
			      <!-- Modal body -->
			      <div class="modal-body">
			       <form action="reviewWrite" method="post">
			       		<div id="review_category" style="text-align: justify;">
				       		<%-- 체크박스 --%>
				       		<label for="chk1"><input type="checkbox" id="chk1" name="chk2"> &nbsp;답장이 빨라요</label><br>
				       		<label for="chk2"><input type="checkbox" id="chk2" name="chk2"> &nbsp;친절해요</label><br>
				       		<label for="chk3"><input type="checkbox" id="chk3" name="chk3"> &nbsp;물건 상태가 좋아요</label><br>
				       		<label for="chk4"><input type="checkbox" id="chk4" name="chk4"> &nbsp;포장이 깔끔해요</label><br>
				       		<label for="chk5"><input type="checkbox" id="chk5" name="chk5"> &nbsp;상품 설명과 실제 상품이 동일해요</label><br>
				       		<label for="chk6"><input type="checkbox" id="chk6" name="chk6"> &nbsp;기타</label><br>
			       		</div>
			      		<hr>
			       
		       		    <div id="rating">
			       			별점을 선택해 주세요 <br>
						   <span onclick=""><i class="bi bi-star"></i></span>
                           <span onclick=""><i class="bi bi-star"></i></span>
                           <span onclick=""><i class="bi bi-star"></i></span>
                           <span onclick=""><i class="bi bi-star"></i></span>
                           <span onclick=""><i class="bi bi-star"></i></span>
                        </div>
						<textarea placeholder="내용을 입력하세요" style = "resize : none" name="review_content"  id="review_content" maxlength="600" required="required"></textarea>			      
                   </form>
				  </div>
				  
			      <!-- Modal footer -->
			      <div class="modal-footer">
			        <button type="submit" class="btn btn-success">리뷰 작성하기</button>
			        <button type="button" class="btn btn-danger" data-dismiss="modal">닫기</button>
			      </div>
			
			    </div>
			  </div>
			</div>     

		<%-- 제품 상세보기 --%>
			
			<div class="modal" id="detail_model">
			  <div class="modal-dialog">
			    <div class="modal-content">
			
			      <!-- Modal Header -->
			      <div class="modal-header">
			        <h4 class="modal-title">제품 상세보기</h4>
			      </div>
			
			      <!-- Modal body -->
			      <div class="modal-body">
			      
			      	<%-- 이미지 --%>
			      	<div class="img-container">
			      		<img id="pd_img" src="https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/3e8455ad-c00c-4996-a85a-b5c4d38c6ae2/v2k-%EB%9F%B0-%EC%8B%A0%EB%B0%9C-TeZkXP2L.png">
			      	</div>
			      	
			      	<div style="padding:10px; text-align: center">
				      	상품명 : <span>신발</span> <span class="price-dec">예약 중</span> <br>
				      	가격 : <span>10000원</span><br>
				      	상세설명
				      	<div style= "border:1px solid #ccc; border-radius: 8px; height:40%">
				      		깨끗함 안 신음
				      	</div>
			      	</div>
			      	
			      </div>
			
			      <!-- Modal footer -->
			      <div class="modal-footer">
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