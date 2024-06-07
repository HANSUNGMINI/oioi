<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<%-- 외부 CSS 파일 연결하기(css/default.css) --%>
<link href="${pageContext.request.contextPath}/resources/css/default.css" rel="stylesheet" type="text/css">
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body>
	<article>
		<h3>죄송합니다.<br>요청하신 페이지를 찾을 수 없습니다.</h3>
		<h5>
			방문하시려는 페이지의 주소가 잘못 입력되었거나,
			<br>
			페이지의 주소가 변경 혹은 삭제되어 요청하신 페이지를 찾을 수 없습니다.
			<br>
			입력하신 주소가 정확한지 다시 한번 확인해 주시기 바랍니다.
			<br>
			관련 문의사항은 네이버 고객센터에 알려주시면 친절하게 안내해 드리겠습니다.
			<br>
			감사합니다.
		</h5>
	</article>
</body>
</html>










