<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>실패</title>
    <!-- SweetAlert CSS -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.min.css">
</head>
<body>
    <!-- SweetAlert JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    <script>
        Swal.fire({
            title: '실패!',
            text: "${msg}",
            icon: 'error',
            confirmButtonText: 'OK'
        }).then((result) => {
        	
            if (result.isConfirmed) {
            	if("${isClose}" == '') {
            		window.opener.location.reload(); // 부모창 리프레시
            		if("${hrefOpener}" == '') {
            			window.opener.location.href="${targetURL}";
            		}
            		window.close();
            	}
            	
                if ("${targetURL}" == "") {
                    history.back();
                } else {
                    location.href = "${targetURL}";
                }
            }
        });
    </script>
</body>
</html>