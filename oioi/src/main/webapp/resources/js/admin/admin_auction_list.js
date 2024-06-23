const listItems = [];

$('#type option').each(function() {
	if($(this).val() == 'ALL') { return true;}
    let item = {text: $(this).text() , value : $(this).val() }
    listItems.push(item);
});


const columns = [
    {header: '번호', name: 'APD_IDX', width: 100 , align: "center"},
    {header: '아이디', name: 'APD_OWNER'},
    {header: '상품명', name: 'APD_NAME'},
    {header: '제목', name: 'APD_DETAIL'},
    {header: '카테고리', name: 'APD_CATEGORY'},
    {header: '등록일', name: 'APD_REG_DATE'},
    {header: '상태', name: 'APD_STATUS',  
    	editor: { type: 'select', options: { listItems: listItems} } } ,
    {header: '상세보기'
      , renderer: {type: product_detail_btn}
    },
]

// 조회할 테이블
const table = "auction";

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
		    
		     // 수정버튼
			$('#btn-apply').on('click', function () {
				const modifiedRows = grid.getModifiedRows();
			    const jsonData = JSON.stringify(modifiedRows);
				patchStatus(jsonData)
			});
			
		} // success 끝
	});
};



function patchStatus(jsonData) {
	$.ajax({
		type : "PATCH",
		url : "APD_STATUS",
		contentType : 'application/json; charset=utf-8',
		data : jsonData,
		dataType : "JSON",
		success : function (response) {
			
			if(response == 0) {
				alert("변경실패 다시 시도");
			} else {
				alert(response + "개 항목 변경완료!");
			}
			
			search();
		}
	})
}
