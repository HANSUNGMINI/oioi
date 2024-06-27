function connect() {
        if (!userId) {
            console.error('사용자 ID가 설정되지 않았습니다.');
            return;
        }

        // 사용자 ID를 쿼리 파라미터로 포함시켜 웹소켓 서버에 연결
        socket = new WebSocket(`ws://localhost:8081/oi/replyEcho?US_ID=${encodeURIComponent(userId)}`);

        socket.onopen = function() {
            console.log('연결');
        };

        socket.onmessage = function(event) {
            console.log('받은 메세지 파싱전 ' + event.data);
            var response = JSON.parse(event.data);

            // 두번째 파싱
            var res;
            if (response.DATA) {
                res = JSON.parse(response.DATA);
            } else {
                console.error('DATA 필드가 존재하지 않습니다.');
                return;
            }

            console.log('받은 메세지 파싱후 ' + res);
            displayNotification(res);
        };

        socket.onclose = function(event) {
            console.log('종료');
        };

        socket.onerror = function(error) {
            console.log('error: ' + error);
        };
    }

    function displayNotification(notification) {
        const notificationList = document.getElementById('notification-list');
        const listItem = document.createElement('li');

        listItem.innerHTML = `
            <a class="cart-img" href="#"></a>
            <a href="#" class="remove" title="Remove this item"><i class="fa fa-remove"></i></a>
            <h4><a href="#">${notification.MSG}</a></h4>
        `;

        notificationList.appendChild(listItem);
        updateNotificationCount();
    }

    function updateNotificationCount() {
        const count = document.querySelectorAll('#notification-list li').length;
        document.querySelector('.total-count').textContent = count;
    }

    document.getElementById('clear-notifications').addEventListener('click', () => {
        const notificationList = document.getElementById('notification-list');
        notificationList.innerHTML = '';
        updateNotificationCount();
    });

    // 실제 로그인된 사용자 ID를 반환하는 함수
    function getLoggedInUserId() {
        // 서버에서 세션 정보로부터 사용자 ID를 가져오는 로직
        // 서버에서 사용자 ID를 클라이언트로 전달하는 방식으로 구현 (예: HTML 데이터 속성, AJAX 요청 등)
        return document.body.getAttribute('data-user-id'); // 서버가 설정한 데이터 속성
    }

    // 페이지가 로드될 때 사용자 ID로 웹소켓에 연결
    window.onload = function() {
        userId = getLoggedInUserId();
        connect();
    };