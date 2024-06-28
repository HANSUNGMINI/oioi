/* 검색어 */

/* 인기검색어 및 최근검색어 위치 */
let recentClick = true;
let popularClick = true; 



/* 정리 */ /* ^__^ (검색해서 찾아올 수 있도록) */
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
	5. searchKeyword(A)	: A라는 검색어를 최근 검색 기록에 저장 및 로컬 스토리지 설정
	6. sendKeyword(A)	: 검색한 상품 이동 주소 설정 --> 글자 클릭 시 발생
	7. showHandler()	: 글자 미입력 시, 최근 검색어 보여주기
	8. RecentSearchs()	: 최근 검색어 설정
	9. SaveWord(A)		: A를 인기 검색어 반영하기 위해 테이블에 저장
	10.PopularSearches(): 인기 검색어 출력하는 함수 
	11. updateTable()	: 최근 검색어 추가
	
============================================================ */


/* 검색 JS 시작 */
$(function(){
	
	// ******************* 테스트 데이터 ********************
		var clickCount = 0;
		$('.header-inner').click(function() {
			clickCount++;
		    if (clickCount === 3) {
		    	var keywords = ["나이키", "아디다스", "신발", "자켓", "반팔", "맨투맨", "모자", "애즈온", "삽니다", "오이"];
		    	localStorage.setItem("keywords", JSON.stringify(keywords));
		    	updateTable();
		    	clickCount = 0;
		   	}
		});
	// ******************* 테스트 데이터 ********************
		
		// 로컬 스토리지 값이 변경될 때 실행할 함수
		updateTable();
		// 로컬 스토리지 값이 변경될 때 updateTable 함수 실행
		window.addEventListener('storage', function(event) {
			if (event.key === 'keywords') {
				updateTable();
			}
		});
		
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
		if(event.keyCode==13) {
			alert("왜오애ㅗ래");
			searchAjax();
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
			    		+ 			' &nbsp <span style="color : #34A853; font-weight: bold;"> '
			    		+     			 $("#searchKeyword").val()
			    		+ 			'</span>'
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


	/* 최근 검색어 보관하기 */
	function searchKeyword(pkeyword) {

		$(".recommendKeyword").removeClass("hidden");
		$(".recommendKeyword").show();
		
		let keyword = "";
		
		if(pkeyword == null){
			keyword = $("#searchKeyword").val();
		}else{
			keyword = pkeyword;
		}
		
		keyword = keyword.trim();
		
		if(keyword != "" && keyword != null){
		
			//******************** 최근 검색어 보관함 ************************
			// 로컬스토리지에 저장할 키의 이름
			const localStorageKey = 'keywords';
			
			// 기존의 저장된 키워드 배열 가져오기
			let keywords = JSON.parse(localStorage.getItem(localStorageKey)) || [];
			
			// 포함되어 있지 않을 경우 새로운 키워드 추가하기 
			if (!keywords.includes(keyword)) {
			  keywords.push(keyword);
			}
			
			// 최대 갯수를 초과하는 경우 가장 오래된 데이터부터 제거
			if (keywords.length > 10) {
			  keywords = keywords.slice(keywords.length - 10);
			}
			
			// 로컬스토리지에 업데이트된 키워드 배열 저장
			localStorage.setItem(localStorageKey, JSON.stringify(keywords));
			//******************** 최근 검색어 보관함 ************************
		
			/* 글자 클릭 시 이동 */
			var searchKeywordUrl = "trade?keyword=" + encodeURIComponent(keyword); /* ^__^  주소 */
			window.location.href = searchKeywordUrl;
		}
		
		SaveWord(keyword);
	}

	/* 검색어로 이동하는 주소 설정 */ 
	function sendKeyword(element) {
		var keyword = $(element).text(); // 클릭된 요소의 텍스트 값 가져오기
		var searchKeywordUrl = "trade?keyword=" + encodeURIComponent(keyword); /* ^__^  주소 */
		window.location.href = searchKeywordUrl;
		searchKeyword(keyword);
		SaveWord(keyword);
	}

	/* 검색어 입력 안 했을 경우, 최근 검색어 보여주기 */
	function showHandler(){
		if($("#searchKeyword").val() == null || $("#searchKeyword").val() == ''){
			$(".recentSearch").show();
		}else{
			searchAjax();
		}
	}
	
	/* 최근 검색어 설정 */
	function RecentSearchs(){
		$(".recentSearch").show();
		$(".popularSearch").hide();
		$(".recentWordColor").css("color","#34A853");
		$(".popularWordColor").css("color","black");
		recentClick = true;
		popularClick = false;
	}
	
	/* 검색한 키워드 저장 */
	function SaveWord(keyword){
		$.ajax({
			type:"GET",
			url:"SaveSearchKeyword",
			data: {keyword : keyword},
			success:function(res){
			}
		});
	}

	/* 인기 검색어 */
	function PopularSearches(){
		$(".popularSearch").show();
		
		popularClick = true;
		recentClick = false;
		
		$.ajax({
			type:"GET",
			url:"popularSearchKeywordList",
			success:function(data){
//				alert(JSON.stringify(data));
				let popularList = data;	
				 							
				let tableHTML = '<table id="PopularTableBoarder">';
				tableHTML +=
					'<tr class="PopularCenter">'
					+ '  <td class="RecentborderBottom">'
				    + '    <a onclick="RecentSearchs()" class="recentWordColor">최근검색어</a>'
				    + '  </td>'
				    + '  <td class="SelPopularborderBottom">'
				    + '    <a onclick="PopularSearches()" class="popularWordColor">인기검색어</a>'
				    + '  </td>'
				    + '</tr>';
				    
				for(let i=0; i<10; i++){
					let rank1 = i + 1;
					let rank2 = i + 11;
					tableHTML +=
						'<tr>'
						+'	<td class="popularRank">'
						+'		<a class="popularWordColorTd marginLeftRank">'
						+   		rank1
						+'		</a>'
						+'		<a onclick="sendKeyword(this)" id="popularKeywords">'+ popularList[i].SR_KEYWORD+'</a>'
						+'	</td>'
						+'	<td class="popularRank">'
						+'		<a class="popularWordColorTd marginLeftRank">'
						+   		rank2
						+'		</a>'
						+'		<a onclick="sendKeyword(this)" id="popularKeywords">'+ popularList[i+10].SR_KEYWORD+'</a>'
						+'	</td>'
						+'</td>'
				};
				    
				tableHTML += 
					'<tr>'
					+	'<td colspan="2">'
					+	'	<a id="closeSearchBox">'
					+	'	</a>'
					+	'</td>'
					+'</tr>' 
					+'</table>'
				
				$(".popularSearch").html(tableHTML);	    
				$(".recentSearch").hide();
				$(".popularWordColor").css("color","#34A853");
				$(".recentWordColor").css("color","black");
				
				/* 최근 검색어 칸 눌렀을 경우 */
				$(".RecentborderBottom").click(function(e) {
					$(".popularSearch").css("display","none");
					$(".recentWordColor").css("color","#34A853");
					$(".popularWordColor").css("color","black");
	            });
				
				/* 검색창 클릭시 숨기기*/
				$("#searchKeyword").click(function(e) {
	            });
				
				/* DIV 숨기기 */
				$(document).on("click", function(e) {
			    if ($(e.target).closest(".popularRank").length > 0 || $(e.target).is("#searchKeyword")) {
			        $(".recentSearch").hide();
			    }
				});
			}
		
		});
		
	}

	/* 최근 검색 기록 삭제 */
	function localStorageClean(){
		
		window.localStorage.removeItem('keywords');
		// 테이블 생성
		let tableHTML = '<table>';
		tableHTML += 
			'<tr>'
			+'	<td class="SelRecentborderBottom">'
			+'		<a onclick="RecentSearchs()" class="recentWordColor">최근검색어</a>'
			+'	</td>'
			+'	<td class="PopularborderBottom">'
			+'		<a onclick="PopularSearches()" class="popularWordColor" style="color:black;">인기검색어</a>'
			+'	</td>'
			+'</tr>';
			
		tableHTML +=
			'<tr>'
			+'<td colspan="2">'
			+'최근 검색어가 없습니다. 😢'
			+'</td>'
			+'</tr>'
			
		tableHTML += 
			'<tr>'
			+	'<td colspan="2">'
			+	'	<a onclick="localStorageClean()" id="localStorageClean">최근검색어 삭제</a>'
			+	'</td>'
			+'</tr>' 
			
			
		tableHTML += '</table>';
		// HTML 영역에 테이블 추가
		$(".recentSearch").html(tableHTML);
	}

	function updateTable() {
		const localStorageKey = 'keywords';
		const keywords = JSON.parse(localStorage.getItem(localStorageKey)) || [];
		// 테이블 생성
		let tableHTML = '<table>';
		tableHTML +=
			'<tr>'
			+ '  <td class="SelRecentborderBottom">'
		    + '    <a onclick="RecentSearchs()" class="recentWordColor">최근검색어</a>'
		    + '  </td>'
		    + '  <td class="PopularborderBottom">'
		    + '    <a onclick="PopularSearches()" class="popularWordColor">인기검색어</a>'
		    + '  </td>'
		    + '</tr>';
		// 키워드 배열을 순회하며 테이블 행 추가
		if(keywords.length == 0){
			tableHTML +=
				"<tr>"
				+"	<td colspan='2'>"
				+"		최근 검색어가 없습니다. 😢"
				+"	</td>"
				+"</tr>"
		}else{
			for (let index = keywords.length - 1; index >= 0; index--) {
				const keyword = keywords[index];
			    tableHTML +=
			    	"<tr class=" + keyword + ">"
			    	+ "  <td class='keywordWidth'>"
			    	+ "    <a onclick='sendKeyword(this)' id='recentKeyowrds'>"+keyword+"</a>"
			    	+ "  </td>"
			    	+ "  <td class='localStarageDeleteOneTd'>"
			    	+ "    <a class='localStarageDeleteOne' onclick='localStarageDeleteOne(\"" + keyword + "\")'>x</a>"
			    	+ "  </td>"
			    	+ "</tr>";
			}
		}
	
		  tableHTML +=
			  '<tr>'
			  + '<td colspan="2">'
			  + '  <a onclick="localStorageClean()" id="localStorageClean">최근검색어 삭제</a>'
			  + '</td>'
			  + '</tr>' 
	
		  tableHTML += '</table>';
		  // HTML 영역에 테이블 추가
		  $(".recentSearch").html(tableHTML);
	}
	
	function localStarageDeleteOne(keyword) {
		// 로컬 스토리지에서 keywords 배열 가져오기
		const storedKeywords = JSON.parse(localStorage.getItem("keywords")) || [];
		// 일치하는 키워드 찾아서 삭제
		const updatedKeywords = storedKeywords.filter((storedKeyword) => storedKeyword !== keyword);
		// 수정된 keywords 배열 다시 로컬 스토리지에 저장
		localStorage.setItem("keywords", JSON.stringify(updatedKeywords));
		updateTable();
	}

	/* 검색창 클릭 시 발생하는 함수 */
	function searchDivOpen() {
		if($("#searchKeyword").val() == null || $("#searchKeyword").val() == ''){
			$(".recentSearch").show();
			popularClick = false; 
		} else {
			searchAjax();
		}
	}

