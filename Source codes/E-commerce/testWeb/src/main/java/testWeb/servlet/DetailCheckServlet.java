package testWeb.servlet;

import testWeb.vo.*;
import testWeb.dao.impl.*;
import testWeb.libFiles.*;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class DetailCheckServlet extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		this.doPost(req, resp);
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse res) throws ServletException, IOException {
		Detail detl = new Detail();
		detl.setExpID(req.getParameter("expID"));
		
		
		
		DetailDAOimpl dao = new DetailDAOimpl();
		
		System.out.println("check Exp:" + detl.getExpID());
		
		try {
			detl = dao.queryDetail(detl);
			
			System.out.println("Sample1: " + detl.getTreasure().get(1)[0]);
			HttpSession detailSession = req.getSession();
			detailSession.setAttribute("detl", detl);
			
		} catch (Exception e) {
			e.printStackTrace();
		} 
		
		res.sendRedirect("./RecDetail.jsp");
	}
	
}
