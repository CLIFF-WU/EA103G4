<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ page import="com.categorie.model.*"%>
<%-- �����Ƚm�߱ĥ� Script ���g�k���� --%>

<%
  CategorieVO categorieVO = (CategorieVO) request.getAttribute("categorieVO"); //CategorieServlet.java(Concroller), �s�Jreq��categorieVO����
%>

<html>
<head>
<title>���O��� - listOneCategorie.jsp</title>

<style>

</style>

</head>
<body>

<h4>�����Ƚm�߱ĥ� Script ���g�k����:</h4>
<table id="table-1">
	<tr><td>
		 <h3>���u��� - ListOneCategorie.jsp</h3>
		 <h4><a href="select_page.jsp">�^����</a></h4>
	</td></tr>
</table>

<table>
	<tr>
		<th>���O�s��</th>
		<th>���O�W��</th>
	</tr>
	<tr>
		<td><%=categorieVO.getLc_class_id()%></td>
		<td><%=categorieVO.getLc_class_name()%></td>
	</tr>
</table>

</body>
</html>