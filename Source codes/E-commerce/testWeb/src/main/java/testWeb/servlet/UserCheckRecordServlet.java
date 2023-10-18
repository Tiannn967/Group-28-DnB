package testWeb.servlet;

import testWeb.vo.*;
import testWeb.dao.impl.*;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class UserCheckRecordServlet extends HttpServlet {
	
	public void doPost (HttpServletRequest req, HttpServletResponse res) 
		throws IOException, ServletException{
		UserRecord userRec = new UserRecord();
		userRec.setUsername(req.getParameter("username"));
		int[] tot = new int[4];
		
		RecordDAOimpl dao = new RecordDAOimpl();
		
		try {
			userRec = dao.queryRecord(userRec);
			tot = dao.queryTotTres(userRec);
			
			HttpSession userRecSession = req.getSession();
			userRecSession.setAttribute("des",userRec);
			userRecSession.setAttribute("tot", tot);
			
			System.out.print("this message is from CheckRecord Servlet: ");
			System.out.println(tot[0] + tot[1] + tot[2]);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		res.sendRedirect("./RecInfo.jsp");
	}

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		doPost (req,resp);
	}
}
