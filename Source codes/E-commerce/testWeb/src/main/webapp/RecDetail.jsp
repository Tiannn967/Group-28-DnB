<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Exploration Detail</title>
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
        
        #logout{
        	position: absolute;
        	right:0;
        }

		.container {
		    margin-top: 50px;
		    left: 50%;
		    transform: translateX(-50%);
		    position: absolute;
		    border-radius: 5px;
		    background-color: rgba(242, 242, 242, 0.5);
		    width: 90%;
		    height: auto;
		    display: flex;
		    flex-direction: column; /* 纵向排列 */
		    justify-content: center; /* 水平居中 */
		    align-items: center; /* 垂直居中 */
		}
		
		
        table {
            margin: 20px auto;
            border-collapse: collapse;
            width: 80%;
            max-width: 600px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        h1, h2 {
            margin-top: 20px;
            color: #333;
        }

        img {
            display: block;
            margin: 0 auto;
            max-width: 100%;
            height: auto;
        }

        th, td {
            padding: 10px;
            text-align: center;
            border: 1px solid #ccc;
        }

        th {
            background-color: #f2f2f2;
            font-weight: bold;
        }
    </style>
</head>
<body>
    <%@ page import="testWeb.vo.Detail" %>

    <%
        // 获取会话对象和相关属性
        HttpSession detailSession = request.getSession();
        Detail detl = (Detail) detailSession.getAttribute("detl");
        String a = "";
        String b = "";
        ArrayList<String[]> arr = new ArrayList<>();
        if (detl != null) {
            a = detl.getExpID();
            b = detl.getExpPath();
            arr = detl.getTreasure();
        }
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

	<div class="container">
	
	    <h1>Exploration ID: <%= a %></h1>
	
	    <div>
	        <img src="image/photo.png" alt="Photo">
	    </div>
	    
	    <h2>Exploration Path: <%= b %></h2>
	
	    <table>
	        <tr>
	            <th>Treasure Name</th>
	            <th>Treasure Position</th>
	        </tr>
	
	        <%
	            // 在循环中输出宝藏数据
	            for (String[] rowData : arr) {
	        %>
	        
	        <tr>
	            <% for (String data : rowData) { %>
	            <td><%= data %></td>
	            <% } %>
	        </tr>
	        
	        <%
	            }
	        %>
	    </table>
	</div>
</body>
</html>
