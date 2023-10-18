<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
  <title>Start Exploration</title>
</head>
<body>
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
        
        .container {
            margin-top: 0;
            margin:60px auto;
            border-radius: 5px;
            background-color: rgba(242,242,242,0.5);
            width: 90%;
            height:auto;
            display: flex;
            flex-direction: column;
            justify-content: center; /* 水平居中 */
        }
        
        .title {
            font-size: 24px;
            text-align: center;
            color: #000;
            margin-top: 10px;
        }        
        
        video {
            border: 1px solid #000;
            height: 36 vw;
            width: 64 vw;
        }
        
        #error-message {
            
            color:#FF0000;
            text-align: center;
        }
        
        .error-container {
            text-align:center;
        }
        
        .end-exploration-button {
            margin: 0 auto;
            width: 35%;
            padding: 10px;
            font-size: 16px;
            color: #FFFFFF;
            background-color: #C709F7;
            border-radius: 20px 20px 20px 20px;
            border: none;
            cursor: pointer;
        }
        
       .end-exploration-button:hover {
       background-color: #6809F7; 
}
        
    </style>

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
    
    <div class="container">
        <div class="title">Exploring...</div>
        <div><p id="error-message"></p></div>
        <img id="video-stream" src="http://127.0.0.1:5000/video_feed" alt="Video Stream">
        
        <!-- 新增按钮 -->
        <button class="end-exploration-button" onclick="endExploration()">End Exploration</button>
    </div>
    
    <script>
        var videoStream = document.getElementById('video-stream');
        var errorMessage = document.getElementById('error-message');

        videoStream.addEventListener('error', function() {
            errorMessage.textContent = 'Video Connection Fail';
            videoStream.style.display = 'none';
        });

        function endExploration() {
            alert("Exploration Over");
        }
    </script>

</body>
</html>
