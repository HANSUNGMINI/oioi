<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<!-- SweetAlert CSS -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
<!-- SweetAlert JS -->
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
<script type="text/javascript">
	let checkIdResult = false;
	
	$(function() {
		document.fr.user_id.focus();
		
	    document.fr.user_id.onkeyup = function() { // 아이디 입력창 이벤트
	       
	        if(checkID($("#user_id").val())){ //아이디 유효성검사 통과 시
	            $("#checkIdResult").text("중복확인 버튼을 눌러주세요.");
	            $("#checkIdResult").css("color", "#34A853");
	            $(".id_check").prop("disabled", false);
	           
	        } else { // 아이디 유효성 검사 실패 시 중복확인 버튼 비활성화
	
	        	$(".id_check").prop("disabled", true);
	        }
	    }
	   
	    $("#btnCheckId").click(function() {
	    	
	    if(document.fr.user_id.value == ""){
	    	Swal.fire({
			    icon: 'warning',
			    title: '실패!',
			    text: '아이디를 입력해주세요!'
			});
 			return false;
 	    }
	   
	    });
	   
	   
	    $("#btnUseID").click(function() { // 아이디 사용 버튼 클릭 이벤트
	        window.opener.document.fr.user_id.value = "${param.userId}";
	        window.close();
	    });
	   
	}); // document 객체의 ready 이벤트 끝
	
	
	function checkID(user_id) { // 아이디 유효성 검사
	    // 첫 글자에 특수기호(_),(-) 사용 여부 확인
	    if (/^[_-]/.test(user_id)) {
	        showError("특수기호(_),(-)는 첫 글자에 사용하실 수 없습니다.");
	        return false;
	    }
	    // 아이디 패턴 검사
	    if (!/^[a-z0-9][a-z0-9_-]{7,11}$/.test(user_id)) {
	        showError("8~12자의 영문 소문자, 숫자와 특수기호(_),(-)만 사용 가능합니다.");
	        return false;
	    }
	    // 영문자와 숫자 혼용 여부 확인
	    if (!(/[0-9]/.test(user_id) && /[a-z]/.test(user_id))) {
	        showError("숫자와 영문자를 혼용하여야 합니다.");
	        return false;
	    }
	    // 같은 문자 4번 이상 사용 여부 확인
	    if (/(\w)\1\1\1/.test(user_id)) {
	        showError("같은 문자를 4번 이상 사용하실 수 없습니다.");
	        return false;
	    }
	    // 모든 조건을 만족하면 유효성 검사 통과
	    return true;
	} // 아이디 유효성 검사 끝
	function showError(message) {
	    $("#checkIdResult").text(message);
	    $("#checkIdResult").css("color", "red");
	}
</script>

<meta charset="UTF-8">
<title>아이디 중복확인</title>
<!-- favicon 스크립트 -->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
</head>
<body>
<c:if test="${param.isValid eq true}">
	<script type="text/javascript">
		Swal.fire({
		    icon: 'success',
		    title: '성공!',
		    text: '사용가능한 아이디 입니다!'
		});	
	</script>
</c:if>
<c:if test="${param.isValid eq false}">
	<script type="text/javascript">
		Swal.fire({
		    icon: 'error',
		    title: '실패!',
		    text: '이미 사용중인 아이디 입니다!'
		});
	</script>
</c:if>
	<form action="check_id"  name="fr" method="post">
		<input type="text" placeholder="아이디" class="id_box" name="user_id" id="user_id" value="${param.userId}" maxlength="12" <c:if test="${param.isValid eq true}">readonly</c:if> />
		<div id="checkIdResult"></div>
		<div>
			<c:choose>
				<c:when test="${param.isValid eq true}">
					<input type="button" class="id_check" value="사용하기" id="btnUseID"><br>
				</c:when>
				<c:otherwise>
					<input type="submit" class="id_check" value="중복확인" id="btnCheckId">
				</c:otherwise>
			</c:choose>
		</div>
	</form>
</body>
<link href="${pageContext.request.contextPath}/resources/css/check_id.css" rel="stylesheet">
</html>