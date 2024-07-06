

/* 정리 */ /* ^__^ (검색해서 찾아올 수 있도록) */
/* ======================================================== *
	
	[ id 및 class명 정리 ]

	2. storedProducts		= 최근 본 상품 목록
	
-------------------------------------------------------

	[ 함수 정리 ]

	2. showRecentLookProduct()		: 최근 본 상품 목록 출력
	
============================================================ */
 
 $(function(){
	
	
	 
	/* 최근 본 상품 함수 호출 */
	showRecentLookProduct();
	
}) // ready 이벤트 끝

	/* 최근 본 상품 */
	function showRecentLookProduct() {
		let storedProducts = JSON.parse(localStorage.getItem("auctionProducts")) || [];
		storedProducts = storedProducts.join(',');
		console.log("storedProducts : " + storedProducts);
		let isNull = false;
		if (storedProducts.length === 0) {
			alert("이건 떠?")
			isNull = true;
		}
	
		if (isNull) {
			let nullDiv = '<div style="margin:0 auto; text-align:center; height: 100px;"> 최근 본 상품 목록이 비어 있습니다. </div>';
			$("#noProduct").append(nullDiv);
			return;  // 최근 본 상품이 없을 경우 
		}
		
        $.ajax({
            type: "GET",
            url: "recentLookAuctionProductList",
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
					// 뽑아내기
					let auctionProductDetail = 
						 '	<div class="owl-item">'
						+'	<div class="single-product">'
						+'		<div class="product-img">'
						+'			<a href="auctionDetail?APD_IDX='+ pr.APD_IDX +'">'
						+'             <img class="default-img" src="' + '/oi/resources/upload/' + pr.APD_MAIN_IMAGE + '">'
						+'				<span class="'+ pr.APD_STATUS_COLOR +'">' +  pr.APD_STATUS_VALUE +'</span> <!-- out-of-stock = 빨간색 / new = 파란?보라?색 / price-dec = 초록색 -->'
						+'			</a>'
						+'			<div class="button-head">'
						+'				<div class="product-action">'
						+'					<a title="Wishlist" href="#"><i class=" ti-heart "></i><span>찜하기</span></a>'
						+'				</div>'
						+'				<div class="product-action-2">'
						+'					<a title="Add to cart" href="auctionDetail?APD_IDX='+ pr.APD_IDX +'">상품 상세페이지로 바로가기</a>'
						+'				</div>'
						+'			</div>'
						+'		</div>'
						+'		<div class="product-content">'
						+'			<h3><a href="product-details.html">'+ pr.APD_NAME +'</a></h3>'
						+'			<div class="product-price">'
						+'				<span>[판매시작가] ' + new Intl.NumberFormat().format(pr.APD_START_PRICE) + '원</span><br>'
						+'				<span>[즉시구매가] ' + new Intl.NumberFormat().format(pr.APD_BUY_NOW_PRICE) + '원</span>'
						+'				<span class="pro_time" style="float:right; color:gray"><small>'+ pr.ARD_DATE +'</small></span>'
						+'			</div>'
						+'		</div>'
						+'	</div>'
						+'	</div>'
						
						owl.trigger('add.owl.carousel', [$(auctionProductDetail)]);		
				});
				
				owl.trigger('refresh.owl.carousel');
				owl.trigger("initialize");
				
            }
        });
	
	} 
	

	
