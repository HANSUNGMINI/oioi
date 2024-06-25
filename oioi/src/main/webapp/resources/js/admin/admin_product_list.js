// 컬럼 헤더 
const columns = [
    {header: '게시글 번호', name: 'PD_IDX', width: 100 , align: "center"},
    {header: '아이디', name: 'US_ID'},
    {header: '게시글 제목', name: 'PD_SUBJECT'},
    {header: '카테고리', name: 'PD_CATEGORY'},
    {header: '상태', name: 'PD_STATUS'},
    {header: '등록일', name: 'PD_REG_DATE'},
    {header: '보기'
      , name: 'hide'
      , renderer: {type: product_detail_btn}
      , width: 50 
      , align: "center"
    },
]

// 조회할 테이블
const table = "product";

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