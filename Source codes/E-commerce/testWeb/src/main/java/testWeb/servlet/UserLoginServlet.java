package testWeb.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import testWeb.dao.UserDAO;
import testWeb.dao.impl.UserDAOimpl;
import testWeb.vo.UserInfo;

public class UserLoginServlet extends HttpServlet {

    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws IOException, ServletException {
        UserInfo userinfo = new UserInfo();
        userinfo.setUsername(req.getParameter("username"));
        userinfo.setPassword(req.getParameter("password"));

        System.out.println(userinfo.getUsername() + userinfo.getPassword());

        UserDAO dao = new UserDAOimpl();
        int flag = 0;
        try {
            flag = dao.queryByUserInfo(userinfo);
        } catch (Exception e) {
            e.printStackTrace();
        }

        if (flag == 1) {
            HttpSession session = req.getSession();
            session.setAttribute("username", userinfo.getUsername());
            res.sendRedirect("./welcome.jsp");
        } else {
            req.setAttribute("message", "Username does not exist or password is wrong!");
            req.getRequestDispatcher("/login.jsp").forward(req, res);
        }
    }
}
