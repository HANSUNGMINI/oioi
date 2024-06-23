// 한 페이당 보여줄 항목의 갯수 
const itemsPerPage = 5;

// ready
$(function(){
	search();
	
	
	// 검색 기능 (검색 가능한 페이지만)
	$("#submitBtn").on("click", search);
	$("#keyword").on("keydown", function(e){
		if(e.key == 'Enter') {
			search();
		}
	});
	
	
});




	