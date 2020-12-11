<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<h3 style="text-align: center;">상품별 판매액</h3>
<table border="1">
	<tr>
		<td>상품코드</td>
		<td>상품명</td>
		<td>상품별 판매액</td>
	</tr>
	<%
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			Connection conn = DriverManager.getConnection
			("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
			Statement stmt = conn.createStatement();
			String query = "SELECT PRODUCT.PCODE, " +
					"PRODUCT.NAME, SUM(PRODUCT.COST * SALELIST.AMOUNT) " +
					"FROM tbl_product_01 PRODUCT, " +
					"tbl_salelist_01 SALELIST " +
					"WHERE SALELIST.PCODE = PRODUCT.PCODE " +
					"GROUP BY PRODUCT.PCODE, PRODUCT.NAME " +
					"ORDER BY PRODUCT.PCODE ASC ";
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int totalSales = rs.getInt(3);
				DecimalFormat formatter = new DecimalFormat("###,###");
				String formattingTotalSales = formatter.format(totalSales);
				%>
					<tr>
						<td><%= rs.getString(1) %></td>
						<td><%= rs.getString(2) %></td>
						<td><%= formattingTotalSales %></td>
					</tr>
				<%
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
	%>
</table>