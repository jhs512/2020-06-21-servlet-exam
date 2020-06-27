package com.sbs.example.demo.servlet;

import java.io.IOException;
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

		Map<String, Object> articleRow = dBConnection.selectRow("SELECT * FROM article LIMIT 1");

		response.getWriter().append((String) articleRow.get("body"));
		dBConnection.close();
	}
}
