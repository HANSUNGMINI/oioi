<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OI Pay</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<!-- 부트스트랩 CSS -->
<link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
<!-- 폰트 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<style type="text/css">
    /* 전역 스타일 */
    * {
        font-family: "Noto Sans KR", sans-serif;
        font-optical-sizing: auto;
        font-style: normal;
    }

    body {
        margin-top: 20px;
        background-color: #eee;
    }

    /* 컨테이너 스타일 */
    .container {
        max-width: 960px; /* 필요에 따라 컨테이너 너비 조정 */
        margin: 0 auto;
        padding: 0 15px;
    }

    /* 작업 상자 스타일 */
    .job-box {
        background: #ffffff;
        padding: 20px;
        border: 1px solid #e8eef1;
        margin-bottom: 20px;
    }

    /* 충전 금액 섹션 스타일 */
    .chargeMoney {
        text-align: center;
        padding: 20px 0; /* 간격을 더 넓게 설정 */
    }

    #price {
        display: grid; /* 그리드 레이아웃 사용 */
        grid-template-columns: repeat(2, 1fr); /* 2열로 설정 */
        gap: 5px; /* 간격 설정 */
        justify-items: center; /* 중앙 정렬 */
    }

    .charge input[type="radio"] {
        accent-color: #34a853; /* 라디오 버튼 색상 맞춤 */
    }

    .charge label {
        margin: 10px; /* 라디오 버튼 간 간격 조정 */
    }

    .charge input[type="number"] {
        margin-top: 10px;
        margin-bottom: 10px;
        padding: 10px;
        width: calc(100% - 22px); /* 패딩과 테두리를 포함한 너비를 적절히 조정 */
        max-width: 300px; /* 최대 너비를 제한하여 너무 길어지지 않도록 함 */
        border: 1px solid #e8eef1;
        border-radius: 5px;
        box-sizing: border-box; /* 패딩과 테두리를 너비에 포함하도록 설정 */
        display: inline-block; /* 정렬을 위해 인라인 블록 요소로 표시 */
        vertical-align: middle; /* 버튼과 수직으로 정렬 */
    }

    .charge .payCharge,
    .charge .payRefund {
        background-color: #34a853;
        color: white;
        text-decoration: none;
        border: none;
        font-size: 15px;
        cursor: pointer;
        padding: 10px 20px;
        border-radius: 5px;
        margin-left: 10px; /* 버튼 사이의 좌우 마진 추가 */
    }

    .charge .payRefund {
        background-color: #e53935; /* 출금 버튼 색상 조정 */
    }

    /* 작업 상자 필터 스타일 */
    .job-box-filter {
        padding: 12px 15px;
        background: #ffffff;
        border-bottom: 1px solid #e8eef1;
        margin-bottom: 20px;
    }

    .job-box-filter img {
        width: 150px;
        height: auto;
    }

    .job-box-filter .text-right {
        text-align: right;
    }

    .job-box-filter a.filtsec {
        display: inline-block;
        margin-right: 15px;
        padding: 4px 10px;
        font-family: 'Quicksand', sans-serif;
        transition: all ease 0.4s;
        background: #edf0f3;
        border-radius: 50px;
        font-size: 13px;
        color: #81a0b1;
        border: 1px solid #e2e8ef;
    }

    .job-box-filter a.filtsec.active {
        color: #ffffff;
        background: #16262c;
        border-color: #16262c;
    }

    .job-box-filter a.filtsec i {
        color: #03a9f4;
        margin-right: 5px;
    }

    .job-box-filter a.filtsec:hover,
    .job-box-filter a.filtsec:focus {
        color: #ffffff;
        background: #07b107;
        border-color: #07b107;
    }

    .job-box-filter a.filtsec:hover i,
    .job-box-filter a.filtsec:focus i {
        color: #ffffff;
    }

    .job-box-filter h4 i {
        margin-right: 10px;
    }

    /* 메시지 스타일 */
    .inbox-message ul {
        padding: 0;
        margin: 0;
    }

    .inbox-message ul li {
        list-style: none;
        position: relative;
        padding: 3px 8px;
        border-bottom: 1px solid #e8eef1;
    }

    .inbox-message ul li:hover,
    .inbox-message ul li:focus {
        background: #eff6f9;
    }

    .inbox-message .message-avatar {
        position: absolute;
        left: 30px;
        top: 50%;
        transform: translateY(-50%);
    }

    .inbox-message .message-avatar img {
        display: inline-block;
        width: 45px;
        height: 45px;
        border-radius: 50%;
    }

    .inbox-message .message-body {
        margin-left: 85px;
        font-size: 15px;
        color: #62748f;
    }

    .message-body-heading h5 {
        font-weight: 500;
        display: inline-block;
        color: #62748f;
        margin: 0 0 7px 0;
    }

    /* 메시지 인디케이터 스타일 */
    .message-body h5 span {
        border-radius: 50px;
        line-height: 10px;
        font-size: 13px;
        color: #fff;
        padding: 4px 6px;
        margin-left: 5px;
        margin-top: -5px;
    }

    .message-body h5 span.unread {
        background: #07b107;
    }

    .message-body h5 span.important {
        background: #dd2027;
    }

    .message-body h5 span.pending {
        background: #2196f3;
    }

    .message-body-heading span {
        float: right;
        color: #62748f;
        font-size: 14px;
    }

    .messages-inbox .message-body p {
        margin: 0;
        padding: 0;
        line-height: 27px;
        font-size: 15px;
    }

    /* 호버 효과 */
    a:hover {
        text-decoration: none;
    }
    
	#amtInput{
		width : 90%;
		margin-top: 20px;
	}

    /* 반응형 스타일 */
    @media (max-width: 768px) {
        .container {
            padding: 0 10px; /* 작은 화면에 대한 패딩 조정 */
        }

        .job-box {
            padding: 15px; /* 작은 화면에 대한 패딩 조정 */
        }

        .charge input[type="number"] {
            width: 100%; /* 작은 화면에서 텍스트 입력 필드 너비를 100%로 설정 */
            max-width: none; /* 최대 너비 제한 해제 */
        }

        .charge .payCharge,
        .charge .payRefund {
            width: 90%; /* 작은 화면에서 버튼 너비를 100%로 설정 */
            margin-left: 0; /* 왼쪽 마진 제거 */
            margin-top: 10px; /* 위쪽 마진 추가 */
        }
    }
    
	input[type=number]::-webkit-outer-spin-button,
	input[type=number]::-webkit-inner-spin-button {
	    -webkit-appearance: none;
	    margin: 0;
	}
	
	input[type=number] {
	    -moz-appearance: textfield; /* Firefox에서 화살표 제거 */
	}
    

</style>

<script>
    $(document).ready(function () {
	
		$("#amtInput").on("input", function() { // 금액 입력 시 라디오버튼 체크해제
			$("input[name='chargeAmt']").prop("checked", false);
		});
		
		// 모든 라디오 버튼 요소를 가져옴
		let radioButtons = document.querySelectorAll('input[name="chargeAmt"]');

		// 텍스트 입력 요소를 가져옴
		let amtInput = document.getElementById('amtInput');

		// 라디오 버튼에 클릭 이벤트 리스너 추가
		radioButtons.forEach((radio) => {
		    radio.addEventListener('click', () => {
		        if (radio.checked) {
		            amtInput.value = radio.value; // 선택된 라디오 버튼의 value를 텍스트 입력 필드에 설정
		        }
		    });
		});


        // 충전하기 버튼 클릭 시
        $(".payCharge").on("click", function () {
        	
        	
	       	let fintech_use_num = $("#fintech_use_num").val();
        	let account_holder_name = $("#account_holder_name").val();
        	let account_num_masked = $("#account_num_masked").val();
        	
        	if(amtInput.value) {
        		$.ajax({
                type: "POST",
                url: "payCharge", 
				data: {
                	"amtInput" : amtInput.value,
                	"fintech_use_num" : fintech_use_num,
                	"account_holder_name" : account_holder_name,
                	"account_num_masked" : account_num_masked
                },
//                 dataType : "json",
                success: function (response) {
                    if(response != null){
                    	alert(amtInput.value+ "머니가 충전되었습니다.");
                    	window.opener.location.reload();
                    	window.location.reload();
                    	
                    } else{
                    	alert("충전 실패😭😭");
                    }
                    
                },
                error: function (err) {
                    alert("충전하기 요청 실패");
                }
            });
        		
        	}
            
        });

        // 출금하기 버튼 클릭 시
//         $(".payRefund").click(function () {
//             $.ajax({
//                 type: "POST",
//                 url: "yourRefundUrl", 
//                 data: {
                	
//                 },
//                 dataType : {
                	
//                 },
//                 success: function (response) {
                    
//                 },
//                 error: function () {
//                     alert("출금하기 요청 실패");
//                 }
//             });
//         });
        
        
    });
    
    
</script>

</head>

<body>
    <div class="container">
        <div class="row">
            <div class="col-md-8">
                <div class="chat_container">
                    <div class="job-box">
                        <div class="job-box-filter">
                            <!-- 로고 이미지 -->
                            <div class="row">
                                <img alt="logo"
                                    src="${pageContext.request.contextPath}/resources/images/logo.png"
                                    style="width: 150px; height: auto;">
                            </div>
                        </div>
                        <div class="inbox-message">
                            <div class="chargeMoney">
                                <form class="charge">
                                	<!-- 잔액 조회 -->
                                	<h6>연결계좌 : ${bankUserInfo.res_list[0].bank_name} - ${bankUserInfo.res_list[0].account_num_masked}</h6>
                                	<br>
                                	<h5>오이머니 잔액 : 🥒<fmt:formatNumber value="${token.US_OIMONEY}" pattern="#,###"/></h5>
                                
                                	<br>
                                    <!-- 충전 금액 선택 -->
                                    <div id="price" >
                                        <label><input type="radio" value="5000" name="chargeAmt">&nbsp;&nbsp;&nbsp;5,000원</label>
                                        <label><input type="radio" value="10000" name="chargeAmt"> 10,000원</label>
                                        <label><input type="radio" value="15000" name="chargeAmt"> 15,000원</label>
                                        <label><input type="radio" value="20000" name="chargeAmt"> 20,000원</label>
                                        <label><input type="radio" value="25000" name="chargeAmt"> 25,000원</label>
                                        <label><input type="radio" value="30000" name="chargeAmt"> 30,000원</label>
                                    </div>
                                    <input type="number" id="amtInput"  placeholder="금액을 입력하세요(숫자만 입력 가능합니다)">
									<c:forEach var="account" items="${bankUserInfo.res_list}">
										<tr>
											<td>
												<input type="hidden" name="fintech_use_num" id="fintech_use_num" value="${account.fintech_use_num}">
												<input type="hidden" name="account_holder_name" id="account_holder_name" value="${account.account_holder_name}">
												<input type="hidden" name="account_num_masked" id="account_num_masked" value="${account.account_num_masked}">
											</td>
										</tr>
									</c:forEach>
                                    <br>
                                    <!-- 충전 및 출금 버튼 -->
<!--                                     <div class="col-md-6 col-sm-6"> -->
                                        <input type="button" class="payCharge" value="충전하기">
                                        <input type="button" class="payRefund" value="출금하기">
<!--                                     </div> -->
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>

</html>
