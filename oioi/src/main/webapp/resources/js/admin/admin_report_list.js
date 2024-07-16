const columns = [
    {header: '신고번호', name: 'RP_IDX', width : 100, align : "center"},
    {header: '신고자', name: 'TO_US_ID', width : 200, align : "center"},
    {header: '신고대상', name: 'FROM_US_ID', width : 200, align : "center"},
    {header: '신고사유', name: 'RP_CATEGORY', align : "center"},
    {header: '신고일자', name: 'RP_TIME' , width : 150, align : "center"},
    {header: '보기'
      , renderer: {type: report_detail_btn}
      , width: 50
      , align: "center" 
    },
]


// 조회할 테이블
const table = "report";

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
			"isPast" : $("#selectPastReport").is(":checked"),
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

