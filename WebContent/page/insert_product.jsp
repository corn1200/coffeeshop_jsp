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
<h3 style="text-align: center;">상품등록</h3>
<form action="action/action_insert_product.jsp" name="input_form" method="post">
	<table border="1">
		<tr>
			<td>상품코드</td>
			<td><input type="text" name="pcode"></td>
		</tr>
		<tr>
			<td>상품명</td>
			<td><input type="text" name="name"></td>
		</tr>
		<tr>
			<td>가격</td>
			<td><input type="number" name="cost"></td>
		</tr>
		<tr>
			<td><input type="button" onclick="submitform()" value="등록"></td>
			<td><input type="button" onclick="resetform()" value="다시쓰기"></td>
		</tr>
	</table>
</form>