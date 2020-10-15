<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.categorie.model.*"%>

<%
  CategorieVO categorieVO = (CategorieVO) request.getAttribute("categorieVO"); //CategorieServlet.java (Concroller) �s�Jreq��categorieVO���� (�]�A�������X��categorieVO, �]�]�A��J��ƿ��~�ɪ�categorieVO����)
%>

<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
<title>���O��ƭק� - update_categorie_input.jsp</title>

<style>
</style>

</head>
<body>

<table id="table-1">
	<tr><td>
		 <h3>���O��ƭק� - update_categorie_input.jsp</h3>
		 <h4><a href="select_page.jsp">�^����</a></h4>
	</td></tr>
</table>

<h3>��ƭק�:</h3>

<%-- ���~��C --%>
<c:if test="${not empty errorMsgs}">
	<font style="color:red">�Эץ��H�U���~:</font>
	<ul>
		<c:forEach var="message" items="${errorMsgs}">
			<li style="color:red">${message}</li>
		</c:forEach>
	</ul>
</c:if>

<FORM METHOD="post" ACTION="categorie.do" name="form1">
<table>
	<tr>
		<td>���O�s��:<font color=red><b>*</b></font></td>
		<td><%=categorieVO.getLc_class_id()%></td>
	</tr>
	<tr>
		<td>���O�W��:</td>
		<td><input type="TEXT" name="lc_class_name" size="45" value="<%=categorieVO.getLc_class_name()%>" /></td>
	</tr>

</table>
<br>
<input type="hidden" name="action" value="update">
<input type="hidden" name="lc_class_id" value="<%=categorieVO.getLc_class_id()%>">
<input type="submit" value="�e�X�ק�"></FORM>
</body>
</html>