<%@ page contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.Fa.model.*"%>

<%
	MemVO memVO = (MemVO) session.getAttribute("memVO");
	String memId = memVO.getMem_id();
	FaService faSvc = new FaService();
	List<FaVO> list = faSvc.getOneMemFa(memId);
	pageContext.setAttribute("list", list);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberCenter</title>
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/main-front.css" />
	<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
	<link rel="stylesheet" href="<%=request.getContextPath()%>/css/memSpace_forum.css" />
	<link rel="stylesheet"
    href="<%=request.getContextPath()%>/css/header.css">

</head>
<body>
	<jsp:include page="/front-end/header/header.jsp" />

	<section id="One" class="wrapper style3">
		<div class="inner">
			<header class="align-center">
				<p>���ȧXBookShop</p>
				<h2>�|������MemberCenter</h2>
			</header>
		</div>
	</section>
	<div class="content">
		<div class="menuDiv">
			<ul class="myMenu">
				<li class="itembox drop-down"><a class="item">�|����ƺ޲z</a>
					<div class="submenu">
						<a class="submenu-item" href="#">�ק�K�X</a> <a class="submenu-item"
							href="<%=request.getContextPath()%>/front-end/member/memberSpace.jsp">�|����Ƨ�s</a>
						<a class="submenu-item" href="#">��I�޲z</a>
					</div></li>
				<li class="itembox drop-down"><a class="item">�q��޲z</a>
					<div class="submenu">
						<a class="submenu-item" href="#">�q��ק�/����</a> <a
							class="submenu-item" href="#">�q��d��</a>
					</div></li>
				<li class="itembox drop-down"><a class="item">�G��ѭq��޲z</a>
					<div class="submenu">
						<a class="submenu-item" href="#">�G��ѭq��ק�/����</a> <a
							class="submenu-item" href="#">�G��ѭq��d��</a>
					</div></li>
				<li class="itembox drop-down"><a class="item">���ʬ���</a>
					<div class="submenu">
						  <a class="submenu-item" href="<%= request.getContextPath()%>/front-end/forum/memberCenter_forum.jsp">�Q�װϵo�����</a>
			            <a class="submenu-item" href="<%=request.getContextPath()%>/front-end/forum/memberCenter_forum_collections.jsp">�l�ܤ峹</a>
			            <a class="submenu-item" href="#">�ѵ��o�����</a>
					</div></li>
				<li class="itembox drop-down"><a class="item">Ū�ѷ|�޲z</a>
					<div class="submenu">
						<a class="submenu-item" href="#">�ڪ�Ū�ѷ|</a> <a class="submenu-item"
							href="#">Ū�ѷ|���W����</a>
					</div></li>
				<li class="itembox drop-down"><a class="item">���y</a>
					<div class="submenu">
						<a class="submenu-item" href="#">���y���W����</a>
					</div></li>
				<li class="itembox drop-down"><a class="item">���ê��ѳ�޲z</a>
					<div class="submenu">
						<a class="submenu-item" href="#">�w���îѳ�</a> <a class="submenu-item"
							href="#">���îѳ����</a>
					</div></li>
			</ul>

			<div class="mem-info">
				<div class="container">
					<div class="row">
						<div class="col-md-8">�D�D</div>
						<div class="col-md-2">�ɶ�</div>
						<div class="col-md-1"></div>
						<div class="col-md-1"></div>
					</div>
					<hr>
					<%@ include file="pageForMemberCenter_forum.file" %>
					<c:forEach var="faVO" items="${list}" begin="<%=pageIndex%>"
						end="<%=pageIndex+rowsPerPage-1%>">
						<div class="row" id=forum_record>
							<div class="col-md-8"><a href="<%=request.getContextPath() %>/front-end/forum/fa.do?action=getOne_For_Display&faId=${faVO.faId}">${faVO.faTopic}</a></div>
							<div class="col-md-2">
								<fmt:formatDate value="${faVO.faDate}"
									pattern="yyyy-MM-dd HH:mm:ss" />
							</div>
							<div class="col-md-1">
							<form method="post" action="<%=request.getContextPath()%>/front-end/forum/fa.do">
								<input type="submit" value="�ק�">
								<input type="hidden" name="faId" value="${faVO.faId}">
								<input type="hidden" name="action" value="getOne_For_Update">
							</form>
							</div>
							<div class="col-md-1">
							<form method="post" action="<%=request.getContextPath()%>/front-end/forum/fa.do">
								<input type="submit" value="�R��">
								<input type="hidden" name="action" value="delete">
								<input type="hidden" name="faId" value="${faVO.faId}">
							</form>
							</div>
						</div>
						<hr>
					</c:forEach>
					<%@ include file="page2.file" %>
				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/front-end/footer/footer.jsp" />
	<script src='<%=request.getContextPath()%>/js/jquery.min.js'></script>
	<script src="<%=request.getContextPath()%>/js/jquery.scrollex.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/skel.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/util.js"></script>
	<script src="<%=request.getContextPath()%>/js/main.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>

</body>
</html>