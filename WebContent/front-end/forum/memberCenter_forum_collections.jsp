<%@ page contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.Fc.model.*"%>
<%@ page import="com.Fa.model.*"%>
<jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" />
<jsp:useBean id="fasvc" scope="page" class="com.Fa.model.FaService"/>
<jsp:useBean id="fcsvc" scope="page" class="com.Fc.model.FcService"/>
<jsp:useBean id="memSvc" scope="page" class="com.mem.model.MemService" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberCenter</title>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main-front.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/header.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/memSpace_forum.css" />

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
						<a class="submenu-item" href="<%=request.getContextPath()%>/front-end/member/updatePwd.jsp">�ק�K�X</a>
						<a class="submenu-item" href="<%=request.getContextPath()%>/front-end/member/memberSpace.jsp">�|����Ƨ�s</a>
						<a class="submenu-item" href="<%=request.getContextPath()%>/front-end/member/payMethod.jsp">��I�޲z</a>
					</div></li>
				<li class="itembox drop-down"><a class="item">�q��޲z</a>
					<div class="submenu">
						<a class="submenu-item" href="#">�q��ק�/����</a>
						<a class="submenu-item" href="<%=request.getContextPath()%>/front-end/member/selectOrder.jsp">�q��d��</a>
					</div></li>
				<li class="itembox drop-down"><a class="item">���ʬ���</a>
					<div class="submenu">
						<a class="submenu-item" href="<%=request.getContextPath()%>/front-end/forum/memberCenter_forum.jsp">�Q�װϵo�����</a>
						<a class="submenu-item" href="<%=request.getContextPath()%>/front-end/forum/memberCenter_forum_collections.jsp">���ä峹</a>
						<a class="submenu-item" href="#">�ѵ��o�����</a>
					</div></li>
				<li class="itembox drop-down"><a class="item">Ū�ѷ|�޲z</a>
					<div class="submenu">
						<a class="submenu-item" href="<%=request.getContextPath()%>/front-end/bookclub/myBookClub.jsp">�ڪ�Ū�ѷ|</a>
						<a class="submenu-item" href="<%=request.getContextPath()%>/front-end/bookclub/review_BookClub.jsp">Ū�ѷ|���W����</a>
					</div></li>
				<li class="itembox drop-down"><a class="item">���y</a>
					<div class="submenu">
						<a class="submenu-item" href="#">���y���W����</a>
					</div></li>
				<li class="itembox drop-down"><a class="item">���ê��ѳ�޲z</a>
					<div class="submenu">
						<a class="submenu-item" href="<%=request.getContextPath()%>/front-end/favorite_book/favoriteBook.jsp">�w���îѳ�</a>
						<a class="submenu-item" href="<%=request.getContextPath()%>/front-end/celebrity_book/celebrityBook.jsp">���îѳ����</a>
					</div></li>
			</ul>

			<div class="mem-info">
				<div class="container">
					<div class="row">
						<div class="col-md-8">�峹</div>
						<div class="col-md-2">�o��ɶ�</div>
						<div class="col-md-1"></div>
						<div class="col-md-1"></div>
					</div>
					<hr>
					<%@ include file="pageForMemberCenter_forum_collections.file"%>
					<c:forEach var="faVO" items="${fcsvc.getOneMemCollection(memVO.mem_id)}" begin="<%=pageIndex%>" end="<%=pageIndex+rowsPerPage-1%>">
						<div class="row" id=forum_record>
							<div class="col-md-8">
								<a href="<%=request.getContextPath() %>/front-end/forum/fa.do?action=getOne_For_Display&faId=${faVO.faId}" target="_blank">${fasvc.getOneFa(faVO.faId).faTopic}</a>
							</div>
							<div class="col-md-2">
								<fmt:formatDate value="${fasvc.getOneFa(faVO.faId).faDate}" pattern="yyyy-MM-dd HH:mm:ss" />
							</div>
							<div class="col-md-2">
								<form method="post" action="<%=request.getContextPath()%>/front-end/forum/fc.do">
									<input type="submit" value="��������">
									<input type="hidden" name="faId" value="${faVO.faId}">
									<input type="hidden" name="memId" value="${memVO.mem_id}">
									<input type="hidden" name="action" value="cancelCollect">
								</form>
							</div>

						</div>
						<hr>
					</c:forEach>
					<%@ include file="page2.file"%>
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
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
</body>
</html>