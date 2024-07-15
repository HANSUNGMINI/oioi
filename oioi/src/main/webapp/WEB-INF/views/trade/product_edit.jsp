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
    <title> 상품 수정 </title>
    <script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
    <script src="https://code.jquery.com/jquery-3.7.1.js"></script>
    <!-- 태그 스크립트 -->
    <script src="https://unpkg.com/@yaireo/tagify"></script>
    <script src="https://unpkg.com/@yaireo/tagify/dist/tagify.polyfills.min.js"></script>
    
    <!-- Favicon -->
    <link rel="icon" type="image/png" href="${pageContext.request.contextPath}/resources/images/favicon.png">
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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.fancybox.min.css">
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
    
    <!-- Test -->
    <link href="https://unpkg.com/@yaireo/tagify/dist/tagify.css" rel="stylesheet" type="text/css" />

</head>
<body class="js">

    <header><jsp:include page="../INC/top.jsp"></jsp:include></header>
    
    <!-- Breadcrumbs -->
    <div class="breadcrumbs">
        <div class="container">
            <div class="row">
                <div class="col-12">
                    <div class="bread-inner">
                        <ul class="bread-list">
                            <li><a href="index1.html">Home<i class="ti-arrow-right"></i></a></li>
                            <li class="active"><a href="blog-single.html">상품수정</a></li>
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
            <div class="login-form">
                <h2>상품수정</h2>
                <!-- Form -->
                <form class="regForm" action="productModify2" method="post" enctype="multipart/form-data">
                    <input type="hidden" name="PD_IDX" value="${product.PD_IDX}">
                    <ul>
                        <li>
                            <label> 상품 이미지<small>(최대 5장)</small></label>
                            <input type="file" accept="image/*" name="addfile" multiple id="addfile" style="display : none">
                            <div class="preView">
                                <c:if test="${not empty product.image1}">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${product.image1}" class="tempImg">
                                </c:if>
                                <c:if test="${not empty product.image2}">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${product.image2}" class="tempImg">
                                </c:if>
                                <c:if test="${not empty product.image3}">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${product.image3}" class="tempImg">
                                </c:if>
                                <c:if test="${not empty product.image4}">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${product.image4}" class="tempImg">
                                </c:if>
                                <c:if test="${not empty product.image5}">
                                    <img src="${pageContext.request.contextPath}/resources/upload/${product.image5}" class="tempImg">
                                </c:if>
                                <img src="${pageContext.request.contextPath}/resources/images/submitIMG.png" class="tempImg addImg">
                            </div>
                        </li>
                        <li>
                            <label> 상품명</label>
                            <input type="text" name="PD_SUBJECT" placeholder="상품명을 입력하여 주세요" value="${product.PD_SUBJECT}">
                        </li>
                        <li>
                            <label> 카테고리</label>
                            <select id="cate1" name="cate1" class="form-control" required>
                                <option value="">대분류</option>
                                <c:forEach var="cate" items="${cate1}">
                                    <option value="${cate.CTG_CODE}" ${cate.SELECTED}>${cate.CTG_NAME}</option>
                                </c:forEach>
                            </select>
                            
                            <select id="cate2" name="cate2" class="form-control" required>
                                <option value="">중분류를 선택하시오</option>
                                <c:forEach var="cate2" items="${cate2}">
                                    <option value="${cate2.CTG_CODE}" ${cate2.SELECTED}>${cate2.CTG_NAME}</option>
                                </c:forEach>
                            </select>
                            
                            <select id="cate3" name="cate3" class="form-control" required>
                                <option value="">소분류를 선택하시오</option>
                                <c:forEach var="cate3" items="${cate3}">
                                    <option value="${cate3.CTG_CODE}" ${cate3.SELECTED}>${cate3.CTG_NAME}</option>
                                </c:forEach>
                            </select>
                        </li>
                        <li>
                            <label> 태그(선택)</label>
                            <input class="tagify" placeholder="태그를 입력해주세요" maxlength="6" name="PD_TAG" value="${product.PD_TAG}">
                        </li>
                        <li>
                            <label> 상품상태 </label>
                            <ul>
                                <c:forEach var="productCondition" items="${productCondition}">
                                    <li><input type="radio" name="PD_CONDITION" value="${productCondition.code}" <c:if test="${product.PD_CONDITION == productCondition.code}">checked</c:if>>${productCondition.value}</li>
                                </c:forEach>
                            </ul>
                        </li>
                        <li>
                            <label> 가격 </label>
                            <input type="text" id="price" name="PD_PRICE" placeholder="원" value="${product.PD_PRICE}"><br>
                            <label class="checkbox-inline" for="2"><input name="PD_PRICE_OFFER" id="2" type="checkbox" <c:if test="${product.PD_PRICE_OFFER == 'on'}">checked</c:if>>가격 제안 가능</label>
                        </li>
                        <li>
                            <label> 상품설명</label>
                            <textarea id="content" name="PD_CONTENT" placeholder="브랜드, 모델명, 구매시기를 자세히 기입하여 주십시오">${product.PD_CONTENT}</textarea>
                        </li>
                        <li>
                            <label> 거래 방식 </label>
                            <ul>
                                <c:forEach var="tradeMethod" items="${tradeMethod}">
                                    <li><input type="radio" name="PD_TRADE_METHOD" value="${tradeMethod.code}" <c:if test="${product.PD_TRADE_METHOD == tradeMethod.code}">checked</c:if>>${tradeMethod.value}</li>
                                </c:forEach>
                            </ul>
                        </li>
                        <li>
                            <label> 안전 거래 여부 </label>
                            <label class="checkbox-inline" for="2"><input name="PD_SAFE_TRADE" id="2" type="checkbox" <c:if test="${product.PD_SAFE_TRADE == 'on'}">checked</c:if>>안전 거래 사용</label>
                        </li>
                    </ul>
                    <input type="hidden" name="PD_STATUS" value="${product.PD_STATUS}">
                    <input type="submit" id="subimit" value="수정하기">
                </form>
                <!--/ End Form -->
            </div>
        </div>
    </section>
    <!--/ End Login -->
    
    <footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>
    
    <script>
        $(function() {
            $(".addImg").on("click", function() {
                $('#addfile').click();
            });

            $("#addfile").on("change", function(event) {
                $('.preView img:gt(0)').remove(); // 기존 미리보기 이미지 제거
                if (this.files.length > 5) {
                    alert("최대 5개의 이미지만 업로드할 수 있습니다.");
                    this.value = ""; // 선택된 파일 초기화
                    return;
                }

                for (var i = 0; i < this.files.length; i++) {
                    let reader = new FileReader();
                    reader.onload = function(event) {
                        var img = document.createElement("img");
                        img.setAttribute("src", event.target.result);
                        img.setAttribute("class", "tempImg");
                        $(".preView").append(img);
                    };
                    reader.readAsDataURL(this.files[i]);
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

        //카테고리 ==================================================================
        $(document).ready(function() {
        	// let cate1 = JSON.parse('${cate1}');
            let cate2 = JSON.parse('${jCate2}');
            let cate3 = JSON.parse('${jCate3}');
         	// 카테고리 수정 시 초기 값 설정
         	
         	
            $('#cate1').trigger('change');
            $('#cate2').val('${product.jCate2}').trigger('change');
            $('#cate3').val('${product.jCate3}');

            $('#cate1').change(function() {
                var selectedCate2 = $(this).val();
                console.log('cate1:', selectedCate2);

                var filteredCate2s = cate2.filter(function(cate) {
                    return cate.UP_CTG_CODE == selectedCate2;
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
                    return cate.UP_CTG_CODE == selectedCate3;
                });
                console.log('cate3s:', filteredCate3s);

                $('#cate3').empty().append('<option value="">소분류를 선택하시오</option>');

                $.each(filteredCate3s, function(index, cate) {
                    $('#cate3').append($('<option>').text(cate.CTG_NAME).attr('value', cate.CTG_CODE));
                });
                $('#cate3').prop('disabled', false).niceSelect('update');
                console.log("cate2(value) : " + $('#cate2').val());
            });
            
        });
    </script>
    
    	<!-- Jquery -->
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
	
</body>
</html>
