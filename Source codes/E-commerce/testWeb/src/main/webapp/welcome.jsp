<!DOCTYPE html>
<html>
<head>
    <style>
        body {
            font-family: Arial;
            background-image: url(image/workBackGround.png);
            background-repeat: no-repeat;
			background-size: 100% 100%;
			background-attachment: fixed;
			margin:0;
			padding:0;
			overflow-y: auto;
			position: relative;
        }

        #top-bar-menu {
        	z-index: 9999;
            background-color: #C709F7;
            height: 5vh;
        }

        .menu {
        	padding-left:3vw;
            display: flex;
            justify-content: flex-start;
            align-items: center;
            margin: 0;
        }

        .menu-item {
            margin-right: 10px;
        }

        .menu-item a {
            text-decoration: none;
            color: #333;
            padding: 10px;
            background-color: #C709F7;
            border-radius: 5px;
        }

        .menu-item a:hover {
            background-color: #6809F7;
            color: #fff;
        } 
        
        .welcome-container{
        	position:absolute;
        	top: 10vh;
        	left:3vw;
        }       
        
        .welcome-mes-1{
	        font-size: 50px;
            text-align: left;
            color: #000000;
            margin-bottom: 10px;
        }
        
        .welcome-mes-2{
        	font-size: 30px;
            text-align: left;
            color: #000000;
            margin-bottom: 20px;
        }

        .datetime {
        	position:absolute;
            font-size: 18px;
            text-align: left;
        }
        
        #logout{
        	position: absolute;
        	right:0;
        }
        
        .button {
        	margin-top:60px;
            width: 35%;
            padding: 10px;
            font-size: 16px;
            color: #FFFFFF;
            background-color: #C709F7;
            border-radius: 20px 20px 20px 20px;
            border: none;
            cursor: pointer;
        }
        
    </style>
</head>
<body>
    <div id="top-bar-menu">
        <div class="menu">
            <div class="menu-item">
                <a href="./StartExp.jsp">Start Exploring</a>
            </div>
            <div class="menu-item">
                <a href="./checkRec?username=<%=session.getAttribute("username") %>">Exploration Record</a>
            </div>
            <div class="menu-item">
                <a href="./checkPsn?username=<%=session.getAttribute("username") %>">User Information</a>
            </div>
            <div class="menu-item" id="logout">
            	<a href="./login.jsp">Logout</a>
        	</div>
        </div>
    </div>
    
    <div class="welcome-container">
	    <%String username = (String)session.getAttribute("username"); %>
	    <div class="welcome-mes-1">Welcome, <%= username %></div>
	    <div class="welcome-mes-2">Click on "Connect" button to start the adventure</div>
	    <div class="welcome-mes-2">Please make sure that the robot has been turned on</div>
	    <div class="datetime" id="datetime"></div>
	    <button class = "button" onclick="window.location.href='./StartExp.jsp'">Connect</button>
    </div>
    
    <script>
        function getCurrentDateTime() {
            var date = new Date();

            var options = { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' };
            var dateString = date.toLocaleDateString('en-US', options);

            var timeString = date.toLocaleTimeString('en-US', { hour: 'numeric', minute: 'numeric', second: 'numeric', hour12: true });

            return {
                date: dateString,
                time: timeString
            };
        }

        function updateDateTime() {
            var datetimeElement = document.getElementById('datetime');
            var currentDateTime = getCurrentDateTime();

            datetimeElement.innerHTML = currentDateTime.date + '<br>' + currentDateTime.time;
        }

        setInterval(updateDateTime, 1000);

        window.addEventListener('load', updateDateTime);
    </script>
</body>
</html>
