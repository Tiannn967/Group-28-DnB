<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Details</title>
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
       		margin-top: 50px;
       		
        	left:50%;
        	transform: translateX(-50%);
        	
        	position: absolute;
        	border-radius: 5px;
        	background-color: rgba(242,242,242,0.5);
  			width: 90%;
  			height:auto;
  			display: flex;
  			justify-content: center; /* 水平居中 */
        }
        
        .user-details{
        	display: flex;
  			justify-content: center;
        }
        
        .button-contanier{
        	position:relative;
        	margin-top: 30px;
        	width: 30vw;
        	display: flex;
  			justify-content: center;
        }
        
        
        .buttons{
        	position:relative;
        	margin: 0 auto;
            width: 30vw;
            padding: 10px;
            font-size: 16px;
            color: #FFFFFF;
            background-color: #C709F7;
            border-radius: 20px 20px 20px 20px;
            border: none;
            cursor: pointer;
        }
        
        .title {
        	position:absolute;
            font-size: 24px;
            text-align: center;
            color: #000;
            margin-top: 10px;
        }
        
        .user-details {
            width: 100%;
            margin-top: 50px;
            margin-bottom: 20px;
            border-collapse: collapse;
        }        
        
        .user-details strong {
            text-align: right;
            display: inline-block;
            width: 200px;
        }
        
        table {
		    margin-top: 20px;
		    font-size: 16px;
		}
		
		th, td {
		    padding: 10px;
		}
        
        input[type="text"] {
		    background-color: transparent;
		    border: none;
		}
		
		textarea {
		    background-color: transparent;
		    border: none;
		    resize: none;
		}
		
		textarea, input[type="text"] {
		    font-family: Arial;
		}
        
        #logout{
        	position: absolute;
        	right:0;
        }
        
        .hide{
        	display:none;
        }
    </style>
</head>
<body>
    <%
    HttpSession userDetailSession = request.getSession();
    String a = (String)userDetailSession.getAttribute("username");
    String b = (String)userDetailSession.getAttribute("robotNo");
    String c = (String)userDetailSession.getAttribute("robotModel");
    String d = (String)userDetailSession.getAttribute("robotDes");
    %>
    
    <div id="top-bar-menu">
        <div class="menu">
            <div class="menu-item">
                <a href="./welcome.jsp">Start Exploring</a>
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
    
    <br/>
	<div class="container">
	    <div class="title">User Details</div>
	    <div class="user-details">
	        <form action="./UserUpdate" method="POST">
	            <table>
	                <tr>
	                    <th>User name</th>
	                    <td><input type="text" name="username" value="<%= a %>" readonly></td>
	                </tr>
	                <tr>
	                    <th>Robot number</th>
	                    <td class="editable"><input type="text" name="RobotNo" value="<%= b %>" readonly></td>
	                </tr>
	                <tr>
	                    <th>Robot model</th>
	                    <td class="editable"><input type="text" name="robotModel" value="<%= c %>" readonly></td>
	                </tr>
					<tr>
					    <th>Robot description</th>
					    <td class="editable"><textarea name="robotDes" readonly><%= d %></textarea></td>
					</tr>
	            </table>
	            <div class="button-contanier">
		            <div class="edit-button">
		                <button type="button" onclick="editUserDetails()" class="buttons">Edit</button>
		            </div>
		            <div class="confirm-button hide">
		            	<button type="submit" class="buttons">Confirm</button>
		            </div>
	            </div>
	        </form>
	    </div>
	</div>
	
	<script>
	    function editUserDetails() {
	        // Hide the edit button
	        document.querySelector('.edit-button').style.display = 'none';
	
	        // Show the confirm button
	        document.querySelector('.confirm-button').style.display = 'block';
	
	        // Enable editing of user details
	        document.querySelectorAll('.editable textarea, .editable input').forEach(function(element) {
	            element.removeAttribute('readonly');
	        });
	    }
	</script>

</body>
</html>