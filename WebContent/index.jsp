<%@page import="java.util.Optional"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="css/css.css">
</head>
<body>
	<%@ include file="static/header.jsp" %>
	<%@ include file="static/nav.jsp" %>
	
	<%
		String sectionParameter = request.getParameter("section");
		Optional<String> checkSection = Optional.ofNullable(sectionParameter);
		
		if (checkSection.isPresent() == false) {
			sectionParameter = "";
		}
		
		switch (sectionParameter) {
			case "insert_salelist" :
				%><%@ include file="page/insert_salelist.jsp" %><%
				break;
			case "insert_shop" :
				%><%@ include file="page/insert_shop.jsp" %><%
				break;
			case "insert_product" :
				%><%@ include file="page/insert_product.jsp" %><%
				break;
			case "lookup_sale_status" :
				%><%@ include file="page/lookup_sale_status.jsp" %><%
				break;
			case "lookup_shop_sales" :
				%><%@ include file="page/lookup_shop_sales.jsp" %><%
				break;
			case "lookup_product_sales" :
				%><%@ include file="page/lookup_product_sales.jsp" %><%
				break;
			default :
				%><%@ include file="static/index.jsp" %><%
				break;
		}
	%>
	
	<%@ include file="static/footer.jsp" %>
</body>
</html>