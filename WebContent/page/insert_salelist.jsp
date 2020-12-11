<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<script>
	function submitform() {
		document.input_form.submit();
	}
	function resetform() {
		document.input_form.reset();
	}
</script>
<h3 style="text-align: center;">판매등록</h3>
<form action="action/action_insert_salelist.jsp" name="input_form" method="post">
	<table border="1">
		<tr>
			<td>비번호</td>
			<td><input type="text" name="saleno"></td>
		</tr>
		<tr>
			<td>상품코드</td>
			<td><input type="text" name="pcode"></td>
		</tr>
		<tr>
			<td>판매날짜</td>
			<td><input type="date" name="saledate"></td>
		</tr>
		<tr>
			<td>매장코드</td>
			<td><input type="text" name="scode"></td>
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