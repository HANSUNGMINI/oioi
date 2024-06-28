var socket = null;
	
function connect() {
    ws = new WebSocket("ws://localhost:8081/oi/replyEcho?APD_IDX=" + encodeURIComponent(apd_idx));
    var us_id = "${apdDetail.US_ID}";
    socket = ws;
    ws.onopen = function() {
        console.log('연결');
    };
    
    ws.onmessage = function(event) {
    	
    	console.log("판매자 : " + us_id);
    	
        console.log('받은 메세지 파싱전 ' + event.data);
        var response = JSON.parse(event.data);
        
        console.log('response.SESSION_SIZE : ' + response.SESSION_SIZE);
        
        
     	//접속자수표시
        var html ='';
        $('#sessionSize').empty().append(html);
        html += '<span>접속자 수 : <a style="margin-top: -1px;" class="cat">' +
        response.SESSION_SIZE+
        '명</a></span>';
        $('#sessionSize').append(html);
        
        
     	// 두번째 파싱
        var res;
        if (response.DATA) {
            res = JSON.parse(response.DATA);
        } else {
            console.error('DATA 필드가 존재하지 않습니다.');
            return;
        }

        console.log('받은 메세지 파싱후 ' + res);
        console.log('res.US_ID : ' + res.US_ID);
        console.log('res.APD_IDX : ' + res.APD_IDX);
        console.log('res.MSG : ' + res.MSG);
        
        console.log("session_id : " + session_id);
        
        
        $.ajax({
        	url : "saveMsg",
        	type : "post",
        	data : {
        		ACR_IDX : res.APD_IDX,
        		ACM_CONTENT : res.MSG,
        		ACM_USER : res.US_ID
        	},
        	dataType : "JSON",
        	success: function(res) {
                console.log('저장 성공' + res);
                console.log('저장 성공' + res.data.ACR_IDX);
                console.log('저장 성공' + res.data.ACM_USER);
                console.log('저장 성공' + res.data.ACM_CONTENT);
                console.log('저장 성공' + session_id);
              
              
              //세션아이디와 메세지 작성자가 일치하면 오른쪽 불일치면 왼쪽
	            var html ='';
	            if(session_id == res.data.ACM_USER){
	            	console.log("일치");
	            	html += '<li class="clearfix" class="chatViewMe">' + 
	                '<div class="message other-message float-right">' +
	                res.data.ACM_CONTENT +
	                '</div>' +
	           		'</li>';
	            	$('.chatView').append(html);
	            	$(".chatView").scrollTop($(".chatView")[0].scrollHeight);
	            }else {
	            	console.log("불일치");
	            	html += '<li class="clearfix" class="chatViewYou">' + 
	            	'<div class="message-avatar">' +
	            	'<img src="https://search.pstatic.net/common/?src=http%3A%2F%2Fshop1.phinf.naver.net%2F20231201_11%2F1701407251569KtFaW_JPEG%2F2577731462313581_1635528623.jpg&type=sc960_832" alt="">' +
	            	res.data.ACM_USER +
	            	'</div>' +
	                '<div class="message my-message">' +
	                res.data.ACM_CONTENT +
	                '</div>' +
	           		'</li>';
	            	$('.chatView').append(html);
	            	$(".chatView").scrollTop($(".chatView")[0].scrollHeight);
	            }
            }
        });
        
        
        
        
    };
    
    ws.onclose = function(event) {
        console.log('종료');
    };
    
    ws.onerror = function(error) {
        console.log('error: ' + error);
    };
}

window.onload = function() {
    connect();
};