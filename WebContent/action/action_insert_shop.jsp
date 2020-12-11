<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	String scode = request.getParameter("scode");
	String sname = request.getParameter("sname");
	
	try {
		Class.forName("oracle.jdbc.OracleDriver");
		Connection conn = DriverManager.getConnection
		("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
		Statement stmt = conn.createStatement();
		
		String query = "INSERT INTO tbl_shop_01 " +
				"(SCODE, SNAME) " +
				"VALUES('%s', '%s') ";
		
		ResultSet rs = stmt.executeQuery(String.format(query, scode, sname));
		
		conn.commit();
		
		stmt.close();
		conn.close();
	}
	catch (Exception e) {
		e.printStackTrace();
	}
	
	response.sendRedirect("../index.jsp");
%>