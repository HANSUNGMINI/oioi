// 토스트UI 컬럼
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

// 조회 함수
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
			    rowHeaders: ['rowNum'],
			    pageOptions: {
		           useClient: true,
		           perPage: itemsPerPage
		        },
		        minBodyHeight : '0',
		        bodyHeight : 'auto'
		    });
			
		} // success 끝
	});
};



// 권한 변경
function change(elm, isChecked, id, type) {
	 Swal.fire({
            text: "관리자 권한을 변경하시겠습니까?",
            icon: 'info',
            confirmButtonText: '확인',
            cancelButtonText: '취소',
    		showCancelButton: true,
       	}).then((result) => {
        	if (result.isConfirmed) {
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
							checkAlert('성공','success');
						} else {
							checkAlert('실패','error');
							elm.prop('checked', !isChecked);
						}
					}
				}) //끝
		    } else {
		    	elm.prop('checked', !isChecked);
		    }
   	});
}

// 관리자 추가
function addAdmin() {
	window.open("addAdmin","관리자 추가","width=600, height=300, top=150, left=650");
}
