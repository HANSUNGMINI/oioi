/* 검색어 */

/* 인기검색어 및 최근검색어 위치 */
let recentClick = true;
let popularClick = true; 



/* 정리 */
/* ======================================================== *
	
	[ id 및 class명 정리 ]

	1. #searchKeyword 		= 검색창
	2. .recentSearch 		= 최근 검색어 DIV
	3. .popularSearch 		= 인기 검색어 DIV
	4. .recommendKeyword 	= 추천 검색어 DIV
	
-------------------------------------------------------

	[ 함수 정리 ]

	1. hideHandler() 	: 모든 DIV를 숨긴다
	2. searchProduct() 	: 검색한 상품 검색
	3. searchAjax() 	: AJAX로 추천 검색어 가져오기
	4. searchDivOpen()  : 검색창 클릭 시 발생하는 함수

============================================================ */


/* 검색 JS 시작 */
$(function(){
	
	hideHandler();
	$(window).on("scroll", hideHandler);

	/* 모든 DIV 숨기기 */	
	function hideHandler() {
		$(".recentSearch").hide();
		$(".popularSearch").hide();
		$(".recommendKeyword").hide();
	}

	
	/* DIV 보이게 하기 */
	$("#searchKeyword").keyup(function(){
	
		if($("#searchKeyword").val().length < 1){ /* 아무것도 입력이 되지 않았을 경우*/
			if(recentClick == true){ /* 최신 검색어 클릭 시 보여 주기 */
				$(".recentSearch").show();
								
			}else if(popularClick == true){  /* 인기 검색어 클릭 시 보여 주기 */
				$(".popularSearch").show();
			}
			
			$(".recommendKeyword").hide();
			
		} else{  /* 검색어 있을 경우 */
			searchAjax();	
		}
	});


	/* 엔터키 적용 시키기 */
	$("#searchKeyword").keyup(function(event) {
		if(event.keycode == 13) {
			searchProduct();
		}
	})

}); /* ready 이벤트 끝 */

/* 연관 검색어 가져오기 */
function searchAjax() {
	$.ajax({
		type : "GET",
		url : "searchRecommend",
		data: {searchKeyWord : $("#searchKeyword").val()},
		success:function(res){
				/* alert("여기까지는 오니"); */
				
				$(".popularSearch").hide();
				$(".recentSearch").hide();
				$(".recommendKeyword").show();
				
				let relationBox = 
					'<table id="RelationTableBoarder">'
		    		+'<tr id= "Relationdata">'
		    		+	'<td colspan="2">'
		    		+       '🥒 거래 &gt;'
		    		+ 			'<a href="FindSearchProduct?keyword=' + $("#searchKeyword").val() + '"> &nbsp <span style="color : #34A853; font-weight: bold;"> '
		    		+     			 $("#searchKeyword").val()
		    		+ 			'</span></a>'
		    		+ 		"  (으)로 검색" 
		    		+	'</td>'
		    		+'</tr>'
		    		+'<tr>'
					+	'<td colspan="2">'
					+	'	<a></a>'
					+	'</td>'
					+'</tr>' 
		    		+'</table>'
		    		
				$(".recommendKeyword").html(relationBox)
				let relationKeyWord = ""
				for(let data of res){
					relationKeyWord += "<tr><td colspan='2' class='relationText'><a onclick='sendKeyword(this)'>" + data.recommend_tag + "</a></td></tr>";
				}
		    		
				$("#Relationdata").after(relationKeyWord)
			},
			error:function(){
			}
	})

}

/* 검색창 클릭 시 발생하는 함수 */
function searchDivOpen() {
	if($("#searchKeyword").val() == null || $("#searchKeyword").val() == ''){
		$(".recentSearch").show();
	}else{
		searchAjax();
	}
}