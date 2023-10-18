package testWeb.servlet;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import testWeb.db.DBConnect;
import javax.servlet.ServletContext;
import java.io.IOException;
import java.io.File;
import java.nio.file.Files;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;
import java.time.format.DateTimeFormatter;
import java.time.LocalDateTime;

public class EndExpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // 获取桌面上的"TU"文件夹路径
        String desktopPath = "D:\\mini_proj\\tmp\\tmp_pictures";
        File tuFolder = new File(desktopPath);
        System.out.println("message from EndExp 1");
        System.out.println(tuFolder.exists());
        System.out.println(tuFolder.isDirectory());
        String exploreNo = request.getParameter("exploreNo");
        System.out.println("Message From EndExpServlet:");
        System.out.println(exploreNo);
        System.out.println(request.getParameter("exploreNo"));
        
//        // 要停止的Python程序的源代码文件名
//        String[] targetPrograms = {"path_server.py", "tracker.py", "video_server.py"};
//
//        // 获取正在运行的所有进程
//        List<ProcessHandle> runningProcesses = ProcessHandle.allProcesses().toList();
//
//        // 遍历所有进程
//        for (ProcessHandle processHandle : runningProcesses) {
//            // 获取进程的信息
//            ProcessHandle.Info processInfo = processHandle.info();
//
//            // 判断进程是否是你要停止的Python程序
//            if (processInfo.command().isPresent()) {
//                String command = processInfo.command().get();
//                for (String targetProgram : targetPrograms) {
//                    if (command.contains(targetProgram)) {
//                        // 停止符合条件的Python程序
//                        processHandle.destroy();
//                        System.out.println("停止Python程序：" + targetProgram + "，进程ID：" + processHandle.pid());
//                    }
//                }
//            }
//        }
//        
        DBConnect dbConnect = new DBConnect();
        Connection conn2 = dbConnect.getConnection();
        PreparedStatement stmt2 = null;
		try {
			stmt2 = conn2.prepareStatement("UPDATE explore\r\n"
					+ "SET exploreEnd = ?\r\n"
					+ "WHERE exploreNo = ?;\r\n");
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
	    LocalDateTime currentDateTime = LocalDateTime.now();
	    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
	    String formattedDateTime = currentDateTime.format(formatter);
        
        
        try {
        	stmt2.setString(1, formattedDateTime);
			stmt2.setString(2, exploreNo);
			stmt2.executeUpdate();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        
        try {
			conn2.close();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
        
        
        if (tuFolder.exists() && tuFolder.isDirectory()) {
            // 遍历文件夹里的所有文件
            System.out.println("message from EndExp 2");
            DBConnect dbConnect1 = new DBConnect();
            Connection conn = dbConnect.getConnection();
            
            for (File file : tuFolder.listFiles()) {
             // 判断文件名是否包含 "key"
                if (file.isFile() && file.getName().contains("key")) {
                    // 获取文件名作为 treasureName
                    
                    try {                       
                        
                        // 在 treasure_found 表中插入记录
                        byte[] imageBytes = Files.readAllBytes(file.toPath());
                        PreparedStatement stmt = conn.prepareStatement("INSERT INTO treasure_found (treasureName,treasureImg) VALUES (?, ?)");
                        stmt.setString(1, "1");
                        stmt.setString(2, exploreNo);
                        stmt.setBytes(3, imageBytes);
                        stmt.executeUpdate();
                   

                        // 记录成功连接数据库的消息
                        ServletContext context = getServletContext();
                        context.log("成功连接到数据库！");
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                
             // 判断文件名是否包含 "book"
                if (file.isFile() && file.getName().contains("book")) {
                    // 获取文件名作为 treasureName
                    
                    try {                    
                        
                        // 在 treasure_found 表中插入记录
                        byte[] imageBytes = Files.readAllBytes(file.toPath());
                        PreparedStatement stmt = conn.prepareStatement("INSERT INTO treasure_found (treasureName,treasureImg) VALUES (?, ?)");
                        stmt.setString(1, "3");
                        stmt.setString(2, exploreNo);
                        stmt.setBytes(3, imageBytes);
                        stmt.executeUpdate();
                        

                        // 记录成功连接数据库的消息
                        ServletContext context = getServletContext();
                        context.log("成功连接到数据库！");
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }

                // 判断文件名是否包含 "cube"
                if (file.isFile() && file.getName().contains("cube")) {
                    // 获取文件名作为 treasureName
                    
                    try {
                     
                        // 在 treasure_found 表中插入记录
                        byte[] imageBytes = Files.readAllBytes(file.toPath());
                        PreparedStatement stmt = conn.prepareStatement("INSERT INTO treasure_found (treasureName,treasureImg) VALUES (?, ?)");
                        stmt.setString(1, "2");
                        stmt.setString(2, exploreNo);
                        stmt.setBytes(3, imageBytes);
                        stmt.executeUpdate();
                        
                        

                        // 记录成功连接数据库的消息
                        ServletContext context = getServletContext();
                        context.log("成功连接到数据库！");
                    } catch (SQLException e) {
                        e.printStackTrace();
                    }
                }
                try {
					conn.close();
				} catch (SQLException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}

            }
        }  
        
        response.sendRedirect("./CheckDet?");
    }
}
