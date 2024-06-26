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
</head>
<body>
    <!-- SweetAlert JS -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
    <script>
        Swal.fire({
            title: '성공!',
            text: "${msg}",
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