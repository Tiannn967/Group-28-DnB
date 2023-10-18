package testWeb.servlet;

import java.io.IOException;

import testWeb.vo.*;
import testWeb.dao.*;
import testWeb.dao.impl.*;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

//此部分调用UserDAOimpl以及UserInfo，接受了来自按钮“个人信息”的请求，并且建立了在psnInfo中可以读取的session
public class UserCheckInfoServlet extends HttpServlet {

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) 
			throws ServletException, IOException {
			UserInfo userinfo = new UserInfo();
			userinfo.setUsername(req.getParameter("username"));//读取请求中的username
			UserInfo out = new UserInfo();
			
			UserDAO dao = new UserDAOimpl();
			try {
				out = dao.queryUser(userinfo);//使用username检索个人信息
				
				//使用检索的数据创建session
				HttpSession userDetailSession = req.getSession();
				userDetailSession.setAttribute("robotNo",userinfo.getRobotNo());
				userDetailSession.setAttribute("robotModel",userinfo.getRobotModel());
				userDetailSession.setAttribute("robotDes",userinfo.getRobotDes());
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			res.sendRedirect("./psnInfo.jsp");
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req,resp);
	}
	
}
