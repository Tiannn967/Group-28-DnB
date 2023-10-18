package testWeb.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import testWeb.vo.*;
import testWeb.dao.*;
import testWeb.dao.impl.*;
import testWeb.db.DBConnect;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;


//此部分调用UserDAOimpl以及UserInfo，接受了来自按钮“个人信息”的请求，并且建立了在psnInfo中可以读取的session
public class UserStartExpServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
			String username = req.getParameter("username");//读取请求中的username
			
			System.out.println("Message from UserStartExpServlet");
			
//			try {
//	            // 启动第一个Python脚本（基于Flask的Web服务）
//	            ProcessBuilder webApp1 = new ProcessBuilder("python", "D:/mini_proj/path_server.py");
//	            Process process1 = webApp1.start();
//
//	            // 启动第二个Python脚本（基于Flask的Web服务）
//	            ProcessBuilder webApp2 = new ProcessBuilder("python", "D:/mini_proj/video_server.py");
//	            Process process2 = webApp2.start();
//
//	            // 启动第三个Python脚本（传感器数据收集）
//	            ProcessBuilder sensorDataCollector = new ProcessBuilder("python", "D:/mini_proj/tracker.py");
//	            Process process3 = sensorDataCollector.start();
//
//	            System.out.println("Running Programs");
//	            
//	        } catch (IOException e) {
//	            e.printStackTrace();
//	        }
			
			try {
			    DBConnect dbConnect = new DBConnect();
			    Connection conn = dbConnect.getConnection();

			    // Use PreparedStatement.RETURN_GENERATED_KEYS to retrieve generated keys
			    PreparedStatement stmt = conn.prepareStatement("INSERT INTO explore (userName,exploreStart,exploreEnd,ExploreMap) VALUES (?, ?, ?, ?)", PreparedStatement.RETURN_GENERATED_KEYS);

			    LocalDateTime currentDateTime = LocalDateTime.now();
			    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			    String formattedDateTime = currentDateTime.format(formatter);

			    System.out.println(username);
			    stmt.setString(1, username);
			    stmt.setString(2, formattedDateTime);
			    stmt.setString(3, null);
			    stmt.setString(4, null);
			    stmt.executeUpdate();
			    
			    System.out.println("Message before Generated Keys01");

			    // Retrieve generated keys
			    ResultSet generatedKeys = stmt.getGeneratedKeys();
			    System.out.println("Message before Generated Keys02");
			    System.out.println(generatedKeys);
			    if (generatedKeys.next()) {
			    	System.out.println("Message from generatedKeys");
			        int exploreNo = generatedKeys.getInt(1);
			        // Now you have the exploreNo, you can send it to the frontend
			        // For example, you can set it in the session
			        HttpSession session = req.getSession();
			        session.setAttribute("exploreNo", exploreNo);
			    }

			} catch (Exception e) {
			    e.printStackTrace();
			}

			res.sendRedirect("./StartExp.jsp");
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req,resp);
	}
	
}
