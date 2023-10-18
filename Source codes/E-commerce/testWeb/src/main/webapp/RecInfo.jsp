<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Exploration Record</title>
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
        
        .title {
        	position:absolute;
            font-size: 24px;
            text-align: center;
            color: #000;
            margin-top: 10px;
        }
        
        .chart-container {
		    width: 90%;
		    height:400px;
		    margin:60px auto;
		    padding-top:30px;
		    text-align: center;
		    background-color: rgba(242,242,242,0.5);
		    border-radius: 5px;
		}
        
        .table-container {
       		margin-top: 0;
       		margin:60px auto;
        	border-radius: 5px;
        	background-color: rgba(242,242,242,0.5);
  			width: 90%;
  			height:auto;
  			display: flex;
  			justify-content: center; /* 水平居中 */
        }
        
        table {
            width: 100%;
            margin-top: 50px;
            margin-bottom: 20px;
            border-collapse: collapse;
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
        
        .btn-container {
            text-align: center;
        }
        
        .btn {
            display: inline-block;
            padding: 5px 10px;
            background-color: #ADD8E6;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
            transition: background-color 0.3s ease;
            text-decoration: none;
        }
        
        .btn:hover {
            background-color: #0066CC;
        }
        
        
        #myChart {
        	height: 400px;
        	width:100%;
  			display: flex;
  			justify-content: center; /* 水平居中 */
        }
    </style>
</head>
<body>
    
    <%-- 获取探索记录数据 --%>
    <%@ page import="testWeb.vo.UserRecord" %>
    <%@ page import="java.util.ArrayList" %>
    <% 
    	UserRecord userRec = (UserRecord) session.getAttribute("des");
    	int[] tot = (int[]) session.getAttribute("tot");
    	
		//System.out.print("this message is from CheckRecord Servlet: ");
		//System.out.println(tot[1] + tot[2] + tot[3] + tot[4]);
    %>
    
    <!--  <input type="hidden" id="myVariableValue" value="<%= tot %>">-->
    
    <%-- 显示探索记录 --%>
    
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
       
	<div class="chart-container">
	    <canvas id="myChart"></canvas>
	</div>
	
	<script>
	    // 已知的数据
	    //var data = document.getElementById('myVariableValue').value;
	    var data = [<%= tot[0] %>,<%= tot[1] %>,<%= tot[2] %>];
	    
	    var labels = ['A', 'B', 'C'];
	    var yAxisLabel = '数目';
	
	    // 获取Canvas元素
	    var canvas = document.getElementById('myChart');
	    var ctx = canvas.getContext('2d');
	    var parentWidth = canvas.parentNode.offsetWidth;
	
	    // 提高Canvas分辨率
	    var dpr = window.devicePixelRatio || 2;
	    var rect = canvas.getBoundingClientRect();
	    canvas.width = rect.width * dpr;
	    canvas.height = rect.height * dpr;
	    ctx.scale(dpr, dpr);
	
	    //计算数据
	    var numBars = data.length;
	    var totalBarWidth = parentWidth*0.9;
	    var totalSpacing = totalBarWidth * 0.1;
	    var barWidth = totalBarWidth/6;
	    var barSpacing = totalBarWidth/6;
	    var startX = totalBarWidth/12;
	    var startY = 320;
	    
	    // 绘制坐标轴
	    ctx.beginPath();
	    ctx.moveTo(startX-20, 320);
	    ctx.lineTo(startX+totalBarWidth*11/12, 320);
	    ctx.moveTo(startX-20, 320);
	    ctx.lineTo(startX-20, 20);
	    ctx.font = '24px Arial';
	    ctx.fillText(yAxisLabel, 60, 20);
	    ctx.stroke();
	    
	    var maxHeight = 300; // 设置高度上限
	
	    for (var i = 0; i < data.length; i++) {
	        var barHeight = data[i] * 3; // 高度提高3倍
	        if (barHeight > maxHeight) {
	            barHeight = maxHeight;
	        }
	        var x = startX + (barWidth + barSpacing) * i;
	        var y = startY - barHeight;
	        ctx.fillStyle = 'blue';
	        ctx.fillRect(x, y, barWidth, barHeight);
	        
	        // 标注数字
	        ctx.fillStyle = 'black';
	        ctx.font = '24px Arial';
	        ctx.fillText(data[i], x, y - 20);
	        
	        // 标注横轴标签
	        ctx.fillStyle = 'black';
	        ctx.font = '24px Arial';
	        ctx.fillText(labels[i], x + barWidth/2 - 20, startY + 40);
	    }
	</script>

    
    <div class="table-container">
    	<div class="title">Exploration Record</div>
	    <table>
	        <tr>
	            <th>Exploration ID</th>
	            <th>Start Time</th>
	            <th>End Time</th>
	            <th>Treasure Number</th>
	            <th>Details</th>
	        </tr>
	        <% 
	        	for (int i = 0; i < userRec.getRecs().size(); i++) { 
	        %>
	        <tr>
	            <td><%= ((Object[]) userRec.getRecs().get(i))[0] %></td>
	            <td><%= ((Object[]) userRec.getRecs().get(i))[1] %></td>
	            <td><%= ((Object[]) userRec.getRecs().get(i))[2] %></td>
	            <td><%= ((Object[]) userRec.getRecs().get(i))[3] %></td>
	            <td class="btn-container">
	                <a href="./CheckDet?expID=<%= ((Object[]) userRec.getRecs().get(i))[0]%>>" class="btn" >Check</a>
	            </td>
	        </tr>
	        <% } %>
	    </table>
	</div>
	
</body>
</html>
