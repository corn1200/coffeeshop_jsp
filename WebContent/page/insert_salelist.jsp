<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<script>
	function submitform() {
		document.input_form.submit();
	}
	function resetform() {
		document.input_form.reset();
	}
</script>
<% try {
	Class.forName("oracle.jdbc.OracleDriver");
	Connection conn = DriverManager.getConnection
	("jdbc:oracle:thin:@//localhost:1521/xe", "system", "1234");
	String query = "";
%>
<h3 style="text-align: center;">판매등록</h3>
<form action="action/action_insert_salelist.jsp" name="input_form" method="post">
	<table border="1">
		<tr>
			<td>비번호</td>
			<td><input type="text" name="saleno"></td>
		</tr>
		<tr>
			<td>상품코드</td>
			<td>
				<select name="pcode">
					<%
						Statement stmt_pcode = conn.createStatement();
						query = "SELECT PRODUCT.PCODE, PRODUCT.NAME " +
								"FROM tbl_product_01 PRODUCT ";
						ResultSet rs = stmt_pcode.executeQuery(query);
						while (rs.next()) {
							%><option value="<%= rs.getString(1) %>">[<%= rs.getString(1) %>] <%= rs.getString(2) %></option><%
						}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td>판매날짜</td>
			<td><input type="date" name="saledate"></td>
		</tr>
		<tr>
			<td>매장코드</td>
			<td>
				<select name="scode">
					<%
						Statement stmt_scode = conn.createStatement();
						query = "SELECT SHOP.SCODE, SHOP.SNAME " +
								"FROM tbl_shop_01 SHOP ";
						rs = stmt_pcode.executeQuery(query);
						while (rs.next()) {
							%><option value="<%= rs.getString(1) %>">[<%= rs.getString(1) %>] <%= rs.getString(2) %></option><%
						}
					%>
				</select>
			</td>
		</tr>
		<tr>
			<td>판매수량</td>
			<td><input type="number" name="amount"></td>
		</tr>
		<tr>
			<td><input type="button" onclick="submitform()" value="등록"></td>
			<td><input type="button" onclick="resetform()" value="다시쓰기"></td>
		</tr>
	</table>
</form>
<% 
	stmt_pcode.close();
	stmt_scode.close();
	conn.close();
	} 
	catch (Exception e) {
	
} %>