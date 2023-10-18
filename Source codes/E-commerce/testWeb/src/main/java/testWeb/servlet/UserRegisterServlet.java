package testWeb.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import testWeb.dao.impl.RegisterDAOimpl;
import testWeb.vo.UserInfo;

public class UserRegisterServlet extends HttpServlet {
    
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        
        System.out.println("message form Register Servlet");
        String user = new String(request.getParameter("username").getBytes("ISO-8859-1"), "UTF-8");
        String pwd = request.getParameter("password");
        String robNo = new String(request.getParameter("RobotNo").getBytes("ISO-8859-1"), "UTF-8");
        String robM = new String(request.getParameter("robotModel").getBytes("ISO-8859-1"), "UTF-8");
        String robDes = new String(request.getParameter("robotDes").getBytes("ISO-8859-1"), "UTF-8");

        System.out.println(user +"  "+ pwd +"  "+ robNo +"  "+ robM +"  "+ robDes);
        
        RegisterDAOimpl userDao = new RegisterDAOimpl();
        
        if (userDao.isUserExist(user)) {
            out.println("<script language='javascript'>alert('This user already exists, please re-register!');window.location.href='register.jsp';</script>");
        } else {
            UserInfo newUser = new UserInfo(user, pwd, robNo, robM, robDes);
            boolean isSuccess = userDao.addUser(newUser);
            
            if (isSuccess) {
                out.println("<script language='javascript'>alert('User registration successful!');window.location.href='index.jsp';</script>");
            } else {
                out.println("<script language='javascript'>alert('User registration failed!');window.location.href='register.jsp';</script>");
            }
        }
    }
}

