package com.sbs.example.demo.servlet;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.sbs.example.demo.db.DBConnection;

@WebServlet("/s/article/list")
public class ArticleListServlet extends HttpServlet {
	public ArticleListServlet() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=utf-8");

		DBConnection dBConnection = new DBConnection("localhost", "sbsst", "sbs123414", "blog", 3306);
		dBConnection.connect();

		List<Map<String, Object>> articleRows = dBConnection
				.selectRows("SELECT * FROM article WHERE displayStatus = 1 ORDER BY id DESC");

		dBConnection.close();
		
		request.setAttribute("articleRows", articleRows);
		
		request.getRequestDispatcher("/jsp/article/list.jsp").forward(request, response);
	}
}
