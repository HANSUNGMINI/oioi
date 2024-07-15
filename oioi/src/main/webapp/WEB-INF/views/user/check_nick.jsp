<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c"  uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script type="text/javascript">
	let checkNickResult = false;
	
	$(function() {
		document.fr.user_nick.focus();
		
	    document.fr.user_nick.onkeyup = function() { // 닉네임 입력창 이벤트
	       
	        if(checkNick($("#user_nick").val())){ //닉네임 유효성검사 통과 시
	            $("#checkNickResult").text("중복확인 버튼을 눌러주세요.");
	            $("#checkNickResult").css("color", "#34A853");
	            $(".nick_check").prop("disabled", false);
	           
	        } else { // 닉네임 유효성 검사 실패 시 중복확인 버튼 비활성화
	
	        	$(".nick_check").prop("disabled", true);
	        }
	    }
	   
	    $("#btnCheckNick").click(function() {
	    	
	    if(document.fr.user_nick.value == ""){
 			alert("닉네임을 입력해주세요.");
 			return false;
 	    }
	   
	    });
	   
	    $("#btnUseNick").click(function() { // 닉네임 사용 버튼 클릭 이벤트
	        window.opener.document.fr.user_nick.value = "${param.userNick}";
	        window.close();
	    });
	   
	}); // document 객체의 ready 이벤트 끝
	
	function checkNick(user_nick) { // 닉네임 유효성 검사
		
	    // 금지된 단어 목록
	    const bannedWords = ["시발", "개새", "fuck"];
	    // 닉네임에 금지된 단어가 포함되어 있는지 확인
	    for (let i = 0; i < bannedWords.length; i++) {
	        if (user_nick.includes(bannedWords[i])) {
	            showError("닉네임에 금지된 단어가 포함되어 있습니다.");
	            return false;
	        }
	    }
	    
	 	// 알파벳 소문자, 숫자, 또는 한글을 최소 2개에서 16개까지 포함하는지 검사
	    const lengthRegex = /^[a-z0-9가-힣]{2,16}$/;
	    if (!lengthRegex.test(user_nick)) {
	        showError("닉네임은 알파벳 소문자, 숫자, 또는 한글로 이루어진 2자 이상 16자 이하이어야 합니다.");
	        return false;
	    }
	    // 적어도 하나의 알파벳 소문자, 숫자, 또는 한글이 포함되어 있는지 검사
	    const characterRegex = /[a-z0-9가-힣]/;
	    if (!characterRegex.test(user_nick)) {
	        showError("닉네임은 적어도 한 개의 알파벳 소문자, 숫자, 또는 한글을 포함해야 합니다.");
	        return false;
	    }
	    // 모든 조건을 만족하면 유효성 검사 통과
	    return true;
	} // 닉네임 유효성 검사 끝
	function showError(message) {
	    $("#checkNickResult").text(message);
	    $("#checkNickResult").css("color", "red");
	}
</script>
<link href="${pageContext.request.contextPath}/resources/css/check_nick.css" rel="stylesheet">
<meta charset="UTF-8">
<title>닉네임 중복확인</title>
<!-- favicon 스크립트 -->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
</head>
<body>
<c:if test="${param.isValidNick eq true}">
	<script type="text/javascript">
		alert("사용가능한 닉네임입니다.");	
	</script>
</c:if>
<c:if test="${param.isValidNick eq false}">
	<script type="text/javascript">
		alert("이미 사용중인 닉네임입니다.");	
	</script>
</c:if>
	<form action="check_nick"  name="fr" method="post">
		<input type="text" placeholder="닉네임" class="id_box" name="user_nick" id="user_nick" value="${param.userNick}" maxlength="12" <c:if test="${param.isValidNick eq true}">readonly</c:if> />
		<div id="checkNickResult"></div>
		<div>
			<c:choose>
				<c:when test="${param.isValidNick eq true}">
					<input type="button" class="nick_check" value="닉네임사용" id="btnUseNick"><br>
				</c:when>
				<c:otherwise>
					<input type="submit" class="nick_check" value="중복확인" id="btnCheckNick">
				</c:otherwise>
			</c:choose>
		</div>
	</form>
</body>
</html>