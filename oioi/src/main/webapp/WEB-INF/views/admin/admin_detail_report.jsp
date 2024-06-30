<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
<script>
	function changeStatus(){
		$.ajax({
			type : "POST",
			url : "reportStatus",
			data : {
				"RP_STATUS" : $("#RP_STATUS").val(),
				"RP_IDX" : "${report.RP_IDX}",
				"FROM_US_ID" : "${report.FROM_US_ID}",
			},
			dataType : "JSON",
			success : function (response) {
				if(response > 0 ) {
					alert("성공적으로 변경되었습니다!")
				} else {
					alert("변경에 실패했습니다")
				}
			}
		})
	}
</script>
</head>
<body>
<h1> 신고 상세</h1>
<h3> 신고자 : ${report.TO_US_ID}</h3>
<h3> 신고대상  : ${report.FROM_US_ID}</h3>
<h3> 처리현황</h3>
<select id="RP_STATUS" onchange="changeStatus()">
	<c:forEach var="item" items="${rpStatusSelectBox}">
		<option value="${item.code}" <c:if test="${item.value eq report.RP_STATUS}"> selected</c:if>> ${item.value }</option>
	</c:forEach>
</select>
<h3> 신고사유  : ${report.RP_CAREGORY}</h3>
<h3> 상세  : ${report.RP_CONTENT}</h3>
<h3> 신고 날짜  : ${report.RP_TIME}</h3>
<h3> 첨부 이미지1  : <img src="${pageContext.request.contextPath}/resources/upload/${report_RP_IMG1}"></h3>
<h3> 첨부 이미지2  : <img src="${pageContext.request.contextPath}/resources/upload/${report_RP_IMG2}"></h3>
</body>

</html>