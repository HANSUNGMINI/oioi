<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html lang="zxx">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>내 상점 관리</title>
    <link href="https://fonts.googleapis.com/css?family=Poppins:200i,300,300i,400,400i,500,500i,600,600i,700,700i,800,800i,900,900i&display=swap" rel="stylesheet">
    <script src="https://kit.fontawesome.com/ef42a902c7.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/bootstrap.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/magnific-popup.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/font-awesome.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/jquery.fancybox.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/themify-icons.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/niceselect.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/animate.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/flex-slider.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/owl-carousel.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/slicknav.min.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reset.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/responsive.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/color.css">
    <style>
        /* 추가적인 스타일 */ 
        .btn-custom {
            border: none;
            border-radius: 25px;
            padding: 10px 20px;
            font-size: 14px;
            font-weight: bold;
            color: white;
            text-transform: uppercase;
            cursor: pointer;
            transition: background 0.3s ease;
            margin-bottom: 5px;
            margin-right: 5px;
        }

        .btn-edit {
            background: linear-gradient(145deg, #5cbf34, #7ed957);
        }

        .btn-edit:hover {
            background: linear-gradient(145deg, #4da82e, #6fcd4f);
        }

        .btn-delete {
            background: linear-gradient(145deg, #ff4e50, #ff6e7f);
        }

        .btn-delete:hover {
            background: linear-gradient(145deg, #e43a45, #ff5f6d);
        }

        .btn-up {
            background: linear-gradient(145deg, #36d1dc, #5b86e5);
        }

        .btn-up:hover {
            background: linear-gradient(145deg, #3494e6, #ec6ead);
        }

        .table-responsive {
            overflow: visible;
        }

        .table th, .table td {
            text-align: center;
            vertical-align: middle;
        }

        .table img {
            max-width: 50px;
        }
    </style>
</head>
<body class="js">
<header><jsp:include page="../INC/top.jsp"></jsp:include></header>
<section class="shop single section">
    <div class="container">
        <div class="row">
            <div class="col-12">
                <div id="custom-border">
                    <div class="product-des">
                        <h4>${user.US_NICK} 님의 상품 관리</h4>
                    </div>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">사진</th>
                                    <th scope="col">판매상태</th>
                                    <th scope="col">상품명</th>
                                    <th scope="col">가격</th>
                                    <th scope="col">찜</th>
                                    <th scope="col">최근수정일</th>
                                    <th scope="col">기능</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="product" items="${myPD}">
                                    <c:if test="${product.PD_STATUS ne 'PDS04'}">
                                        <tr>
                                            <td><img src="<%= request.getContextPath() %>/resources/upload/${product.image1}" alt="${product.PD_SUBJECT}" width="50"></td>
                                            <td>
                                                <select class="form-control" onchange="updatePDS('${product.PD_IDX}', this.value)">
                                                    <c:forEach var="code" items="${code}">
                                                        <option value="${code.code}" <c:if test="${code.code eq product.PD_STATUS}">selected</c:if>>${code.value}</option>
                                                    </c:forEach>
                                                </select>
                                            </td>
                                            <td>${product.PD_SUBJECT}</td>
                                            <td>${product.PD_PRICE} 원</td>
                                            <td>${product.PD_LIKES}</td>
                                            <td>${product.PD_UPDATED_DATE}</td>
                                            <td>
                                                <button class="btn btn-custom btn-up" onclick="productUp('${product.PD_IDX}')">끌어올리기</button>
                                                <button class="btn btn-custom btn-edit" onclick="location.href='productModify?PD_IDX=${product.PD_IDX}'">수정</button>
                                                <button class="btn btn-custom btn-delete" onclick="deleteProduct('${product.PD_IDX}')">삭제</button>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:forEach>
                                <c:if test="${empty myPD}">
                                    <tr>
                                        <td colspan="7" class="text-center">등록된 상품이 없습니다.</td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>
<footer><jsp:include page="../INC/bottom.jsp"></jsp:include></footer>
<script type="text/javascript">
    function updatePDS(pdId, status) {
        $.ajax({
            url: 'updatePDS',
            type: 'POST',
            data: { pdId: pdId, status: status }, 
            success: function(response){
                alert('상태가 성공적으로 업데이트되었습니다.');
                location.reload();  // 페이지 새로고침
            },
            error: function(error) {
                console.error("Error updating product status:", error);
                alert('상태 업데이트에 실패하였습니다.');
            }
        });
    }

    function deleteProduct(pdId) {
        if (confirm('정말로 이 상품을 삭제하시겠습니까?')) {
            $.ajax({
                url: 'deleteProduct',
                type: 'POST',
                data: { pdId: pdId },
                success: function(response){
                    alert('상품이 성공적으로 삭제되었습니다.');
                    location.reload();  // 페이지 새로고침
                },
                error: function(error) {
                    console.error("Error deleting product:", error);
                    alert('상품 삭제에 실패하였습니다.');
                }
            });
        }
    }
    
    function productUp(pdId){
    	if(confirm("상품을 끌어올리시겠습니까?")){
    		$.ajax({
    			url: 'productUp',
    			type: 'POST',
    			data: {pdId : pdId},
    			success: function(){
					location.reload();  // 페이지 새로고침
    			} 
    			
    		});
    	}
    }
</script>

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
</body>
</html>
