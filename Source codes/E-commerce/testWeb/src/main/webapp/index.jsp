<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <style>
        body {
            font-family: Arial;
            background-image: url(image/loginBackGround.png);
            background-repeat: no-repeat;
			background-size: 100% 100%;
			background-attachment: fixed;
			margin:0;
			overflow-y: auto;
			position: relative;
        }
        
       	#top-bar {
       		z-index: 9999;
       		padding-left:3vw;
		    position: fixed;
		    top: 0;
		    left: 0;
		    width: 100%;
		    height: 5vh;
		    background-color: #C709F7;
		    color: #FFFFFF;
		    font-size: 16px;
		    display: flex;
		    align-items: center;
		}

        .container-slogan {
        	position: absolute;
        	font-weight: bold;
            width: 60%;
            height: 50%;
            
            left:20%;
			top: 50%;
			transform: translateY(-50%);
            padding: 20px;
            background-color: rgba(242,242,242,0);
            /*border: 1px solid #ccc;*/
            border-radius: 5px;
        }

        .slogan {
        
            font-size: 50px;
            text-align: left;
            color: rgba(242,242,242,1);
            margin-bottom: 0;
        }

        .button-group {
            display: flex;
            justify-content: center;
            margin-top: 15%;
        }

        .button {
        	margin: 0 15%;
            width: 35%;
            padding: 10px;
            font-size: 16px;
            color: #FFFFFF;
            background-color: #C709F7;
            border-radius: 20px 20px 20px 20px;
            border: none;
            cursor: pointer;
        }

        .button:hover {
            background-color: #6809F7;
        }
        
        .container-intro {
            position: absolute;
            top: 95vh;
            left: 5vw;
            width: 90vw;
            height: auto;
            background-color: rgba(242,242,242,0);
            padding: 0;
        }
        
        #info-tag{
        	display: flex;
        	align-items: center;
        	justify-content: center;
        	width: 10vw;
        	height: 5vh;
        	font-size: 16px;
        	color: #FFFFFF;
        	background-color: #C709F7;
        	padding: 0;
        	border: none;
        	border-radius: 20px 20px 0px 0px;
        	
        }
        
        .container-words {
        	padding:0;
        	height:auto;
        	width:100%;
       		front-size:16px;
       		background-color:rgba(242,242,242,0.5);
       		border-radius: 0px 30px 30px 30px;
        }
        
    	#back-to-top-btn {
		    position: fixed;
		    right: 10px;
		    bottom: 20vh;
		    width: 5vh;
		    height: 5vh;
		    border-radius: 25%;
		    background-color: rgba(242,242,242,0.5);
		    color: #fff;
		    font-size: 24px;
		    display: none;
    	}
    </style>
</head>
<body>
	<div id="top-bar">Group 28</div>
    <div class="container-slogan">
        <div class="slogan">Unlock the maze</div>
        <div class="slogan">Discover the treasure</div>
        <div class="slogan">Intelligent robot lead your adventure</div>
        <div class="button-group">
            <input type="button" value="Login" class="button" onclick="window.location.href='login.jsp'">
            <input type="button" value="Register" class="button" onclick="window.location.href='register.jsp'">
        </div>
    </div>
    
    <div class="container-intro">
    	<div id = "info-tag">About Us</div>
    	<div class = "container-words">
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    		<span>hi</span><br>
    	</div>
    </div>
    
    <button id="back-to-top-btn">&#8593;</button>

  	<script>
	    window.addEventListener('scroll', function() {
		    var button = document.getElementById('back-to-top-btn');
		    if (window.pageYOffset > 0) {
		    	button.style.display = 'block';
		    } else {
		    	button.style.display = 'none';
		    }
	    });
	
	    document.getElementById('back-to-top-btn').addEventListener('click', function() {
	    	window.scrollTo({ top: 0, behavior: 'smooth' });
	    });
  	</script>
  
</body>
</html>
