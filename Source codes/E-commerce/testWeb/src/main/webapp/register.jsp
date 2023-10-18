<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
<head>
    <title>Register</title>
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
        
        h1 {
            font-size: 24px;
            text-align: center;
            color: #000;
            margin-top: 0px;
        }
        
        .message {
            text-align: center;
            color: red;
            margin-bottom: 10px;
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
        .form-actions input[type="reset"] {
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
        .form-actions input[type="reset"]:hover {
            background-color: #6809F7;
        }
    </style>
    <script>
        function addCheck() {
            var username = document.getElementById("username").value;
            var password = document.getElementById("password").value;
            var newword = document.getElementById("newword").value;
            if (username === "") {
                alert("Username cannot be empty!");
                document.getElementById("username").focus();
                return false;
            }
            if (password === "") {
                alert("Password cannot be empty!");
                document.getElementById("password").focus();
                return false;
            }
            if (password !== newword) {
                alert("The two passwords you entered do not match!");
                document.getElementById("newword").focus();
                return false;
            }
        }
        
        function validate() {
            var flag = addCheck();
            if (flag === false)
                return false;
            return true;
        }
    </script>
</head>
<body>
    <div id="top-bar">Group 28</div>
    <div class="container-slogan">
    <h2 class="slogan">REGISTER</h2>  
        <form action="./UserReg" method="post" onsubmit="return validate()">
            <table class="form-table">
            
                <tr>
                    <th style="color: white;">Username:</th>
                    <td>
                        <input type="text" name="username" id="username" value="Enter up to 16 characters" maxlength="16"
                            onfocus="if(this.value == 'Enter up to 16 characters') this.value =''">
                    </td>
                </tr>                      
                <tr>
                    <th style="color: white;">Enter Password:</th>
                    <td>
                        <input type="text" name="password" id="password" value="Enter up to 16 characters" maxlength="20"
                            onfocus="if(this.value == 'Enter up to 16 characters') this.value =''">
                    </td>
                </tr>     
                <tr>
                    <th style="color: white;">Confirm Password:</th>
                    <td>
                        <input type="text" name="newword" id="newword" value="Enter up to 16 characters" maxlength="20"
                            onfocus="if(this.value == 'Enter up to 16 characters') this.value =''">
                    </td>
                </tr>
                <tr>
                    <th style="color: white;">Enter RobotNo:</th>
                    <td>
                        <input type="text" name="RobotNo" id="robNo" value="Enter up to 20 characters" maxlength="20"
                            onfocus="if(this.value == 'Enter up to 20 characters') this.value =''">
                    </td>
                </tr>
                
                <tr>
                    <th style="color: white;">Enter Robot Model:</th>
                    <td>
                        <input type="text" name="robotModel" id="robM" value="Enter up to 20 characters" maxlength="20"
                            onfocus="if(this.value == 'Enter up to 20 characters') this.value =''">
                    </td>
                </tr>   
                             
                <tr>
                    <th style="color: white;">Enter Robot Description:</th>
                    <td>
                        <input type="text" name="robotDes" id="robDes" value="Enter up to 20 characters" maxlength="20"
                            onfocus="if(this.value == 'Enter up to 20 characters') this.value =''">
                    </td>
                </tr> 
                                
                <tr>
                    <td colspan="2" align="center">
                        <div class="form-actions">
                            <input type="submit" value="Register" style="width: 160px; height: 45px;">
                            <input type="reset" value="Repositioning"  style="width: 160px; height: 45px;">
                        </div>
                    </td>
                </tr>
            </table>
        </form>
    </div>
</body>
</html>
