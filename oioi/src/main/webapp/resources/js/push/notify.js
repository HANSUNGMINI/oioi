var socket = null;
        var userId = document.body.getAttribute('data-user-id');

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
                console.log('받은 메시지 파싱전 ' + event.data);
                var response = JSON.parse(event.data);

                console.log('받은 메시지 파싱후 ' + response);
                displayNotification(response);
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

        // 페이지가 로드될 때 사용자 ID로 웹소켓에 연결
        window.onload = function() {
            connect();
        };