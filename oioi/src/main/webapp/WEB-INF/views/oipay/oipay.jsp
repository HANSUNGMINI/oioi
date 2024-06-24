<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>OI Pay</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>

<!-- 글씨체 -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100..900&display=swap" rel="stylesheet">

<style type="text/css">

	* {
	  font-family: "Noto Sans KR", sans-serif;
	  font-optical-sizing: auto;
	  font-style: normal;
	  
	}

	body{
	margin-top:20px;
	background-color:#eee;
	
	}
	
	/*================================
	Filter Box Style
	====================================*/
	.job-box-filter label {
	    width: 100%;
	}
	
	/* 검색창*/
	.job-box-filter select.input-sm {
	    display: inline-block;
	    max-width: 120px;
	    margin: 0 5px;
	    border: 1px solid #e8eef1;
	    border-radius: 2px;
	    height: 34px;
	    font-size: 15px;
	}
	
	.job-box-filter label input.form-control {
	    max-width: 200px;
	    display: inline-block;
	    border: 1px solid #e8eef1;
	    border-radius: 2px;
	    height: 34px;
	    margin-left:5px;
	    font-size: 15px;
	}
	
	.text-right{
	text-align:right;
	}
	.job-box-filter {
	    padding: 12px 15px;
	    background: #ffffff;
	    border-bottom: 1px solid #e8eef1;
	    margin-bottom: 20px;
	}
	.job-box {
	    background: #ffffff;
	    display: inline-block;
	    width: 100%;
	    padding: 0 0px 40px 0px;
	    border: 1px solid #e8eef1;
	}
	.job-box-filter a.filtsec {
	    margin-top: 8px;
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
		border-color:#16262c;
	}
	.job-box-filter a.filtsec i {
	    color: #03A9F4;
	    margin-right: 5px;
	}
	.job-box-filter a.filtsec:hover, .job-box-filter a.filtsec:focus {
	    color: #ffffff;
	    background: #07b107;
	    border-color: #07b107;
	}
	.job-box-filter a.filtsec:hover i, .job-box-filter a.filtsec:focus i{
	color:#ffffff;
	}
	.job-box-filter h4 i {
	    margin-right: 10px;
	}
	
	/*=====================================
	Inbox Message Style
	=======================================*/
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
	.inbox-message ul li:hover, .inbox-message ul li:focus {
	    background: #eff6f9;
	}
	
	.inbox-message .message-avatar {
	    position: absolute;
	    left: 30px;
	    top: 50%;
	    transform: translateY(-50%);
	}
	.message-avatar img {
	    display: inline-block;
	    width: 45px;
	    height: 45px;
	    border-radius: 50%;
	}
	.inbox-message .message-body {
	    margin-left: 85px;
	    font-size: 15px;
	    color:#62748F;
	}
	.message-body-heading h5 {
	    font-weight: 500;
		display:inline-block;
	    color:#62748F;
	    margin: 0 0 7px 0;
	    padding: 0;
	}
	
	/* 숫자 표시 */
	.message-body h5 span {
	    border-radius: 50px;
	    line-height: 10px;
	    font-size: 13px;
	    color: #fff;
	    font-style: normal;
	    padding: 4px 6px;
	    margin-left: 5px;
	    margin-top: -5px;
	}
	.message-body h5 span.unread{
		background:#07b107;	
	}
	.message-body h5 span.important{
		background:#dd2027;	
	}
	.message-body h5 span.pending{
		background:#2196f3;	
	}
	.message-body-heading span {
	    float: right;
	    color:#62748F;
	    font-size: 14px;
	}
	.messages-inbox .message-body p {
	    margin: 0;
	    padding: 0;
	    line-height: 27px;
	    font-size: 15px;
	}
	
	a:hover{
	    text-decoration:none;
	}
	
	.payCharge, .payRefund {
		background-color: #34A853;
		color: white;
		text-decoration: none;
		border: none;
		font-size: 15px;
		cursor: pointer;
		margin: 3px;
	
	}
	
	.charge, .refund {
		margin-left: 20px;
	}

	.chargeMoney {
        background: #fff;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        text-align: center;
    }

	.charge .radio-group {
	    display: grid;
	    grid-template-columns: repeat(2, 1fr); /* 2개의 동일한 너비 열 생성 */
	    gap: 10px; /* 간격 설정 */
	    align-items: flex-start;
	    margin-bottom: 10px;
	}
	
	.charge .radio-group label {
	    display: flex;
	    align-items: center;
	    margin-bottom: 5px;
	}
	
	.charge input[type="radio"] {
	    margin-right: 5px;
	    accent-color: #34A853; /* 라디오 버튼 색상 변경 */
	}
	
	.charge input[type="text"] {
	    margin-top: 10px;
	    padding: 10px;
	    width: 100%;
	    border: 1px solid #e8eef1;
	    border-radius: 5px;
	}
	
	.charge .button-group {
	    display: flex;
	    gap: 10px;
	    margin-top: 20px;
	}
	
	.charge .payCharge, .charge .payRefund {
	    background-color: #34A853;
	    color: white;
	    text-decoration: none;
	    border: none;
	    font-size: 15px;
	    cursor: pointer;
	    padding: 10px 20px;
	    border-radius: 5px;
	}



	

	
</style>

<script>

	$(document).ready(function(){
	    // 충전하기 버튼 클릭 시
	    $(".payCharge").click(function(){
	        $.ajax({
	            url: "payCharge", // 충전하기 요청을 보낼 URL
	            method: "GET",
	            success: function(response) {
	                $(".charge").html(response); // 서버 응답 데이터를 .charge div에 표시
	            },
	            error: function() {
	                alert("충전하기 요청 실패");
	            }
	        });
	    });
	
	    // 출금하기 버튼 클릭 시
	    $(".payRefund").click(function(){
	        $.ajax({
	            url: "yourRefundUrl", // 출금하기 요청을 보낼 URL
	            method: "GET",
	            success: function(response) {
	                $(".refund").html(response); // 서버 응답 데이터를 .refund div에 표시
	            },
	            error: function() {
	                alert("출금하기 요청 실패");
	            }
	        });
	    });
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
			
			<%-- 상단바 --%>
			
				<div class="row">

					<img alt="logo" src="${pageContext.request.contextPath}/resources/images/logo.png" style="width: 150px; height: auto;">

				</div>
				
			<%-- ========================================================= --%>
			
			</div>
			
			
			<div class="inbox-message">
				<div class="chargeMoney">
					<form class="charge" method="post">
						<input type="radio" value="5000" name="chargeAmt">  5000원 
						<input type="radio" value="10000" name="chargeAmt"> 10000원 <br>
						<input type="radio" value="15000" name="chargeAmt"> 15000원
						<input type="radio" value="20000" name="chargeAmt"> 20000원 <br>
						<input type="radio" value="25000" name="chargeAmt"> 25000원
						<input type="radio" value="30000" name="chargeAmt"> 30000원
						<input type="text">
						
						<%-- 버튼 --%>
						<div class="col-md-6 col-sm-6">
							<input type="button" class="payCharge" value="충전하기">
							<input type="button" class="payRefund" value="출금하기">
						</div>
					</form>
				</div>
				<div class="refundMonet">
					<form class="refund" method="post">
					
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