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
        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8f8f8;
        }

        #custom-border {
            border: 1px solid #ccc; 
            padding: 10px; 
            position: relative;
            background-color: #fff;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border-radius: 5px;
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
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
        }

        .product-item img {
            max-width: 100%;
            height: auto;
            border-radius: 5px;
        }

        .overlay {
            position: absolute;
            top: 0;
            bottom: 0;
            left: 0;
            right: 0;
            height: 100%;
            width: 100%;
            opacity: 0.7;
            background-color: black;
            color: white;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 24px;
            font-weight: bold;
            border-radius: 5px;
        }

        .product-details {
            display: flex;
            flex-direction: column;
            align-items: flex-start;
            padding: 10px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .product-info-bottom {
            display: flex;
            justify-content: space-between; /* 텍스트를 양쪽으로 정렬 */
            align-items: center;
            width: 100%; /* 양쪽 정렬을 위해 전체 너비를 차지 */
            margin-top: 10px;
        }

        .product-price {
            font-weight: bold;
            color: #333;
        }

        .product-date {
            font-size: 12px;
            color: #777;
        }

        #profile-pic-container {
            position: relative;
            display: inline-block;
        }

        #change-pic-button {
            position: absolute;
            top: 10px;
            right: 10px;
            background-color: rgba(0, 0, 0, 0.6);
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
            display: none;
        }

        #profile-pic-container:hover #change-pic-button {
            display: block;
        }

        #intro-text p {
            margin-top: 10px;
            color: #666;
        }

        #edit-area {
            margin-top: 10px;
        }

        #edit-button, #save-button {
            margin-top: 10px;
            background-color: #28a745;
            color: white;
            border: none;
            padding: 5px 10px;
            cursor: pointer;
            border-radius: 5px;
        }

        #edit-button:hover, #save-button:hover {
            background-color: #218838;
        }

        .star-rating {
            color: #ffcc00;
            font-size: 1.2em;
        }

        .review-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 20px;
        }

        .review-item img {
            width: 50px;
            height: 50px;
            border-radius: 50%;
            margin-right: 10px;
        }

        .review-item .review-content {
            flex-grow: 1;
        }

        .review-item .review-categories {
            margin-top: 10px;
        }

        .review-item .review-categories span {
            display: inline-block;
            margin-right: 5px;
            padding: 5px 10px;
            background-color: #f1f1f1;
            border-radius: 5px;
            font-size: 0.9em;
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
                                <div id="profile-pic-container">
                                    <c:choose>
                                        <c:when test="${empty user.US_PROFILE}">
                                            <img id="profile-pic" src="${pageContext.request.contextPath}/resources/images/test.png" alt="#" width="256px;" height="193px;">
                                        </c:when>
                                        <c:otherwise>
                                            <img id="profile-pic" src="${user.US_PROFILE}" width="287px;" height="204px;" alt="#">
                                        </c:otherwise>
                                    </c:choose>
                                    <c:if test="${user.US_ID eq sessionScope.US_ID}">
                                        <label for="profile-pic-input" id="change-pic-button">프로필 사진 변경</label>
                                        <input type="file" id="profile-pic-input" name="file1" style="display:none;">
                                    </c:if>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-9 col-12">
                            <div class="product-des">
                                <div class="short">
                                    <h4>${user.US_NICK} 님의 상점</h4>
                                    <c:if test="${user.US_ID eq sessionScope.US_ID}">
                                        <button class="cucumber-button" onclick="location.href='editStore'">내 상점 관리</button>
                                    </c:if>
                                    <div class="rating-main" id="store-info">
                                        <div>
                                            <i class="fa-solid fa-shop"></i>
                                            <div id="store-column">상점오픈일</div>
                                            <div>${user.open}</div>
                                        </div>
                                        <div>
                                            <i class="fa-solid fa-person"></i>
                                            <div id="store-column">상점방문수</div>
                                            <div>${visitCount} 명</div>
                                        </div>
                                        <div>
                                            <i class="fa-solid fa-bag-shopping"></i>
                                            <div id="store-column">상품판매</div>
                                            <div>${salesCount} 회</div>
                                        </div>
                                        <div>
                                            <i class="fa-solid fa-droplet"></i>
                                            <div id="store-column">신선도</div>
                                            <div>
                                            	${user.US_OILEVEL} 도
                                            	<c:choose>
											        <c:when test="${user.US_OILEVEL >= 0 && user.US_OILEVEL < 10}">썩음🤮</c:when>
											        <c:when test="${user.US_OILEVEL >= 10 && user.US_OILEVEL < 20}">상당히 썩음🤢</c:when>
											        <c:when test="${user.US_OILEVEL >= 20 && user.US_OILEVEL < 30}">다소 썩음😕</c:when>
											        <c:when test="${user.US_OILEVEL >= 30 && user.US_OILEVEL < 40}">미지근함😐</c:when>
											        <c:when test="${user.US_OILEVEL >= 40 && user.US_OILEVEL < 50}">보통😊</c:when>
											        <c:when test="${user.US_OILEVEL >= 50 && user.US_OILEVEL < 60}">신선한☺️</c:when>
											        <c:when test="${user.US_OILEVEL >= 60 && user.US_OILEVEL < 70}">매우 신선한😄</c:when>
											        <c:when test="${user.US_OILEVEL >= 70 && user.US_OILEVEL < 80}">매우 매우 신선한😆</c:when>
											        <c:when test="${user.US_OILEVEL >= 80 && user.US_OILEVEL < 90}">완벽한😍</c:when>
											        <c:when test="${user.US_OILEVEL >= 90 && user.US_OILEVEL <= 100}">환상적인🥰</c:when>
   												 </c:choose>
                                            </div>
                                        </div>
                                    </div>
                                    <hr>
                                </div>
                                <div id="intro-text">
                                    <c:if test="${user.US_ID eq sessionScope.US_ID}">
                                        <button id="edit-button" type="button">소개글 수정</button>
                                    </c:if>
                                    <p>${user.US_TEXT}</p>
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
                                        <c:if test="${user.US_ID eq sessionScope.US_ID}">
                                            <li class="nav-item"><a class="nav-link" data-toggle="tab" href="#choice" role="tab">찜</a></li>
                                        </c:if>
                                    </ul>
                                </div>
                                <div class="tab-content" id="myTabContent">
                                    <div class="tab-pane fade show active" id="product" role="tabpanel">
                                        <div class="tab-single">
                                            <div class="row">
                                                <div class="col-12">
                                                    <div id="product-header">
                                                        <h5>상품 ${fn:length(myPD)}</h5>
                                                        <c:if test="${user.US_ID eq sessionScope.US_ID}">
                                                            <a href="product" class="cucumber-button">상품등록</a>
                                                        </c:if>
                                                    </div>
                                                    <hr>
                                                    <div class="product-grid">
                                                        <c:forEach var="product" items="${myPD}">
                                                            <c:if test="${product.PD_STATUS ne 'PDS04'}">
                                                                <div class="product-item container">
                                                                    <a href="productDetail?PD_IDX=${product.PD_IDX}">
                                                                        <img src="<%= request.getContextPath() %>/resources/upload/${product.image1}" alt="${product.PD_SUBJECT}" class="image">
                                                                        <c:if test="${product.PD_STATUS eq 'PDS02'}">
                                                                            <div class="overlay">예약 중</div>
                                                                        </c:if>
                                                                        <c:if test="${product.PD_STATUS eq 'PDS03'}">
                                                                            <div class="overlay">판매 완료</div>
                                                                        </c:if>
                                                                        <div class="product-details">
                                                                            <p>${product.PD_SUBJECT}</p>
                                                                            <div class="product-info-bottom">
                                                                                <div class="product-price">${product.PD_PRICE} 원</div>
                                                                                <div class="product-date">${product.timeAgo}</div>
                                                                            </div>
                                                                        </div>
                                                                    </a>
                                                                </div>
                                                            </c:if>
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
                                                        <h5>상점 후기 ${fn:length(reviews)}</h5>
                                                    </div>
                                                    <hr>
                                                    <c:if test="${empty reviews}">
                                                        <div class="single-des">
                                                            <p>상점후기가 없습니다.</p>
                                                        </div>
                                                    </c:if>
                                                    <c:forEach var="review" items="${reviews}">
                                                        <div class="review-item">
                                                            <img src="${review.FROM_US_PROFILE}" alt="${review.FROM_US_ID}">
                                                            <div class="review-content">
                                                                <div>
                                                                    <strong>${review.FROM_US_ID}</strong>
                                                                    <div class="star-rating">
                                                                        <c:forEach var="i" begin="1" end="${review.RV_STAR}">
                                                                            <i class="fa fa-star"></i>
                                                                        </c:forEach>
                                                                        <c:forEach var="i" begin="${review.RV_STAR + 1}" end="5">
                                                                            <i class="fa fa-star-o"></i>
                                                                        </c:forEach>
                                                                    </div>
                                                                </div>
                                                                <div>
                                                                    <a href="productDetail?PD_IDX=${review.PD_IDX}">${review.PD_SUBJECT}</a>
                                                                </div>
                                                                <p>${review.RV_CONTENT}</p>
                                                                <div class="review-categories">
                                                                    <c:forEach var="category" items="${review.RV_CATEGORY_NAMES}">
                                                                        <span>${category}</span>
                                                                    </c:forEach>
                                                                </div>
                                                                <small>${review.RV_TIME}</small>
                                                            </div>
                                                        </div>
                                                        <hr>
                                                    </c:forEach>
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
        // 소개글 수정 버튼 클릭 시 편집 영역을 표시하고, 기존 텍스트를 텍스트 영역에 삽입
        document.getElementById("edit-button").addEventListener("click", function() {
            document.getElementById("intro-text").style.display = "none";
            document.getElementById("edit-area").style.display = "block";
            document.getElementById("intro-textarea").value = document.querySelector("#intro-text p").innerText;
        });

        // 소개글 확인 버튼 클릭 시 텍스트를 업데이트하고 편집 영역을 숨김
        document.getElementById("save-button").addEventListener("click", function() {
            const newText = document.getElementById("intro-textarea").value;

            $.ajax({
                url: 'editText',  // 소개글 저장을 위한 서버의 URL
                type: 'POST',      // 요청 타입
                data: { editText: newText }, // 전송할 데이터
                success: function(response) {
                    if (response.success) {
                        // 업데이트 성공 시, 소개글 텍스트 업데이트
                        document.querySelector("#intro-text p").innerText = newText;
                        document.getElementById("intro-text").style.display = "block";
                        document.getElementById("edit-area").style.display = "none";
                    } else {
                        alert('소개글 저장에 실패했습니다: ' + response.message);
                    }
                },
                error: function(xhr, status, error) {
                    console.log("AJAX 요청 오류: ", status, error);
                    alert('소개글 저장 중 오류가 발생했습니다.');
                }
            });
        });

        // 텍스트 영역에서 입력할 때 최대 4줄로 제한
        document.getElementById("intro-textarea").addEventListener("input", function() {
            const lines = this.value.split('\n');
            if (lines.length > 4) {
                this.value = lines.slice(0, 4).join('\n');
            }
        });

        // 프로필 사진 업로드 처리
        document.getElementById("profile-pic-input").addEventListener("change", function(event) {
            const file = event.target.files[0];
            if (file) {
                const formData = new FormData();
                formData.append('profilePic', file);

                $.ajax({
                    url: 'uploadProfilePic',  // 업로드할 서버의 URL
                    type: 'POST',             // 요청 타입
                    data: formData,           // 업로드할 데이터
                    processData: false,       // 파일 업로드이므로 데이터를 쿼리 스트링으로 변환하지 않음
                    contentType: false,       // 파일 업로드이므로 contentType 설정하지 않음
                    success: function(response) {
                        if (response.success) {
                            // 업로드 성공 시, 프로필 사진 업데이트
                            document.getElementById("profile-pic").src = response.imageUrl;
                        } else {
                            alert('이미지 업로드에 실패했습니다.');
                        }
                    },
                    error: function() {
                        alert('이미지 업로드 중 오류가 발생했습니다.');
                    }
                });
            }
        });
    </script>
</body>
</html>
