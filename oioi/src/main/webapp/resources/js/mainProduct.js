

/* 정리 */ /* ^__^ (검색해서 찾아올 수 있도록) */
/* ======================================================== *
	
	[ id 및 class명 정리 ]

	1. storedKeywords 		= 최근 검색 기록
	2. storedProducts		= 최근 본 상품 목록
	
-------------------------------------------------------

	[ 함수 정리 ]

	1. showRecentKeywordProduct()	: 최근 검색한 키워드 연관 상품 출력
	2. showRecentLookProduct()		: 최근 본 상품 목록 출력
	
============================================================ */
 
 $(function(){
	
	/* 최근 검색한 키워드 연관 상품 함수 호출 */
	// TODO
	showRecentKeywordProduct();
	
	
	/* 최근 본 상품 함수 호출 */
	showRecentLookProduct();
	
}) // ready 이벤트 끝

	/* 최근 본 상품 */
	function showRecentLookProduct() {
		let storedProducts = JSON.parse(localStorage.getItem("products")) || [];
		storedProducts = storedProducts.join(',');
		
		let isNull = false;
		if (storedProducts.length === 0) {
			//alert("이건 떠?")
			isNull = true;
		}
	
		if (isNull) {
			let nullDiv = '<div style="margin:0 auto; text-align:center; height: 100px;"> 최근 본 상품 목록이 비어 있습니다. </div>';
			$("#noProduct").append(nullDiv);
			return;  // 최근 본 상품이 없을 경우 
		}
		
        $.ajax({
            type: "GET",
            url: "recentLookProductList",
            data: {
                "recentProduct": storedProducts
            },
            dataType: "json",
            success: function(response) {
				
				let productList = response;
				
				if (productList == '') {
					let nullDiv = '<div style="margin:0 auto; text-align:center; height: 100px;"> 최근 본 상품 목록이 비어 있습니다. </div>';
					$("#noProduct").append(nullDiv);
					return;  // 최근 본 상품이 없을 경우 
				}
				
				var owl = $("#recentLookProduct")
				
				$.each(productList, function(index, pr) {
					// alert( pr.PD_IMAGE);
				
					// 뽑아내기
					let productDetail = 
						 '	<div class="owl-item">'
						+'	<div class="single-product">'
						+'		<div class="product-img">'
						+'			<a href="productDetail?PD_IDX='+ pr.PD_IDX +'">'
						+'             <img class="default-img" src="' + '/oi/resources/upload/' + pr.IMG + '">'
						+'				<span class="'+ pr.PD_STATUS_COLOR +'">' +  pr.PD_STATUS_VALUE +'</span> <!-- out-of-stock = 빨간색 / new = 파란?보라?색 / price-dec = 초록색 -->'
						+'			</a>'
						+'			<div class="button-head">'
						+'				<div class="product-action">'
						+'					<a title="Wishlist" href="#"><i class=" ti-heart "></i><span>찜하기</span></a>'
						+'				</div>'
						+'				<div class="product-action-2">'
						+'					<a title="Add to cart" href="productDetail?PD_IDX='+ pr.PD_IDX +'">상품 상세페이지로 바로가기</a>'
						+'				</div>'
						+'			</div>'
						+'		</div>'
						+'		<div class="product-content">'
						+'			<h3><a href="product-details.html">'+ pr.PD_SUBJECT +'</a></h3>'
						+'			<div class="product-price">'
						+'				<span>'+ pr.PD_PRICE +' 원</span>'
						+'				<span class="pro_time" style="float:right; color:gray"><small>'+ pr.RD_DATE +'</small></span>'
						+'			</div>'
						+'		</div>'
						+'	</div>'
						+'	</div>'
						
						owl.trigger('add.owl.carousel', [$(productDetail)]);		
				});
				
				owl.trigger('refresh.owl.carousel');
				owl.trigger("initialize");
				
            }
        });
	
	} 
	

	/* 검색 기록 기반 상품 불러오기 */
	function showRecentKeywordProduct() {
	
		/* 최근 검색 기록 가져오기 */
		let storedKeywords = JSON.parse(localStorage.getItem("keywords")) || [];
		storedKeywords = storedKeywords.join('|');
		
		//alert(storedKeywords);
		
		let isNull = false;
		if (storedKeywords.length === 0) {
			isNull = true;
		}
	
		if (isNull) {
			let nullDiv = '<div style="margin:0 auto; text-align:center; height: 100px;"> 최근 검색 목록이 비어 있습니다. </div>';
			$("#noKeyword").append(nullDiv);
			return;  // 검색 기록이 없을 경우 여기서 함수를 종료
		}
		
		 // 반복문을 통해 각 키워드를 처리
	  	 // alert("아예 안 되는 거?");
        $.ajax({
            type: "GET",
            url: "recentKeywordProductList",
            data: {
                "keyword": storedKeywords
            },
            dataType: "json",
            success: function(response) {
            
				let productList = response;
				
				if (productList == '') {
					let nullDiv = '<div style="margin:0 auto; text-align:center; height: 100px;"> 최근 검색 목록이 비어 있습니다. </div>';
					$("#noKeyword").append(nullDiv);
					return;  // 최근 본 상품이 없을 경우 
				}
				
				var owl = $("#recentKeywordProduct")
				
				$.each(productList, function(index, pr) {
					//alert( pr.IMG);
				
					// 뽑아내기
					let productDetail = 
						// '<div class="owl-stage" style="transform: translate3d(0px, 0px, 0px); transition: all 0s ease 0s; width: 285px;">'
						//+'<div class="owl-item active" style="width: 285px; margin-right: 0px;">'
						 '	<div class="owl-item">'
						+'	<div class="single-product">'
						+'		<div class="product-img">'
						+'			<a href="productDetail?PD_IDX='+ pr.PD_IDX +'">'
						+ '             <img class="default-img" src="' + '/oi/resources/upload/' + pr.IMG + '">'
						+'				<span class="'+ pr.PD_STATUS_COLOR +'">' +  pr.PD_STATUS_VALUE +'</span> <!-- out-of-stock = 빨간색 / new = 파란?보라?색 / price-dec = 초록색 -->'
						+'			</a>'
						+'			<div class="button-head">'
						+'				<div class="product-action">'
						+'					<a title="Wishlist" href="#"><i class=" ti-heart "></i><span>찜하기</span></a>'
						+'				</div>'
						+'				<div class="product-action-2">'
						+'					<a title="Add to cart" href="productDetail?PD_IDX='+ pr.PD_IDX +'">상품 상세페이지로 바로가기</a>'
						+'				</div>'
						+'			</div>'
						+'		</div>'
						+'		<div class="product-content">'
						+'			<h3><a href="productDetail?PD_IDX='+ pr.PD_IDX +'">' + pr.PD_SUBJECT +'</a></h3>'
						+'			<div class="product-price">'
						+'				<span>'+ pr.PD_PRICE +' 원</span>'
						+'				<span class="pro_time" style="float:right; color:gray"><small>'+ pr.RD_DATE +'</small></span>'
						+'			</div>'
						+'		</div>'
						+'	</div>'
						+'	</div>'
					    // +'	</div>'
						
						owl.trigger('add.owl.carousel', [$(productDetail)]);		
				});
				
				owl.trigger('refresh.owl.carousel');
				owl.trigger("initialize");
				
            }
        });
	
	} 
	
