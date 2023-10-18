package testWeb.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import testWeb.dao.impl.RegisterDAOimpl;
import testWeb.dao.impl.UserDAOimpl;
import testWeb.vo.UserInfo;

public class UserEditServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        System.out.println("message form Register Servlet");
        String user = new String(request.getParameter("username").getBytes("ISO-8859-1"), "UTF-8");
        String robNo = new String(request.getParameter("RobotNo").getBytes("ISO-8859-1"), "UTF-8");
        String robM = new String(request.getParameter("robotModel").getBytes("ISO-8859-1"), "UTF-8");
        String robDes = new String(request.getParameter("robotDes").getBytes("ISO-8859-1"), "UTF-8");

        System.out.println(user +"  "+ robNo +"  "+ robM +"  "+ robDes);
        
        UserDAOimpl userDao = new UserDAOimpl();
        
        UserInfo tmpUser = new UserInfo(user, "", robNo, robM, robDes);
        boolean isSuccess = false;
		try {
			isSuccess = userDao.updateUser(tmpUser);
		} catch (Exception e) {

			e.printStackTrace();
		}
        
        if (isSuccess) {
        	// 更新HttpSession中的个人信息
        	HttpSession userDetailSession = request.getSession();
        	userDetailSession.setAttribute("username", user);
        	userDetailSession.setAttribute("robotNo", robNo);
        	userDetailSession.setAttribute("robotModel", robM);
        	userDetailSession.setAttribute("robotDes", robDes);
            out.println("<script language='javascript'>alert('Edition successful!');window.location.href='psnInfo.jsp';</script>");
        } else {
            out.println("<script language='javascript'>alert('Edition failed!');window.location.href='psnInfo.jsp';</script>");
        }
    }
}

