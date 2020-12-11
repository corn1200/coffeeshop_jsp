<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String pcode = request.getParameter("pcode");
	String name = request.getParameter("name");
	int cost = Integer.parseInt(request.getParameter("cost"));
	
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection
		("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		Statement stmt = conn.createStatement();
		
		String query = "INSERT INTO tbl_product_01 " +
				"(PCODE, NAME, COST) " +
				"VALUES('%s', '%s', '%d') ";
		
		ResultSet rs = stmt.executeQuery(String.format(query, pcode, name, cost));
		
		conn.commit();
		
		stmt.close();
		conn.close();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	
	response.sendRedirect("../index.jsp");
%>