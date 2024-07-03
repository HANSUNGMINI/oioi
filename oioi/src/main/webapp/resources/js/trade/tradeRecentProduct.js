

/* ======================================================== *

	[ 함수 정리 ]

	1. showRecentLookProduct()	: 최근 검색한 키워드 연관 상품 출력
	
============================================================ */
 
 $(function(){
 	showRecentLookProduct();
	
	/* 최근 본 상품 함수 호출 */
	let contextPath = "<%=request.getContextPath()%>";
	
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
			// $("#noProduct").append(nullDiv);
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
					$("#recentProduct").append(nullDiv);
					return;  // 최근 본 상품이 없을 경우 
				}
				
				$.each(productList, function(index, pr) {
				
					let productDetail = 
						  	' <div class="image">'
                           + '    <img src="' + contextPath + '/resources/upload/' + pr.IMG + '">'
                           +' </div>'
                           +'     <div class="content">'
                           +'         <h5><a href="productDetail?PD_IDX='+ pr.PD_IDX +'">' + pr.PD_SUBJECT +'</a></h5>'
                           +'        <small>'+ pr.RD_DATE +'</small>'
                           +'        <p class="price">'+ pr.PD_PRICE +' 원'
                           +' </div>'
                           +'<hr>'
                           
                      $("#recentProduct").append(productDetail);
				});
				
            }
        });
	
	}
}) // ready 이벤트 끝

