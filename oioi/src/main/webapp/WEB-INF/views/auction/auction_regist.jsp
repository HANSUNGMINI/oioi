<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="zxx">
<head>
	<!-- Meta Tag -->
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name='copyright' content=''>
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<!-- Title Tag  -->
    <title> 경매상품등록 </title>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
   	<script src="https://unpkg.com/@yaireo/tagify"></script>
	<script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
	<!-- Favicon 
	     인터넷 위에보면 아이콘 넣기 가능 이미지만 바꾸며ㅑㄴ댐-->
<%-- 	<link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png"> --%>
	<!-- Web Font -->
	<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
	
	<!-- StyleSheet -->
	
	<!-- Bootstrap -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
	<!-- Magnific Popup -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/magnific-popup.min.css">
	<!-- Font Awesome -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.css">
	<!-- Fancybox -->
<%-- 	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.fancybox.min.css"> --%>
	<!-- Themify Icons -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/themify-icons.css">
	<!-- Nice Select CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/niceselect.css">
	<!-- Animate CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/animate.css">
	<!-- Flex Slider CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flex-slider.min.css">
	<!-- Owl Carousel -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl-carousel.css">
	<!-- Slicknav -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slicknav.min.css">
	
	<!-- Eshop StyleSheet -->
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/responsive.css">

	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/color.css">
	
	<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/product.css">
	
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
	
	<!-- Test -->
	<link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<script type="text/javascript">
		
		$(document).ready(function() {
		    let cate2 = JSON.parse('${cate2}');
		    let cate3 = JSON.parse('${cate3}');
		    console.log('cate2:', cate2);
		    console.log('cate3:', cate3);
	
		    $('#cate1').change(function() {
		        var selectedCate2 = $(this).val();
		        console.log('cate1:', selectedCate2);
		        
		        var filteredCate2s = cate2.filter(function(cate) {
		            return cate.UP_CTG_CODE == selectedCate2; // 필터 조건 확인 2000
		        });
		        
		        console.log('cate2s:', filteredCate2s);
		        
		        
		        $('#cate2').empty().append('<option value="">중분류를 선택하시오</option>');
		        	
		        $.each(filteredCate2s, function(index, cate) {
			            $('#cate2').append($('<option>').text(cate.CTG_NAME).attr('value', cate.CTG_CODE));
			    });
		        $('#cate2').prop('disabled', false).niceSelect('update');
		        
		        console.log("cate1(value) : " + $('#cate1').val());
		    });
		    
		    $('#cate2').change(function(){
		    	var selectedCate3 = $(this).val();
		    	console.log('selectedCate3 :', selectedCate3);
		    	
		    	var filteredCate3s = cate3.filter(function(cate) {
		            return cate.UP_CTG_CODE == selectedCate3; // 필터 조건 확인 1100
		        });
		    	console.log('cate3s:', filteredCate3s);
		    	
		    	$('#cate3').empty().append('<option value="">소분류를 선택하시오</option>');
		    	
		    	$.each(filteredCate3s, function(index, cate) {
		            $('#cate3').append($('<option>').text(cate.CTG_NAME).attr('value', cate.CTG_CODE));
			    });
		        $('#cate3').prop('disabled', false).niceSelect('update');
		        
		        console.log("cate2(value) : " + $('#cate2').val());
		    });
		    
		    $('#myForm').on('submit', function(event){
		    	if(!Valid(event)){
		    		event.preventDefault();
		    	}
		    	
		    });
		    
		    
			
		});
		
		function Valid(event){
			var APD_NAME = $('#APD_NAME').val();
			var APD_DETAIL = $('#APD_DETAIL').val();
			
			console.log('APD_DETAIL : ' + APD_DETAIL);
			if(APD_NAME == ""){
				err("상품명을 입력하세요");
				return false;
			}else if(APD_DETAIL == ""){
				err("상세설명을 입력하세요");
				return false;
			}
		}
		
		function err(msg){
			Swal.fire({
    	        title: msg,
    	        icon: 'warning',
    	        confirmButtonText: '확인'
    	    })
		}
	
	</script>
	
</head>
<body class="js">
	<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
	<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
	
	<!-- Breadcrumbs -->
	<div class="breadcrumbs">
		<div class="container">
			<div class="row">
				<div class="col-12">
					<div class="bread-inner">
						<ul class="bread-list">
							<li><a href="./">Home<i class="ti-arrow-right"></i></a></li>
							<li class="active"><a href="notice">경매<i class="ti-arrow-right"></i></a></li>
							<li class="active"><a href="notice">등록</a></li>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
	<!-- End Breadcrumbs -->
		
		<!-- Shop Login -->
		<section class="shop login section">
			<div class="container">
				<div class="row"> 
					<div class="col-lg-6 offset-lg-3 col-12">
						<div class="login-form">
							<h2>경매 상품 등록</h2>
							<p>상품 정보를 입력해주세요</p>
							<!-- Form -->
							<form class="form" method="post" action="auctionRegist" id="myForm" enctype="multipart/form-data" name="fr">
								<div class="row">
									<div class="col-12">
										<div class="form-group">
											<div>
												<label>카테고리<span>*</span></label>
											</div>
											<select id="cate1" name="cate1" class="form-control" >
				                                <option value="">대분류</option>
				                                <c:forEach var="cate1" items="${cate1}">
				                                    <option value="${cate1.CTG_CODE}">${cate1.CTG_NAME}</option>
				                                </c:forEach>
				                            </select>
				                            
				                            <select id="cate2" name="cate2" class="form-control"  disabled>
				                                    <option value="">중분류를 선택하시오</option>
				                            </select>
				                            
				                            <select id="cate3" name="cate3" class="form-control"  disabled>
				                                    <option value="">소분류를 선택하시오</option>
				                            </select>
										</div>
										
									</div>
									<div class="col-12" style="margin-top: 15px;">
										<div class="form-group">
											<label>상품명<span>*</span></label>
											<input type="text" name="APD_NAME" id="APD_NAME" placeholder="상품명">
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>상품설명<span>*</span></label>
											<textarea name="APD_DETAIL" id="APD_DETAIL" maxlength="300" placeholder="상품에 대한 상세한 정보(사이즈,상태 등)를 작성하세요" class="form-control"></textarea>
										</div>
									</div>
									<div class="col-12" style="margin-bottom: 15px;">
									    <div class="">
									    	<div>
									        <label>상품상태<span style="color: red; margin-left: 5px;">*</span></label>
									        </div>
											<c:forEach var="productCondition" items="${productCondition}">
												<input type="radio" name="APD_CONDITION" value="${productCondition.code}" style="margin-bottom: 5px;">${productCondition.value}<br>
											</c:forEach>
									    </div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>판매시작가<span>*</span></label>
											<input type="text" name="APD_START_PRICE" id="APD_START_PRICE" maxlength="16" placeholder="시작가" >
										</div>
									</div>
									<div class="col-12">
										<div class="form-group">
											<label>즉시판매가<span>*</span></label>
											<input type="text" name="APD_BUY_NOW_PRICE" id="APD_BUY_NOW_PRICE" maxlength="16" placeholder="즉시판매가" >
										</div>
									</div>
									<div class="col-12" style="margin-bottom: 15px;">
									    <div>
									        <label>거래방식<span style="color: red; margin-left: 5px;">*</span></label>
									        <div style="display: flex; align-items: center;">
									            <label for="female" style="display: flex; align-items: center; margin-right: 10px;">
									                <input type="radio" id="female" name="PD_METHOD" value="PM03" checked="checked"> 택배거래만 가능
									            </label>
									        </div>
									    </div>
									</div>
									<div class="col-12" style="margin-bottom: 15px;">
										<div>
											<label>입찰마감기한<span style="color: red; margin-left: 5px;">*</span></label>
											<div style="display: flex; align-items: center;">
									            <label style="display: flex; align-items: center; margin-right: 10px;">
									                <input type="radio" name="APD_DEADLINE" value="3" > 3일
									            </label>
									            <label style="display: flex; align-items: center; margin-right: 10px;" >
									                <input type="radio" name="APD_DEADLINE" value="5" size="5"> 5일
									            </label>
									            <label style="display: flex; align-items: center; margin-right: 10px;">
									                <input type="radio" name="APD_DEADLINE" value="7"> 7일
									            </label>
									        </div>
										</div>
									</div>
									<div class="col-12">
										<div class="regForm">
											<label> 상품 메인 이미지<small>(규격)</small></label>
											<input type="file" accept="image/*" id="APD_MAIN_IMAGE" name="APD_MAIN_IMAGE" class="form-control" >
											<div class="mainPreView"></div>
										</div>
									</div>
									<div class="col-12">
										<div class="regForm">
											<label> 상품 이미지<small>(최대 5장)</small></label>
											<input type="file" accept="image/*" id="APD_IMAGE" name="APD_IMAGE" multiple="multiple" class="form-control" >
											<div class="preView"></div>
										</div>
									</div>
									<div class="col-12" style="margin-top: 50px;">
										<div class="form-group login-btn">
											<button class="btn" type="submit">상품등록</button>
										</div>
									</div>
								</div>
							</form>
							<!--/ End Form -->
						</div>
					</div>
				</div>
			</div>
		</section>
		<!--/ End Login -->
			
		<footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>
 
	<!-- Jquery -->
	<script>
	$(function() {

        $("#APD_IMAGE").on("change", function(event) {
        	$('.preView img:gt(0)').remove();
            if (this.files.length > 4) {
                alert("최대 4개의 이미지만 업로드할 수 있습니다.");
                this.value = ""; // 선택된 파일 초기화
                return;
            }
            
            $('.preView img:gt(0)').remove(); // 기존 미리보기 이미지 제거
            for (var i = 0; i < this.files.length; i++) {
                let reader = new FileReader();
                reader.onload = function(event) {
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    img.setAttribute("class", "tempImg");
                    img.setAttribute("name", "APD_IMAGE");
                    img.style.width = "100px"; // 원하는 너비로 설정
                    img.style.height = "100px"; // 원하는 높이로 설정
                    img.style.objectFit = "cover"; // 이미지의 크기를 조절하여 컨테이너에 맞추기
                    img.style.margin = "5px"; // 이미지 간의 간격을 추가
                    $(".preView").append(img);
                };
                reader.readAsDataURL(this.files[i]);
            }
            
        });
        
        //썸내일
        $("#APD_MAIN_IMAGE").on("change", function(event) {
            // 미리보기 이미지를 모두 제거
            $(".mainPreView").empty();
            
            if (this.files.length > 1) {
                alert("한 개의 이미지 파일만 업로드할 수 있습니다.");
                this.value = ""; // 선택된 파일 초기화
                return;
            }
            
            if (this.files.length == 1) {
                let reader = new FileReader();
                reader.onload = function(event) {
                    var img = document.createElement("img");
                    img.setAttribute("src", event.target.result);
                    img.setAttribute("class", "tempImg");
                    img.setAttribute("name", "APD_MAIN_IMAGE");
                    img.style.width = "100px"; // 원하는 너비로 설정
                    img.style.height = "100px"; // 원하는 높이로 설정
                    img.style.objectFit = "cover"; // 이미지의 크기를 조절하여 컨테이너에 맞추기
                    img.style.margin = "5px"; // 이미지 간의 간격을 추가
                    $(".mainPreView").append(img);
                };
                reader.readAsDataURL(this.files[0]);
            }
        });

        var input = document.querySelector('.tagify');
        tagify = new Tagify(input, {
            maxTags: 5
        });
        tagify.on('add', function() {
            console.log(tagify.value);
        });
    });
	</script>
    
    <script src="${pageContext.request.contextPath}/resources/js/jquery-migrate-3.0.0.js"></script>
	<script src="${pageContext.request.contextPath}/resources/js/jquery-ui.min.js"></script>
	<!-- Popper JS -->
	<script src="${pageContext.request.contextPath}/resources/js/popper.min.js"></script>
	<!-- Bootstrap JS -->
	<script src="${pageContext.request.contextPath}/resources/js/bootstrap.min.js"></script>
	<!-- Color JS -->
	<script src="${pageContext.request.contextPath}/resources/js/colors.js"></script>
	<!-- Slicknav JS -->
	<script src="${pageContext.request.contextPath}/resources/js/slicknav.min.js"></script>
	<!-- Owl Carousel JS -->
	<script src="${pageContext.request.contextPath}/resources/js/owl-carousel.js"></script>
	<!-- Magnific Popup JS -->
	<script src="${pageContext.request.contextPath}/resources/js/magnific-popup.js"></script>
	<!-- Fancybox JS -->
	<script src="${pageContext.request.contextPath}/resources/js/facnybox.min.js"></script>
	<!-- Waypoints JS -->
	<script src="${pageContext.request.contextPath}/resources/js/waypoints.min.js"></script>
	<!-- Countdown JS -->
	<script src="${pageContext.request.contextPath}/resources/js/finalcountdown.min.js"></script>
	<!-- Nice Select JS -->
	<script src="${pageContext.request.contextPath}/resources/js/nicesellect.js"></script>
	<!-- Ytplayer JS -->
<%-- 	<script src="${pageContext.request.contextPath}/resources/js/ytplayer.min.js"></script> --%>
	<!-- Flex Slider JS -->
	<script src="${pageContext.request.contextPath}/resources/js/flex-slider.js"></script>
	<!-- ScrollUp JS -->
	<script src="${pageContext.request.contextPath}/resources/js/scrollup.js"></script>
	<!-- Onepage Nav JS -->
	<script src="${pageContext.request.contextPath}/resources/js/onepage-nav.min.js"></script>
	<!-- Easing JS -->
	<script src="${pageContext.request.contextPath}/resources/js/easing.js"></script>
	<!-- Active JS -->
	<script src="${pageContext.request.contextPath}/resources/js/active.js"></script>
	
	
	<!-- Test -->

	
</body>
</html>