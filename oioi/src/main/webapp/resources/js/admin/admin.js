// 한 페이당 보여줄 항목의 갯수 
const itemsPerPage = 5;

const rowHeaders = ['rowNum','checkbox'];


// ready
$(function(){
	
	search();
	
	// 검색버튼 클릭시
	$("#submitBtn").on("click", search);
	
});

// 기본 검색함수
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
			    rowHeaders: rowHeaders,
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
				const target = $('#type').val();
				const modifiedRows = grid.getModifiedRows();
				const dataToSend = {target: target,modifiedRows: modifiedRows};
			    const jsonData = JSON.stringify(dataToSend);
			    
				putCode(jsonData)
			});
			
			// 삭제버튼
			$('#btn-delete').on('click', function () {
	            const checkedRows = grid.getCheckedRows();
	            checkedRows.forEach(row => {
	                grid.removeRow(row.rowKey);
	            });
	        });

			
			// 추가버튼(row만 추가 DB작업 X)
			$('#btn-add').on('click', function () {
			    const newRow = {}
				grid.appendRow(newRow);
			});
			
			
		} // success 끝
	});
};




	