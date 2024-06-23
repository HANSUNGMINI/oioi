const columns = [
    {header: '아이디', name: 'APD_OWNER'},
    {header: '상품명', name: 'APD_NAME'},
    {header: '제목', name: 'APD_DETAIL'},
    {header: '카테고리', name: 'APD_CATEGORY'},
    {header: '등록일', name: 'APD_REG_DATE'},
    {header: '상세보기'
      , name: 'hide'
      , renderer: {type: detail_btn}
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
			
s		} // success 끝
	});
};