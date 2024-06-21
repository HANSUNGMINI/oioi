

/* 정리 */ /* ^__^ (검색해서 찾아올 수 있도록) */
/* ======================================================== *
	
	[ id 및 class명 정리 ]

	1. storedKeywords 		= 최근 검색 기록
	
-------------------------------------------------------

	[ 함수 정리 ]

	1. showRecentKeywordProduct()	: 최근 검색한 키워드 연관 상품 출력
	2. searchProduct() 	: 검색한 상품 검색
	3. searchAjax() 	: AJAX로 추천 검색어 가져오기
	
============================================================ */
 
 $(function(){

	/* 최근 검색한 키워드 연관 상품 함수 호출 */
	showRecentKeywordProduct();
	
}) // ready 이벤트 끝

	/* 검색 기록 기반 상품 불러오기 */
	function showRecentKeywordProduct() {
	
		/* 최근 검색 기록 가져오기 */
		const storedKeywords = JSON.parse(localStorage.getItem("keywords")) || [];
	
		$.ajax({
			type : "GET",
			url : "recentKeywordProductList",
			data : {
				storedKeywords: JSON.stringify(storedKeywords)
			},
			dataType : "json",
			success : function(){
			
			}
		});
	
	} 