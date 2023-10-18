<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Login</title>
    <style>
        body {
            font-family: Arial;
            background-image: url(image/workBackGround.png);
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
            text-align: center;
            color: rgba(242,242,242,1);
            margin-bottom: 0;
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
        
    	
    	.message {
            text-align: center;
            color: red;
            margin-bottom: 15px;
        }
    	
    	.form-table {
            width: 100%;
        }
        
        .form-table th {
            text-align: right;
            padding-right: 10px;
        }
        
        .form-table td {
            padding-left: 10px;
        }
        
        .form-actions {
            text-align: center;
            margin-top: 20px;
        }
        
        .form-group {
            text-align: center;
            color: rgba(242,242,242,1);
            margin-top: 20px;
        }
        
        .form-actions input[type="submit"],
        .form-actions input[type="button"] {
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
        
        
        .form-actions input[type="submit"]:hover,
        .form-actions input[type="button"]:hover {
            background-color: #6809F7;
        }
    	
    </style>
</head>
<body>  
   <header id="top-bar">Group 28</header>  
   <div class="container-slogan">  
        <h2 class="slogan">LOGIN</h2>  
        <form id="login-form" method="post" action="./login">  
            <div class="form-group">  
                <label for="username">Username:</label>  
                <input type="text" id="username" name="username" maxlength="16"  
                       onfocus="if(this.value == 'Please enter your username') this.value =''" >  
            </div>  
            <div class="form-group">  
                <label for="password">Password:</label>  
                <input type="password" id="password" name="password" maxlength="20" >  
            </div>  
            <div class="form-actions">  
                <input type="submit" value="Login" style="width: 160px; height: 45px;">  
                <input type="button" value="Back" onclick="window.location.href='index.jsp'" style="width: 160px; height: 45px;">  
            </div>  
        </form>  
        <p id="message" class="message">  
            ${message}  
        </p>  
    </div>  
</body>
</html>