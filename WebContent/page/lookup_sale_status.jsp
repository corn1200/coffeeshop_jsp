<%@page import="java.text.DecimalFormat"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<h3 style="text-align: center;">판매현황</h3>
<table border="1">
	<tr>
		<td>비번호</td>
		<td>상품코드</td>
		<td>판매날짜</td>
		<td>매장코드</td>
		<td>상품명</td>
		<td>판매수량</td>
		<td>총판매액</td>
	</tr>
	<%
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			Connection conn = DriverManager.getConnection
			("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
			Statement stmt = conn.createStatement();
			String query = "SELECT SALELIST.SALENO, " +
					"SALELIST.PCODE, TO_CHAR(SALELIST.SALEDATE, 'yyyy-MM-dd'), " +
					"SALELIST.SCODE, PRODUCT.NAME, " +
					"SALELIST.AMOUNT, PRODUCT.COST " +
					"FROM tbl_product_01 PRODUCT, " +
					"tbl_salelist_01 SALELIST, " +
					"tbl_shop_01 SHOP " +
					"WHERE SHOP.SCODE = SALELIST.SCODE " +
					"AND PRODUCT.PCODE = SALELIST.PCODE " +
					"ORDER BY SALELIST.SALENO ASC";
			ResultSet rs = stmt.executeQuery(query);
			
			while (rs.next()) {
				int totalSales = rs.getInt(6) * rs.getInt(7);
				DecimalFormat formatter = new DecimalFormat("###,###");
				String formattingTotalSales = formatter.format(totalSales);
				%>
					<tr>
						<td><%= rs.getInt(1) %></td>
						<td><%= rs.getString(2) %></td>
						<td><%= rs.getString(3) %></td>
						<td><%= rs.getString(4) %></td>
						<td><%= rs.getString(5) %></td>
						<td><%= rs.getInt(6) %></td>
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