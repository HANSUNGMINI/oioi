<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅방</title>
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/css/bootstrap.min.css" integrity="sha384-TX8t27EcRE3e/ihU7zmQxVncDAy5uIKz4rEkgIXeMed4M0jlfIDPvg6uqKI2xXr2" crossorigin="anonymous">

<!-- 아이콘 사용 -->
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
	<style type="text/css">
		
		.chat-app .chat {
		    margin-left: 280px;
		    border-left: 1px solid #eaeaea
		}
		
		.people-list .chat-list li {
		    padding: 10px 15px;
		    list-style: none;
		    border-radius: 3px
		}
		
		.people-list .chat-list li:hover {
		    background: #efefef;
		    cursor: pointer
		}
		
		.people-list .chat-list li.active {
		    background: #efefef
		}
		
		.people-list .chat-list li .name {
		    font-size: 15px
		}
		
		.people-list .chat-list img {
		    width: 45px;
		    border-radius: 50%
		}
		
		.people-list img {
		    float: left;
		    border-radius: 50%
		}
		
		.people-list .about {
		    float: left;
		    padding-left: 8px
		}
		
		.people-list .status {
		    color: #999;
		    font-size: 13px
		}
		
		.chat .chat-header {
		    padding: 15px 20px;
		    border-bottom: 2px solid #f4f7f6
		}
		
		.chat .chat-header img {
		    float: left;
		    border-radius: 40px;
		    width: 40px
		}
		
		.chat .chat-header .chat-about {
		    float: left;
		    padding-left: 10px
		}
		
		.chat .chat-history {
		    padding: 20px;
		    border-bottom: 2px solid #fff
		}
		
		.chat .chat-history ul {
		    padding: 0
		}
		
		.chat .chat-history ul li {
		    list-style: none;
		    margin-bottom: 30px
		}
		
		.chat .chat-history ul li:last-child {
		    margin-bottom: 0px
		}
		
		.chat .chat-history .message-data {
		    margin-bottom: 15px
		}
		
		.chat .chat-history .message-data img {
		    border-radius: 40px;
		    width: 40px
		}
		
		.chat .chat-history .message-data-time {
		    color: #434651;
		    padding-left: 6px
		}
		
		.chat .chat-history .message {
		    color: #444;
		    padding: 18px 20px;
		    line-height: 26px;
		    font-size: 16px;
		    border-radius: 7px;
		    display: inline-block;
		    position: relative
		}
		
		.chat .chat-history .message:after {
		    bottom: 100%;
		    left: 7%;
		    border: solid transparent;
		    content: " ";
		    height: 0;
		    width: 0;
		    position: absolute;
		    pointer-events: none;
		    border-bottom-color: #fff;
		    border-width: 10px;
		    margin-left: -10px
		}
		
		.chat .chat-history .my-message {
		    background: #efefef
		}
		
		.chat .chat-history .my-message:after {
		    bottom: 100%;
		    left: 30px;
		    border: solid transparent;
		    content: " ";
		    height: 0;
		    width: 0;
		    position: absolute;
		    pointer-events: none;
		    border-bottom-color: #efefef;
		    border-width: 10px;
		    margin-left: -10px
		}
		
		.chat .chat-history .other-message {
		    background: #e8f1f3;
		    text-align: right
		}
		
		.chat .chat-history .other-message:after {
		    border-bottom-color: #e8f1f3;
		    left: 93%
		}
		
		.chat .chat-message {
		    padding: 20px
		}
		
		.online,
		.offline,
		.me {
		    margin-right: 2px;
		    font-size: 8px;
		    vertical-align: middle
		}
		
		.online {
		    color: #86c541
		}
		
		.offline {
		    color: #e47297
		}
		
		.me {
		    color: #1d8ecd
		}
		
		.float-right {
		    float: right
		}
		
		.clearfix:after {
		    visibility: hidden;
		    display: block;
		    font-size: 0;
		    content: " ";
		    clear: both;
		    height: 0
		}
		
		body {
        background-color: #f4f7f6;
        margin: 0;
        padding: 0;
        height: 100vh;
        display: flex;
        flex-direction: column;
    }
    
    .chat {
        flex: 1;
        display: flex;
        flex-direction: column;
    }
    
    .chat-history {
        flex: 1;
        overflow-y: auto;
        padding: 20px;
        border-bottom: 2px solid #fff;
    }
    
    .chat-message {
        position: fixed;
        bottom: 0;
        width: 100%;
        background-color: #fff;
        padding: 20px;
        border-top: 2px solid #eaeaea;
        box-shadow: 0 -2px 5px rgba(0, 0, 0, 0.1);
    }
		
	@media only screen and (max-width: 767px) {
	    .chat-app .people-list {
	        width: 100%;
	        overflow-x: auto;
	        background: #fff;
	        left: -400px;
	        display: none
	    }
	    .chat-app .people-list.open {
	        left: 0
	    }
	    .chat-app .chat {
	        margin: 0
	    }
	    .chat-app .chat .chat-header {
	        border-radius: 0.55rem 0.55rem 0 0
	    }
	    .chat-app .chat-history {
	        height: 300px;
	        overflow-x: auto
	    }
	}
	
	@media only screen and (min-width: 768px) and (max-width: 992px) {
	    .chat-app .chat-list {
	        height: 650px;
	        overflow-x: auto
	    }
	    .chat-app .chat-history {
	        height: 600px;
	        overflow-x: auto
	    }
	}
	
	@media only screen and (min-device-width: 768px) and (max-device-width: 1024px) and (orientation: landscape) and (-webkit-min-device-pixel-ratio: 1) {
	    .chat-app .chat-list {
	        height: 500px;
	        overflow-x: auto
	    }
	    .chat-app .chat-history {
	        height: calc(100vh - 350px);
	        overflow-x: auto
	    }
	}
	</style>
</head>
<body>

	<%-- 뒤로가기 상단바 --%>
   	<div style="background-color:#34A853;">
          <a href="#" onClick="history.back()"><i class="bi bi-chevron-left" style="font-size: 2rem; color: white;"></i></a>
   	</div>
   	
   	
     <div class="chat">
     
     			<%-- 사용자 정보 및 신고 --%>
                <div class="chat-header clearfix">
                    <div class="row">
                        <div class="col-lg-6">
                        	<%-- 사용자 정보 --%>
                            <a href="javascript:void(0);" data-toggle="modal" data-target="#view_info">
                                <img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20231201_11%2F1701407251569KtFaW_JPEG%2F2577731462313581_1635528623.jpg&type=sc960_832" alt="avatar">
                            </a>
                            <div class="chat-about">
                                <h6 class="m-b-0">닉네임</h6>
                                <small>상품 : <a href="#">나이키 신발</a></small>
                            </div>
                        </div>
                        <div class="col-lg-6 hidden-sm text-right">
<!--                             <a href="javascript:void(0);" class="btn btn-outline-secondary"><i class="fa fa-camera"></i></a> -->
<!--                             <a href="javascript:void(0);" class="btn btn-outline-primary"><i class="fa fa-image"></i></a> -->
                            <a href="javascript:void(0);" class="btn btn-danger">신고</a>
                            <a href="javascript:void(0);" class="btn btn-success"><i class="bi bi-list"></i></a>
                        </div>
                        <hr>
                    </div>
                </div>
                
                <%-- 채팅 내역 --%>
                <div class="chat-history" >
                    <ul class="m-b-0">
                        
                        <li class="clearfix">
                            <div class="message-data text-right">
                            	<%-- 로그인 한 사람 이미지 --%>
                                <img src="https://img.freepik.com/premium-vector/cucumber-character-with-angry-emotions-grumpy-face-furious-eyes-arms-legs-person-with-irritated-expression-green-vegetable-emoticon-vector-flat-illustration_427567-3816.jpg?w=360" alt="avatar">
                            </div>
                            <div class="message other-message float-right"> Hi Aiden, how are you? How is the project coming along? </div><small class="message-data-time">10:10 AM, Today</small>
                        </li>
                        
                        <li class="clearfix">
                            <div class="message my-message">Are we meeting today?</div>
                            <small class="message-data-time" style="margin-bottom:-20px">10:10 AM, Today</small>                              
                        </li>
                                                       
                        <li class="clearfix">
                            <div class="message my-message">Project has been already finished and I have results to show you.</div><small class="message-data-time">10:10 AM, Today</small>
                        </li>
                        
                    </ul>
                </div>

                <%-- 메세지 전송 --%>
                <div class="chat-message clearfix" style="margin-bottom:0px">
                    <div class="input-group mb-0">
		                <%-- 전송란 --%>
                        <input type="text" class="form-control" placeholder="메세지를 입력하세요">                                    

                        <%-- 전송버튼 --%>
                        <div class="input-group-prepend">
                            <a class="input-group-text"><i class="bi bi-reply-fill"></i></a>
                        </div>
                    </div>
                </div>
            </div>
            
            <!-- 부트스트랩 -->
            <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js" integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.5.3/dist/js/bootstrap.min.js" integrity="sha384-w1Q4orYjBQndcko6MimVbzY0tgp4pWB4lZ7lr30WKz0vr/aWKhXdBNmNb5D92v7s" crossorigin="anonymous"></script>
</body>
</html>