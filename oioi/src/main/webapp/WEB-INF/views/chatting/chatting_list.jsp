<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>채팅 목록</title>
<meta name="viewport" content="width=device-width, heigth=device-width, user-scalable=no, initial-scale=1">
<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<style type="text/css">

* { margin: 0px; padding: 0px; }
body {
  background: #f0f1f2;
  font:12px "Open Sans", sans-serif; 
}
#view-code{
  color:#89a2b5;    
  opacity:0.7;
  font-size:14px;
  text-transform:uppercase;
  font-weight:700;
  text-decoration:none;
  position:absolute;top:660px;
  left:50%;margin-left:-50px;
  z-index:200;
}
#view-code:hover{opacity:1;}
#chatbox{
  width:290px;
  background:#fff;
  border-radius:6px;
  overflow:hidden;
  height:484px;
  position:absolute;
  top:100px;
  left:50%;
  margin-left:-155px;
}

#friendslist{
  position:absolute;
  top:0;
  left:0;
  width:290px;
  height:484px;
}
#topmenu{
  height:69px;
  width:290px;
  border-bottom:1px solid #d8dfe3;  
}
#topmenu span{
  float:left; 
  width: 96px;
    height: 70px;
    background: url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/top-menu.png") -3px -118px no-repeat;
}
#topmenu span.friends{margin-bottom:-1px;}
#topmenu span.chats{background-position:-95px 25px; cursor:pointer;}
#topmenu span.chats:hover{background-position:-95px -46px; cursor:pointer;}
#topmenu span.history{background-position:-190px 24px; cursor:pointer;}
#topmenu span.history:hover{background-position:-190px -47px; cursor:pointer;}
.friend{
  height:70px;
  border-bottom:1px solid #e7ebee;    
  position:relative;
}
.friend:hover{
  background:#f1f4f6;
  cursor:pointer;
}
.friend img{
  width:40px;
  border-radius:50%;
  margin:15px;
  float:left;
}
.floatingImg{
  width:40px;
  border-radius:50%;
  position:absolute;
  top:0;
  left:12px;
  border:3px solid #fff;
}
.friend p{
  padding:15px 0 0 0;     
  float:left;
  width:220px;
}
.friend p strong{
  font-weight:600;
  font-size:15px;
  color:#597a96;  

}
.friend p span{
  font-size:13px;
  font-weight:400;
  color:#aab8c2;
}
.friend .status{
  background:#26c281;
  border-radius:50%;  
  width:9px;
  height:9px;
  position:absolute;
  top:31px;
  right:17px;
}
.friend .status.away{background:#ffce54;}
.friend .status.inactive{background:#eaeef0;}
#search{
  background:#e3e9ed url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/search.png") -11px 0 no-repeat;
  height:60px;
  width:290px;
  position:absolute;
  bottom:0;
  left:0;
}
#searchfield{
  background:#e3e9ed;
  margin:21px 0 0 55px;
  border:none;
  padding:0;
  font-size:14px;
  font-family:"Open Sans", sans-serif; 
  font-weight:400px;
  color:#8198ac;
}
#searchfield:focus{
   outline: 0;
}
#chatview{
  width:290px;
  height:484px;
  position:absolute;
  top:0;
  left:0; 
  display:none;
  background:#fff;
}
#profile{
  height:153px;
  overflow:hidden;
  text-align:center;
  color:#fff;
}
.p1 #profile{
  background:#fff url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/timeline1.png") 0 0 no-repeat;
}
#profile .avatar{
  width:68px;
  border:3px solid #fff;
  margin:23px 0 0;
  border-radius:50%;
}
#profile  p{
  font-weight:600;
  font-size:15px;
  margin:118px 0 -1px;
  opacity:0;
  -webkit-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
     -moz-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
      -ms-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
       -o-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
          transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000); 
}
#profile  p.animate{
  margin-top:97px;
  opacity:1;
  -webkit-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
     -moz-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
      -ms-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
       -o-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
          transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000); 
}
#profile  span{
  font-weight:400;
  font-size:11px;
}
#chat-messages{
  opacity:0;
  margin-top:30px;
  width:290px;
  height:270px;
  overflow-y:scroll;  
  overflow-x:hidden;
  padding-right: 20px;
  -webkit-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
     -moz-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
      -ms-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
       -o-transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
          transition: all 200ms cubic-bezier(0.000, 0.995, 0.990, 1.000);
}
#chat-messages.animate{
  opacity:1;
  margin-top:0;
}
#chat-messages label{
  color:#aab8c2;
  font-weight:600;
  font-size:12px;
  text-align:center;
  margin:15px 0;
  width:290px;
  display:block;  
}
#chat-messages div.message{
  padding:0 0 30px 58px;
  clear:both;
  margin-bottom:45px;
}
#chat-messages div.message.right{
    padding: 0 58px 30px 0;
    margin-right: -19px;
    margin-left: 19px;
}
#chat-messages .message img{
    float: left;
    margin-left: -38px;
    border-radius: 50%;
    width: 30px;
    margin-top: 12px;
}
#chat-messages div.message.right img{
  float: right; 
    margin-left: 0;
  margin-right: -38px;  
}
.message .bubble{ 
  background:#f0f4f7;
  font-size:13px;
  font-weight:600;
  padding:12px 13px;
  border-radius:5px 5px 5px 0px;
  color:#8495a3;
  position:relative;
  float:left;
}
#chat-messages div.message.right .bubble{
  float:right;
  border-radius:5px 5px 0px 5px ;
}
.bubble .corner{
  background:url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/bubble-corner.png") 0 0 no-repeat;
  position:absolute;
  width:7px;
  height:7px;
  left:-5px;
  bottom:0;
}
div.message.right .corner{
  background:url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/bubble-cornerR.png") 0 0 no-repeat;
  left:auto;
  right:-5px;
}
.bubble span{
    color: #aab8c2;
    font-size: 11px;
    position: absolute;
    right: 0;
    bottom: -22px;
}
#sendmessage{
  height:60px;
  border-top:1px solid #e7ebee; 
  position:absolute;
  bottom:0;
  right:0px;
  width:290px;
  background:#fff;
  padding-bottm:50px;
}
#sendmessage input{
  border
}
#sendmessage input{
  background:#fff;
  margin:21px 0 0 21px;
  border:none;
  padding:0;
  font-size:14px;
  font-family:"Open Sans", sans-serif; 
  font-weight:400px;
  color:#aab8c2;
}
#sendmessage input:focus{
   outline: 0;
}
#sendmessage button{
  background:#fff url("https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/send.png") 0 -41px no-repeat;
  width:30px;
  height:30px;
  position:absolute;
  right: 15px;
  top: 23px;
  border:none;
}
#sendmessage button:hover{
  cursor:pointer;
  background-position: 0 0 ;
}
#sendmessage button:focus{
   outline: 0;   
}

#close{
  position:absolute;
  top: 8px; 
  opacity:0.8;
  right: 10px;
  width:20px;
  height:20px;
  cursor:pointer;
}
#close:hover{
  opacity:1;
}
.cx, .cy{
  background:#fff;
  position:absolute;
  width:0px;
  top:15px;
  right:15px;
  height:3px;
  -webkit-transition: all 250ms ease-in-out;
     -moz-transition: all 250ms ease-in-out;
    -ms-transition: all 250ms ease-in-out;
     -o-transition: all 250ms ease-in-out;
      transition: all 250ms ease-in-out;
}
.cx.s1, .cy.s1{ 
  right:0;  
  width:20px; 
  -webkit-transition: all 100ms ease-out;
     -moz-transition: all 100ms ease-out;
    -ms-transition: all 100ms ease-out;
     -o-transition: all 100ms ease-out;
      transition: all 100ms ease-out;
}
.cy.s2{ 
  -ms-transform: rotate(50deg); 
  -webkit-transform: rotate(50deg); 
  transform: rotate(50deg);    
  -webkit-transition: all 100ms ease-out;
     -moz-transition: all 100ms ease-out;
    -ms-transition: all 100ms ease-out;
     -o-transition: all 100ms ease-out;
      transition: all 100ms ease-out;
}
.cy.s3{ 
  -ms-transform: rotate(45deg); 
  -webkit-transform: rotate(45deg); 
  transform: rotate(45deg);    
  -webkit-transition: all 100ms ease-out;
     -moz-transition: all 100ms ease-out;
    -ms-transition: all 100ms ease-out;
     -o-transition: all 100ms ease-out;
      transition: all 100ms ease-out;
}
.cx.s1{ 
  right:0;  
  width:20px; 
  -webkit-transition: all 100ms ease-out;
     -moz-transition: all 100ms ease-out;
    -ms-transition: all 100ms ease-out;
     -o-transition: all 100ms ease-out;
      transition: all 100ms ease-out;
}
.cx.s2{ 
  -ms-transform: rotate(140deg); 
  -webkit-transform: rotate(140deg); 
  transform: rotate(140deg);     
  -webkit-transition: all 100ms ease-out;
     -moz-transition: all 100ms ease-out;
    -ms-transition: all 100ease-out;
     -o-transition: all 100ms ease-out;
      transition: all 100ms ease-out;
}
.cx.s3{ 
  -ms-transform: rotate(135deg); 
  -webkit-transform: rotate(135deg); 
  transform: rotate(135deg);     
  -webkit-transition: all 100ease-out;
     -moz-transition: all 100ms ease-out;
    -ms-transition: all 100ms ease-out;
     -o-transition: all 100ms ease-out;
      transition: all 100ms ease-out;
}
#chatview, #sendmessage { 
overflow:hidden; 
border-radius:6px; 
}

/* 	*{ */
/* 	  box-sizing:border-box; */
/* 	} */
/* 	body{ */
/* 	  background-color:#abd9e9; */
/* 	  font-family:Arial; */
/* 	} */
/* 	#container{ */
/* 	  width:750px; */
/* 	  height:800px; */
/* 	  background:#eff3f7; */
/* 	  margin:0 auto; */
/* 	  font-size:0; */
/* 	  border-radius:5px; */
/* 	  overflow:hidden; */
/* 	} */
/* 	aside{ */
/* 	  width:260px; */
/* 	  height:800px; */
/* 	  background-color:#3b3e49; */
/* 	  display:inline-block; */
/* 	  font-size:15px; */
/* 	  vertical-align:top; */
/* 	} */
/* 	main{ */
/* 	  width:490px; */
/* 	  height:800px; */
/* 	  display:inline-block; */
/* 	  font-size:15px; */
/* 	  vertical-align:top; */
/* 	} */
	
/* 	aside header{ */
/* 	  padding:30px 20px; */
/* 	} */
/* 	aside input{ */
/* 	  width:100%; */
/* 	  height:50px; */
/* 	  line-height:50px; */
/* 	  padding:0 50px 0 20px; */
/* 	  background-color:#5e616a; */
/* 	  border:none; */
/* 	  border-radius:3px; */
/* 	  color:#fff; */
/* 	  background-image:url(https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_search.png); */
/* 	  background-repeat:no-repeat; */
/* 	  background-position:170px; */
/* 	  background-size:40px; */
/* 	} */
/* 	aside input::placeholder{ */
/* 	  color:#fff; */
/* 	} */
/* 	aside ul{ */
/* 	  padding-left:0; */
/* 	  margin:0; */
/* 	  list-style-type:none; */
/* 	  overflow-y:scroll; */
/* 	  height:690px; */
/* 	} */
/* 	aside li{ */
/* 	  padding:10px 0; */
/* 	} */
/* 	aside li:hover{ */
/* 	  background-color:#5e616a; */
/* 	} */
/* 	h2,h3{ */
/* 	  margin:0; */
/* 	} */
/* 	aside li img{ */
/* 	  border-radius:50%; */
/* 	  margin-left:20px; */
/* 	  margin-right:8px; */
/* 	} */
/* 	aside li div{ */
/* 	  display:inline-block; */
/* 	  vertical-align:top; */
/* 	  margin-top:12px; */
/* 	} */
/* 	aside li h2{ */
/* 	  font-size:14px; */
/* 	  color:#fff; */
/* 	  font-weight:normal; */
/* 	  margin-bottom:5px; */
/* 	} */
/* 	aside li h3{ */
/* 	  font-size:12px; */
/* 	  color:#7e818a; */
/* 	  font-weight:normal; */
/* 	} */
	
/* 	.status{ */
/* 	  width:8px; */
/* 	  height:8px; */
/* 	  border-radius:50%; */
/* 	  display:inline-block; */
/* 	  margin-right:7px; */
/* 	} */
/* 	.green{ */
/* 	  background-color:#58b666; */
/* 	} */
/* 	.orange{ */
/* 	  background-color:#ff725d; */
/* 	} */
/* 	.blue{ */
/* 	  background-color:#6fbced; */
/* 	  margin-right:0; */
/* 	  margin-left:7px; */
/* 	} */
	
/* 	main header{ */
/* 	  height:110px; */
/* 	  padding:30px 20px 30px 40px; */
/* 	} */
/* 	main header > *{ */
/* 	  display:inline-block; */
/* 	  vertical-align:top; */
/* 	} */
/* 	main header img:first-child{ */
/* 	  border-radius:50%; */
/* 	} */
/* 	main header img:last-child{ */
/* 	  width:24px; */
/* 	  margin-top:8px; */
/* 	} */
/* 	main header div{ */
/* 	  margin-left:10px; */
/* 	  margin-right:145px; */
/* 	} */
/* 	main header h2{ */
/* 	  font-size:16px; */
/* 	  margin-bottom:5px; */
/* 	} */
/* 	main header h3{ */
/* 	  font-size:14px; */
/* 	  font-weight:normal; */
/* 	  color:#7e818a; */
/* 	} */
	
/* 	#chat{ */
/* 	  padding-left:0; */
/* 	  margin:0; */
/* 	  list-style-type:none; */
/* 	  overflow-y:scroll; */
/* 	  height:535px; */
/* 	  border-top:2px solid #fff; */
/* 	  border-bottom:2px solid #fff; */
/* 	} */
/* 	#chat li{ */
/* 	  padding:10px 30px; */
/* 	} */
/* 	#chat h2,#chat h3{ */
/* 	  display:inline-block; */
/* 	  font-size:13px; */
/* 	  font-weight:normal; */
/* 	} */
/* 	#chat h3{ */
/* 	  color:#bbb; */
/* 	} */
/* 	#chat .entete{ */
/* 	  margin-bottom:5px; */
/* 	} */
/* 	#chat .message{ */
/* 	  padding:20px; */
/* 	  color:#fff; */
/* 	  line-height:25px; */
/* 	  max-width:90%; */
/* 	  display:inline-block; */
/* 	  text-align:left; */
/* 	  border-radius:5px; */
/* 	} */
/* 	#chat .me{ */
/* 	  text-align:right; */
/* 	} */
/* 	#chat .you .message{ */
/* 	  background-color:#58b666; */
/* 	} */
/* 	#chat .me .message{ */
/* 	  background-color:#6fbced; */
/* 	} */
/* 	#chat .triangle{ */
/* 	  width: 0; */
/* 	  height: 0; */
/* 	  border-style: solid; */
/* 	  border-width: 0 10px 10px 10px; */
/* 	} */
/* 	#chat .you .triangle{ */
/* 	    border-color: transparent transparent #58b666 transparent; */
/* 	    margin-left:15px; */
/* 	} */
/* 	#chat .me .triangle{ */
/* 	    border-color: transparent transparent #6fbced transparent; */
/* 	    margin-left:375px; */
/* 	} */
	
/* 	main footer{ */
/* 	  height:155px; */
/* 	  padding:20px 30px 10px 20px; */
/* 	} */
/* 	main footer textarea{ */
/* 	  resize:none; */
/* 	  border:none; */
/* 	  display:block; */
/* 	  width:100%; */
/* 	  height:80px; */
/* 	  border-radius:3px; */
/* 	  padding:20px; */
/* 	  font-size:13px; */
/* 	  margin-bottom:13px; */
/* 	} */
/* 	main footer textarea::placeholder{ */
/* 	  color:#ddd; */
/* 	} */
/* 	main footer img{ */
/* 	  height:30px; */
/* 	  cursor:pointer; */
/* 	} */
/* 	main footer a{ */
/* 	  text-decoration:none; */
/* 	  text-transform:uppercase; */
/* 	  font-weight:bold; */
/* 	  color:#6fbced; */
/* 	  vertical-align:top; */
/* 	  margin-left:333px; */
/* 	  margin-top:5px; */
/* 	  display:inline-block; */
/* 	} */
</style>

<script type="text/javascript">
$(document).ready(function(){
	  
	  var preloadbg = document.createElement("img");
	  preloadbg.src = "https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/timeline1.png";
	  
	  $("#searchfield").focus(function(){
	    if($(this).val() == "Search contacts..."){
	      $(this).val("");
	    }
	  });
	  $("#searchfield").focusout(function(){
	    if($(this).val() == ""){
	      $(this).val("Search contacts...");
	      
	    }
	  });
	  
	  $("#sendmessage input").focus(function(){
	    if($(this).val() == "Send message..."){
	      $(this).val("");
	    }
	  });
	  $("#sendmessage input").focusout(function(){
	    if($(this).val() == ""){
	      $(this).val("Send message...");
	      
	    }
	  });
	    
	  
	  $(".friend").each(function(){   
	    $(this).click(function(){
	      var childOffset = $(this).offset();
	      var parentOffset = $(this).parent().parent().offset();
	      var childTop = childOffset.top - parentOffset.top;
	      var clone = $(this).find('img').eq(0).clone();
	      var top = childTop+12+"px";
	      
	      $(clone).css({'top': top}).addClass("floatingImg").appendTo("#chatbox");                  
	      
	      setTimeout(function(){$("#profile p").addClass("animate");$("#profile").addClass("animate");}, 100);
	      setTimeout(function(){
	        $("#chat-messages").addClass("animate");
	        $('.cx, .cy').addClass('s1');
	        setTimeout(function(){$('.cx, .cy').addClass('s2');}, 100);
	        setTimeout(function(){$('.cx, .cy').addClass('s3');}, 200);     
	      }, 150);                            
	      
	      $('.floatingImg').animate({
	        'width': "68px",
	        'left':'108px',
	        'top':'20px'
	      }, 200);
	      
	      var name = $(this).find("p strong").html();
	      var email = $(this).find("p span").html();                            
	      $("#profile p").html(name);
	      $("#profile span").html(email);     
	      
	      $(".message").not(".right").find("img").attr("src", $(clone).attr("src"));                  
	      $('#friendslist').fadeOut();
	      $('#chatview').fadeIn();
	    
	      
	      $('#close').unbind("click").click(function(){       
	        $("#chat-messages, #profile, #profile p").removeClass("animate");
	        $('.cx, .cy').removeClass("s1 s2 s3");
	        $('.floatingImg').animate({
	          'width': "40px",
	          'top':top,
	          'left': '12px'
	        }, 200, function(){$('.floatingImg').remove()});        
	        
	        setTimeout(function(){
	          $('#chatview').fadeOut();
	          $('#friendslist').fadeIn();       
	        }, 50);
	      });
	      
	    });
	  });     
	});

</script>
</head>
<body>
	
<!-- 	<div id="container"> -->
<!--   <aside> -->
<!--     <header> -->
<!--       <input type="text" placeholder="search"> -->
<!--     </header> -->
<!--     <ul> -->
<!--       <li> -->
<!--         <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg" alt=""> -->
<!--         <div> -->
<!--           <h2>Prénom Nom</h2> -->
<!--           <h3> -->
<!--             <span class="status orange"></span> -->
<!--             offline -->
<!--           </h3> -->
<!--         </div> -->
<!--       </li> -->
<!--       <li> -->
<!--         <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_02.jpg" alt=""> -->
<!--         <div> -->
<!--           <h2>Prénom Nom</h2> -->
<!--           <h3> -->
<!--             <span class="status green"></span> -->
<!--             online -->
<!--           </h3> -->
<!--         </div> -->
<!--       </li> -->
<!--       <li> -->
<!--         <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_03.jpg" alt=""> -->
<!--         <div> -->
<!--           <h2>Prénom Nom</h2> -->
<!--           <h3> -->
<!--             <span class="status orange"></span> -->
<!--             offline -->
<!--           </h3> -->
<!--         </div> -->
<!--       </li> -->
<!--       <li> -->
<!--         <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_04.jpg" alt=""> -->
<!--         <div> -->
<!--           <h2>Prénom Nom</h2> -->
<!--           <h3> -->
<!--             <span class="status green"></span> -->
<!--             online -->
<!--           </h3> -->
<!--         </div> -->
<!--       </li> -->
<!--       <li> -->
<!--         <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_05.jpg" alt=""> -->
<!--         <div> -->
<!--           <h2>Prénom Nom</h2> -->
<!--           <h3> -->
<!--             <span class="status orange"></span> -->
<!--             offline -->
<!--           </h3> -->
<!--         </div> -->
<!--       </li> -->
<!--       <li> -->
<!--         <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_06.jpg" alt=""> -->
<!--         <div> -->
<!--           <h2>Prénom Nom</h2> -->
<!--           <h3> -->
<!--             <span class="status green"></span> -->
<!--             online -->
<!--           </h3> -->
<!--         </div> -->
<!--       </li> -->
<!--       <li> -->
<!--         <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_07.jpg" alt=""> -->
<!--         <div> -->
<!--           <h2>Prénom Nom</h2> -->
<!--           <h3> -->
<!--             <span class="status green"></span> -->
<!--             online -->
<!--           </h3> -->
<!--         </div> -->
<!--       </li> -->
<!--       <li> -->
<!--         <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_08.jpg" alt=""> -->
<!--         <div> -->
<!--           <h2>Prénom Nom</h2> -->
<!--           <h3> -->
<!--             <span class="status green"></span> -->
<!--             online -->
<!--           </h3> -->
<!--         </div> -->
<!--       </li> -->
<!--       <li> -->
<!--         <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_09.jpg" alt=""> -->
<!--         <div> -->
<!--           <h2>Prénom Nom</h2> -->
<!--           <h3> -->
<!--             <span class="status green"></span> -->
<!--             online -->
<!--           </h3> -->
<!--         </div> -->
<!--       </li> -->
<!--       <li> -->
<!--         <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_10.jpg" alt=""> -->
<!--         <div> -->
<!--           <h2>Prénom Nom</h2> -->
<!--           <h3> -->
<!--             <span class="status orange"></span> -->
<!--             offline -->
<!--           </h3> -->
<!--         </div> -->
<!--       </li> -->
<!--     </ul> -->
<!--   </aside> -->
<!--   <main> -->
<!--     <header> -->
<!--       <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/chat_avatar_01.jpg" alt=""> -->
<!--       <div> -->
<!--         <h2>Chat with Vincent Porter</h2> -->
<!--         <h3>already 1902 messages</h3> -->
<!--       </div> -->
<!--       <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_star.png" alt=""> -->
<!--     </header> -->
<!--     <ul id="chat"> -->
<!--       <li class="you"> -->
<!--         <div class="entete"> -->
<!--           <span class="status green"></span> -->
<!--           <h2>Vincent</h2> -->
<!--           <h3>10:12AM, Today</h3> -->
<!--         </div> -->
<!--         <div class="triangle"></div> -->
<!--         <div class="message"> -->
<!--           Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. -->
<!--         </div> -->
<!--       </li> -->
<!--       <li class="me"> -->
<!--         <div class="entete"> -->
<!--           <h3>10:12AM, Today</h3> -->
<!--           <h2>Vincent</h2> -->
<!--           <span class="status blue"></span> -->
<!--         </div> -->
<!--         <div class="triangle"></div> -->
<!--         <div class="message"> -->
<!--           Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. -->
<!--         </div> -->
<!--       </li> -->
<!--       <li class="me"> -->
<!--         <div class="entete"> -->
<!--           <h3>10:12AM, Today</h3> -->
<!--           <h2>Vincent</h2> -->
<!--           <span class="status blue"></span> -->
<!--         </div> -->
<!--         <div class="triangle"></div> -->
<!--         <div class="message"> -->
<!--           OK -->
<!--         </div> -->
<!--       </li> -->
<!--       <li class="you"> -->
<!--         <div class="entete"> -->
<!--           <span class="status green"></span> -->
<!--           <h2>Vincent</h2> -->
<!--           <h3>10:12AM, Today</h3> -->
<!--         </div> -->
<!--         <div class="triangle"></div> -->
<!--         <div class="message"> -->
<!--           Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. -->
<!--         </div> -->
<!--       </li> -->
<!--       <li class="me"> -->
<!--         <div class="entete"> -->
<!--           <h3>10:12AM, Today</h3> -->
<!--           <h2>Vincent</h2> -->
<!--           <span class="status blue"></span> -->
<!--         </div> -->
<!--         <div class="triangle"></div> -->
<!--         <div class="message"> -->
<!--           Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. -->
<!--         </div> -->
<!--       </li> -->
<!--       <li class="me"> -->
<!--         <div class="entete"> -->
<!--           <h3>10:12AM, Today</h3> -->
<!--           <h2>Vincent</h2> -->
<!--           <span class="status blue"></span> -->
<!--         </div> -->
<!--         <div class="triangle"></div> -->
<!--         <div class="message"> -->
<!--           OK -->
<!--         </div> -->
<!--       </li> -->
<!--     </ul> -->
<!--     <footer> -->
<!--       <textarea placeholder="Type your message"></textarea> -->
<!--       <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_picture.png" alt=""> -->
<!--       <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/1940306/ico_file.png" alt=""> -->
<!--       <a href="#">Send</a> -->
<!--     </footer> -->
<!--   </main> -->
<!-- </div> -->

<link href='https://fonts.googleapis.com/css?family=Open+Sans:400,600,700' rel='stylesheet' type='text/css'>

<a id="view-code" href="https://codepen.io/virgilpana/pen/ZYZXgP" target="_blank">VIEW CODE</a>

<div id="chatbox">
  <div id="friendslist">
      <div id="topmenu">
          <span class="friends"></span>
            <span class="chats"></span>
            <span class="history"></span>
        </div>
        
        <div id="friends">
          <div class="friend">
              <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/1_copy.jpg" />
                <p>
                  <strong>Miro Badev</strong>
                  <span>mirobadev@gmail.com</span>
                </p>
                <div class="status available"></div>
            </div>
            
            <div class="friend">
              <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/2_copy.jpg" />
                <p>
                  <strong>Martin Joseph</strong>
                  <span>marjoseph@gmail.com</span>
                </p>
                <div class="status away"></div>
            </div>
            
            <div class="friend">
              <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/3_copy.jpg" />
                <p>
                  <strong>Tomas Kennedy</strong>
                  <span>tomaskennedy@gmail.com</span>
                </p>
                <div class="status inactive"></div>
            </div>
            
            <div class="friend">
              <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/4_copy.jpg" />
                <p>
                  <strong>Enrique Sutton</strong>
                  <span>enriquesutton@gmail.com</span>
                </p>
                <div class="status inactive"></div>
            </div>
            
            <div class="friend">
              <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/5_copy.jpg" />
                <p>
                <strong>  Darnell Strickland</strong>
                  <span>darnellstrickland@gmail.com</span>
                </p>
                <div class="status inactive"></div>
            </div>
            
            <div id="search">
              <input type="text" id="searchfield" value="Search contacts..." />
            </div>
            
        </div>                
        
    </div>  
    
    <div id="chatview" class="p1">      
        <div id="profile">

            <div id="close">
                <div class="cy"></div>
                <div class="cx"></div>
            </div>
            
            <p>Miro Badev</p>
            <span>miro@badev@gmail.com</span>
        </div>
        <div id="chat-messages">
          <label>Thursday 02</label>
            
            <div class="message">
              <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/1_copy.jpg" />
                <div class="bubble">
                  Really cool stuff!
                    <div class="corner"></div>
                    <span>3 min</span>
                </div>
            </div>
            
            <div class="message right">
              <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/2_copy.jpg" />
                <div class="bubble">
                  Can you share a link for the tutorial?
                    <div class="corner"></div>
                    <span>1 min</span>
                </div>
            </div>
            
            <div class="message">
              <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/1_copy.jpg" />
                <div class="bubble">
                  Yeah, hold on
                    <div class="corner"></div>
                    <span>Now</span>
                </div>
            </div>
            
            <div class="message right">
              <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/2_copy.jpg" />
                <div class="bubble">
                  Can you share a link for the tutorial?
                    <div class="corner"></div>
                    <span>1 min</span>
                </div>
            </div>
            
            <div class="message">
              <img src="https://s3-us-west-2.amazonaws.com/s.cdpn.io/245657/1_copy.jpg" />
                <div class="bubble">
                  Yeah, hold on
                    <div class="corner"></div>
                    <span>Now</span>
                </div>
            </div>
            
        </div>
      
        <div id="sendmessage">
          <input type="text" value="Send message..." />
            <button id="send"></button>
        </div>
    
    </div>        
</div>  
    
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
</body>
</html>