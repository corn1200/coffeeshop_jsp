<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<h3 style="text-align: center;">매장별 판매액</h3>
<table border="1">
	<tr>
		<td>매장코드</td>
		<td>매장명</td>
		<td>매장별 판매액</td>
	</tr>
	<%
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			Connection conn = DriverManager.getConnection
			("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
			Statement stmt = conn.createStatement();
			String query = "SELECT SHOP.SCODE, SHOP.SNAME, " +
					"SUM(SALELIST.AMOUNT * PRODUCT.COST) " +
					"FROM tbl_salelist_01 SALELIST, " +
					"tbl_shop_01 SHOP, tbl_product_01 PRODUCT " +
					"WHERE SALELIST.SCODE = SHOP.SCODE " +
					"AND SALELIST.PCODE = PRODUCT.PCODE " +
					"GROUP BY SHOP.SCODE, SHOP.SNAME " +
					"ORDER BY SHOP.SCODE ASC ";
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