// 한 페이당 보여줄 항목의 갯수 
const itemsPerPage = 5;
		
		
// ready
$(function(){

	search();
	
	// 검색버튼 클릭시
	$("#submitBtn").on("click", search);
	
});
	
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
			    rowHeaders: ['rowNum'],
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
}
	