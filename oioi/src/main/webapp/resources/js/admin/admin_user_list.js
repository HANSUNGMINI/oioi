const columns = [
    {header: '아이디', name: 'US_ID'},
    {header: '닉네임', name: 'US_NICK'},
    {header: '회원명', name: 'US_NAME'},
    {header: '가입일', name: 'US_REG_DATE'},
    {header: '정보'
      , renderer: {type: user_detail_btn}
      , width: 50 
      , align: "center"
    },
    {header: '상점'
      , renderer: {type: user_shop_btn}
      , width: 50 
      , align: "center"
    },
]



// 조회할 테이블
const table = "user";

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
			
s		} // success 끝
	});
};