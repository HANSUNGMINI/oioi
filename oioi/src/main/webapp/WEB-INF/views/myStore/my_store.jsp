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
<title>내 상점</title>
<!-- Web Font -->
<link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
<!-- StyleSheet -->
<script src="https://kit.fontawesome.com/ef42a902c7.js" crossorigin="anonymous"></script>
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

<style>
#custom-border {
    border: 1px solid #ccc; 
    padding: 10px; 
    position: relative;
}

#store-info {
    display: flex;
    margin-top: 15px;
    flex-wrap: wrap;
    gap: 5px;
}

#store-info > div {
    display: flex;
    align-items: center;
    margin-right: 15px;
}

#store-info > div > div {
    margin: 0 10px;
}

.short {
    flex-grow: 1;
}

.product-des button {
    font-family: inherit;
    line-height: 1.15;
    margin: 0;
    overflow: visible;
    text-transform: none;
    cursor: pointer;
    outline: none;
    height: 20px;
    display: flex;
    align-items: center;
    padding: 0 5px;
    color: #888;
    border: 1px solid #eee;
    font-size: 11px;
}

.border-right {
    border-right: 1px solid #ccc;
}

#intro-textarea {
    overflow: hidden;
    resize: none;
    width: 100%;
    height: calc(1.5em * 4);
    line-height: 1.5em;
    box-sizing: border-box;
}

.cucumber-button {
    background: linear-gradient(145deg, #7ed957, #5cbf34);
    border: none;
    border-radius: 25px;
    padding: 10px 20px;
    font-size: 16px;
    font-weight: bold;
    color: white;
    text-transform: uppercase;
    cursor: pointer;
    transition: background 0.3s ease;
}

.cucumber-button:hover {
    background: linear-gradient(145deg, #5cbf34, #7ed957);
}

.cucumber-button:active {
    background: linear-gradient(145deg, #4da82e, #6fcd4f);
}

#product-header {
    display: flex;
    justify-content: space-between;
    align-items: center;
}

.product-grid {
    display: grid;
    grid-template-columns: repeat(auto-fill, minmax(200px, 1fr));
    gap: 20px;
}

.product-item {
    border: 1px solid #ccc;
    padding: 10px;
    text-align: center;
    position: relative;
}

.product-item img {
    max-width: 100%;
    height: auto;
}

.product-info-bottom {
    display: flex;
    justify-content: space-between;
    align-items: center;
    margin-top: 10px;
}

.product-info-bottom div {
    margin: 0 5px;
}

.product-price {
    font-weight: bold;
    color: #333;
}

.product-date {
    font-size: 12px;
    color: #777;
}
</style>
</head>
<body class="js">
<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
<section class="shop single section">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div class="row" id="custom-border">
                    <div class="col-lg-3 col-12 border-right">
                        <div class="single-team">
                            <div class="image">
                                <img src="${pageContext.request.contextPath}/resources/images/test.png" alt="#">
                            </div>
                        </div>
                    </div>
                    <div class="col-lg-9 col-12">
                        <div class="product-des">
                            <div class="short">
                                <h4>${user.US_NICK} 님의 상점</h4>
                                <button class="cucumber-button" onclick="location.href='editStore'">내 상점 관리</button>
                                <div class="rating-main" id="store-info">
                                    <div>
                                        <i class="fa-solid fa-shop"></i>
                                        <div id="store-column">상점오픈일</div>
                                        <div>1 일 전</div>
                                    </div>
                                    <div>
                                        <i class="fa-solid fa-person"></i>
                                        <div id="store-column">상점방문수</div>
                                        <div>0 명</div>
                                    </div>
                                    <div>
                                        <i class="fa-solid fa-bag-shopping"></i>
                                        <div id="store-column">상품판매</div>
                                        <div>0 회</div>
                                    </div>
                                </div>
                                <hr>
                            </div>
                            <div id="intro-text">
                                <button id="edit-button" type="button">소개글 수정</button>
                                <p>소개글을 작성해주세요.</p>
                            </div>
                            <div id="edit-area" style="display: none;">
                                <textarea id="intro-textarea" rows="3" maxlength="150"></textarea>
                                <button id="save-button" type="button">확인</button>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-12">
                        <div class="product-info">
                            <div class="nav-main">
                                <ul class="nav nav-tabs" id="myTab" role="tablist">
                                    <li class="nav-item"><a class="nav-link active" data-toggle="tab" href="#product" role="tab">상품</a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#review" role="tab">상점후기</a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#choice" role="tab">찜</a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#following" role="tab">팔로잉</a></li>
                                    <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#follower" role="tab">팔로워</a></li>
                                </ul>
                            </div>
                            <div class="tab-content" id="myTabContent">
                                <div class="tab-pane fade show active" id="product" role="tabpanel">
                                    <div class="tab-single">
                                        <div class="row">
                                            <div class="col-12">
                                                <div id="product-header">
                                                    <h5>상품 ${fn:length(myPD)}</h5>
                                                    <a href="product" class="cucumber-button">상품등록</a>
                                                </div>
                                                <hr>
                                                <div class="product-grid">
                                                    <c:forEach var="product" items="${myPD}">
                                                        <div class="product-item">
                                                        <a href="productDetail?PD_IDX=${product.PD_IDX}">
                                                            <img src="<%= request.getContextPath() %>/resources/upload/${product.image1}" alt="${product.PD_SUBJECT}">
                                                            <p>${product.PD_SUBJECT}</p>
                                                            <div class="product-info-bottom">
                                                                <div class="product-price">${product.PD_PRICE} 원</div>
                                                                <div class="product-date">${product.timeAgo}</div>
                                                            </div>
                                                            </a>
                                                        </div>
                                                    </c:forEach>
                                                </div>
                                                <c:if test="${empty myPD}">
                                                    <div class="single-des">
                                                        <p>등록된 상품이 없습니다.</p>
                                                    </div>
                                                </c:if>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="review" role="tabpanel">
                                    <div class="tab-single">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="single-des">
                                                    <h5>상점 후기 0</h5>
                                                </div>
                                                <hr>
                                                <div class="single-des">
                                                    <p>상점후기가 없습니다.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="choice" role="tabpanel">
                                    <div class="tab-single">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="single-des">
                                                    <h5>찜 0</h5>
                                                </div>
                                                <hr>
                                                <div class="single-des">
                                                    <p>찜한 상품이 없습니다.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="following" role="tabpanel">
                                    <div class="tab-single">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="single-des">
                                                    <h5>팔로잉 0</h5>
                                                </div>
                                                <hr>
                                                <div class="single-des">
                                                    <p>아직 팔로우한 사람이 없습니다.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="tab-pane fade" id="follower" role="tabpanel">
                                    <div class="tab-single">
                                        <div class="row">
                                            <div class="col-12">
                                                <div class="single-des">
                                                    <h5>팔로워 0</h5>
                                                </div>
                                                <hr>
                                                <div class="single-des">
                                                    <p>아직 이 상점을 팔로우한 사람이 없습니다.</p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>  
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>

<!-- Jquery -->
<script src="${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
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
<script src="${pageContext.request.contextPath}/resources/js/ytplayer.min.js"></script>
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

<script>
document.getElementById("edit-button").addEventListener("click", function() {
    document.getElementById("intro-text").style.display = "none";
    document.getElementById("edit-area").style.display = "block";
    document.getElementById("intro-textarea").value = document.querySelector("#intro-text p").innerText;
});

document.getElementById("save-button").addEventListener("click", function() {
    const newText = document.getElementById("intro-textarea").value;
    document.querySelector("#intro-text p").innerText = newText;
    document.getElementById("intro-text").style.display = "block";
    document.getElementById("edit-area").style.display = "none";
});

document.getElementById("intro-textarea").addEventListener("input", function() {
    const lines = this.value.split('\n');
    if (lines.length > 4) {
        this.value = lines.slice(0, 4).join('\n');
    }
});
</script>

</body>
</html>