const columns = [
    {header: '아이디', name: 'AD_ID'},
    {header: '관리자 이름', name: 'AD_NAME'},
    {header: '관리자 등록일', name: 'AD_DATE'},
    {header: '관리자 역할', name: 'RL_NAME'},
    {header: '관리자 권한', name: 'AD_ACTIVE', renderer: {
        type: AD_toggle
    }},
]

// 조회할 테이블
const table = "admin";	


function search() {

	type = $("#type").val();
	keyword = $("#keyword").val();
			
	$.ajax({
		type : "GET",
		url : "List",
		data : {
			"table" : table,
			"type" : type,
			"keyword" : keyword,
		},
		dataType : "JSON",
		success : function (response) {
			$("#grid").empty();
			
			const gridData = []
			
				
			for (let item of response){
				gridData.push(item);
			}
			
		    const grid = new tui.Grid({
			    el: document.getElementById('grid'),
			    data: gridData,
			    scrollX: false,
			    scrollY: false,
			    columns: columns,
			    pageOptions: {
		           useClient: true,
		           perPage: itemsPerPage
		        },
		        minBodyHeight : '0',
		        bodyHeight : 'auto'
		    });
			
s		} // success 끝
	});
};ㄴ



// 권한 변경
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
					elm.prop('checked', !isChecked);
				}
			}
		}) //끝
	} else {
		//취소 선택시 상태 제자리
		elm.prop('checked', !isChecked);
	}
}