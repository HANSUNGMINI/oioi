// 컬럼 헤더 
const columns = [
    {header: '게시글 번호', name: 'CM_IDX', width: 100 , align: "center"},
    {header: '아이디', name: 'CM_ID'},
    {header: '닉네임', name: 'CM_NICK'},
    {header: '게시글 제목', name: 'CM_TITLE'},
    {header: '카테고리', name: 'CM_CATEGORY'},
    {header: '보기'
      , name: 'hide'
      , renderer: {type: community_detail_btn}
      , width: 50 
      , align: "center"
    },
]

// 조회할 테이블
const table = "community";

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
			
		} // success 끝
	});
};