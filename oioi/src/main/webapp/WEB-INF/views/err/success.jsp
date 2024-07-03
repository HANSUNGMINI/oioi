<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>성공</title>
    <!-- SweetAlert CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
    <script src = "${pageContext.request.contextPath}/resources/js/jquery-3.7.1.js"></script>
</head>
<body>
    <!-- SweetAlert JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    <script>
    	const msg = "${msg}";
    	
		if("${notify}" == "true"){
			// ~~~~~~~~~~~~~~~김유신~~~~~~~~~~~~~~~~~~
			let socket = new WebSocket('ws://localhost:8081/oi/push');
			socket.onopen = function (){
				if(msg == "신고 접수 완료되었습니다") {
// 					socket.send("checkReport");
					socket.send(toJsonString("toAdmin", "checkReport"));
				} else if (msg == "등록성공! 1차검수가 완료되면 상품을 보내주세요."){
// 					socket.send("checkApd");
					socket.send(toJsonString("toAdmin", "checkApd"));
				}
			};
		};
		
		function toJsonString(type, msg){
			let data = {
				type : type,
				msg : msg
			};
			
			return JSON.stringify(data);
		}
		
		
		
    
        Swal.fire({
            title: '성공!',
            text: msg,
            icon: 'success',
            confirmButtonText: 'OK'
        }).then((result) => {
            if (result.isConfirmed) {
                if ("${targetURL}" == "") {
                    history.back();
                } else {
                    location.href = "${targetURL}";
                }
            }
            
            if("${isClose}" == "true") {
        		if("${targetURL}"!= null) {
        			window.opener.location.href = "${targetURL}";
					window.opener.opener.location.reload();
        		}
        		window.close();
        	} 
        });
    </script>
</body>
</html>