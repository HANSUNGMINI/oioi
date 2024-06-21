// 컬럼 헤더 
const columns = [
    {header: '코드', name: 'code', editor : 'text'},
    {header: '내용', name: 'value', editor : 'text'},
    {header: '사용여부', name: 'hide'
    		, renderer: {
			  	type: common_toggle
    		  },
    },
]

// 조회할 테이블
const table = "common";


function putCode(jsonData) {
	alert(jsonData)
	$.ajax({
		type : "PUT",
		url : "common",
		contentType : 'application/json; charset=utf-8',
		data : jsonData,
		dataType : "JSON",
		success : function (response) {
			
			if(response == 0) {
				alert("변경실패 다시 시도");
			} else {
				alert(response + "개 항목 변경완료!");
			}
			
			location.reload();
		}
	})
}

function deleteCode(jsonData) {
	console.log(jsonData);
	alert(jsonData)
	if(confirm('정말 삭제하시겠습니까?')) {
		$.ajax({
			type : "DELETE",
			url : "common",
			contentType : 'application/json; charset=utf-8',
			data : jsonData, 
			dataType : "JSON",
			success : function (response) {
				if(response < 0) {
				alert("삭제실패 다시 시도");
				} else {
					alert(response + "개 항목 변경완료!");
				}
			
				location.reload();
			}
		})
	}
}


// 코드 상태 변경 함수
function change(elm, isChecked, code, type) {
	let answer = confirm("코드 상태를 변경하시겠습니까?");
	if(answer) {
		$.ajax({
			type : "PATCH",
			url : "status",
			contentType : 'application/json; charset=utf-8',
			data : JSON.stringify({
				"code" : code,
				"value" : isChecked,
				"type" : type,
			}),
			dataType : "JSON",
			success : function(response) {
				if(response > 0) {
					alert("변경 완료!");
				} else {
					alert("변경실패 다시 시도");
					elm.prop('checked', !isChecked);
				}
			}
		}) //끝
	} else {
		//취소 선택시 상태 제자리
		elm.prop('checked', !isChecked);
	}
}

		
