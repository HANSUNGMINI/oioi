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


// 삭제버튼
$('#btn-delete').on('click', function () {
	
});




function editCode(jsonData) {
	$.ajax({
		type : "PATCH",
		url : "common",
		contentType : 'application/json; charset=utf-8',
		data : jsonData, 
		dataType : "JSON",
		success : function (response) {
			
			if(response < 0) {
				alert("변경실패 다시 시도");
			} else {
				alert(response + "개 항목 변경완료!");
			}
			
			location.reload();
		}
	})
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






function editCode2(value) {
			$(".editBtn").remove();
			// 수정 할 내용의 리드온리해제, 지금 작성중인 text가 뭔지 구분 가능하게 만드는 css코드 
			let element = $("input[value='" + value + "']");
			element.after(
			 		'<button class="button small blue" onclick="updateCode(this)" type="button" style="margin-right: 5px;">'
      			+ 	'	<span class="icon" type="button"><i class="mdi mdi-content-save"></i></span>'
         		+ 	'</button>'
         		+	'<button class="button small blue" onclick="search()" type="button">'
      			+ 	'	<span class="icon"><i class="mdi mdi-content-save-off"></i></span>'
         		+ 	'</button>'	
			);
			element.prop('readonly', false);
			element.focus();
			element.css('background-color', 'white');
			element.css('outline', '2px solid black');
			
// 			search();
		}
		
		function updateCode(button) {
			// 0.
			let target = $("#type").val();
			// 1. this로 받아온 버튼을 변수에 저장
			let btn = $(button);
			// 2. 버튼의 이전요소 text를 찾고 그 값을 저장
			//    jQuery prev()함수 이전 요소찾기(수정할 value값)
			let value = btn.prev('input[type="text"]').val();
			// 3. 버튼이 속한 tr요소를 찾고 첫 번째td의 값을 가져옴(타겟이되는 코드값)
			let code = btn.closest('tr').find('td:first').text();
			
			$.ajax({
				type : "PATCH",
				url : "common",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify({
					"target" : target,
					"code" : code, 
					"value" : value
				}), 
				dataType : "JSON",
				success : function (response) {
					
					if(response > 0) {
						alert("변경 완료!");
					} else {
						alert("변경실패 다시 시도");
					}
					
					search();
				}
			})
		}
		
		function addRowData(){
			// 카테고리 코드
			let target = $("#type").val();
			//
			let code = $("#code").val();
			let value = $("#value").val();
			
			let obj = {
					"target" : target,
					"code" : code, 
					"value" : value
			};
			
			$.ajax({
				type : "PUT",
				url : "common",
				contentType : 'application/json; charset=utf-8',
				data : JSON.stringify(obj),
				dataType : "JSON",
				success : function (response) {
					if(response < 1) {
						alert('추가 실패');
					}
					addCancel();
					search();
				}
			})
			
		}
		
		function addCancel(){
			$(".td").val('');
		}
		
		
		function deleteCode(target) {
			if(confirm('정말 삭제하시겠습니까?')) {
				$.ajax({
					type : "DELETE",
					url : "common",
					contentType : 'application/json; charset=utf-8',
					data : JSON.stringify({
						target : target
					}),
					dataType : "JSON",
					success : function (response) {
						if(response < 1) {
							alert('삭제 실패');
						}
						addCancel();
						search();
					}
				})
			}
		}