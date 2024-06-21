<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<script type="text/javascript">

function change(elm, isChecked, id, type) {
	let answer = confirm("관리자 권한을 변경하시겠습니까?");
	if(answer) {
		$.ajax({
			type : "PATCH",
			url : "status",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify({
				"id" : id,
				"value" : isChecked,
				"type" : type,
			}),
			dataType : "JSON",
			success : function(response) {
				if(response > 0) {
					alert("변경 완료!");
				} else {
					alert("변경실패 다시 시도");
				}
			}
		}) //끝
	} else {
		elm.checked = !isChecked;
	}
}
	






















</script>
</body>
</html>