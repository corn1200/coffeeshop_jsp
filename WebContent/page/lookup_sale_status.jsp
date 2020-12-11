<%@page import="java.util.Optional"%>
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
		String searchKeyword = request.getParameter("search");
		String searchCategory = request.getParameter("category");
		Optional<String> checkSearchKey = Optional.ofNullable(searchKeyword);
		Optional<String> checkSearchCategory = Optional.ofNullable(searchCategory);
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			Connection conn = DriverManager.getConnection
			("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
			Statement stmt = conn.createStatement();
			String query = "";
			String condition = "";
			if (checkSearchKey.isPresent() && checkSearchCategory.isPresent()) {
				switch (searchCategory) {
					case "saleno" :
						condition = "AND SALELIST.SALENO = '" + searchKeyword + "' ";
						break;
					case "pcode" :
						condition = "AND SALELIST.PCODE = '" + searchKeyword + "' ";
						break;
					case "scode" :
						condition = "AND SALELIST.SCODE = '" + searchKeyword + "' ";
						break;
					case "name" :
						condition = "AND PRODUCT.NAME = '" + searchKeyword + "' ";
						break;
					case "amount" :
						condition = "AND SALELIST.AMOUNT = '" + searchKeyword + "' ";
						break;
					case "totalcost" :
						query = "AND (SALELIST.AMOUNT * PRODUCT.COST) = '" + searchKeyword + "' ";
						break;
				}
			}
			
			query = "SELECT SALELIST.SALENO, " +
					"SALELIST.PCODE, TO_CHAR(SALELIST.SALEDATE, 'yyyy-MM-dd'), " +
					"SALELIST.SCODE, PRODUCT.NAME, " +
					"SALELIST.AMOUNT, PRODUCT.COST " +
					"FROM tbl_product_01 PRODUCT, " +
					"tbl_salelist_01 SALELIST, " +
					"tbl_shop_01 SHOP " +
					"WHERE SHOP.SCODE = SALELIST.SCODE " +
					"AND PRODUCT.PCODE = SALELIST.PCODE " +
					condition +
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

<form action="index.jsp?section=lookup_sale_status" method="get">
	<input type="hidden" name="section" value="lookup_sale_status">
	<select name="category">
		<option value="saleno">비번호</option>
		<option value="pcode">상품코드</option>
		<option value="scode">매장코드</option>
		<option value="name">상품명</option>
		<option value="amount">판매수량</option>
		<option value="totalcost">총판매액</option>
	</select>
	<input type="text" name="search">
	<input type="submit" value="검색하기">
</form>