<%@ page contentType="text/html; charset=UTF-8" pageEncoding="BIG5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.Fa.model.*"%>

<jsp:useBean id="memVO" scope="session" type="com.mem.model.MemVO" />
<jsp:useBean id="faSvc" scope="page" class="com.Fa.model.FaService" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberCenter</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main-front.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/memSpace_forum.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/header.css">
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
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
						<div class="col-md-8">�D�D</div>
						<div class="col-md-2">�ɶ�</div>
						<div class="col-md-1"></div>
						<div class="col-md-1"></div>
					</div>
					<hr>
					<%@ include file="page_memberCenter_forum.file"%>
					<c:forEach var="faVO" items="${faSvc.getOneMemFa(memVO.getMem_id())}" varStatus="update" begin="<%=pageIndex%>"
						end="<%=pageIndex+rowsPerPage-1%>">
						<div class="row" id=forum_record>
							<div class="col-md-8">
								<a href="<%=request.getContextPath() %>/front-end/forum/fa.do?action=getOne_For_Display&faId=${faVO.faId}" target="_blank">${faVO.faTopic}</a>
							</div>
							<div class="col-md-2">
								<fmt:formatDate value="${faVO.faDate}" pattern="yyyy-MM-dd HH:mm:ss" />
							</div>
							<div class="col-md-1">
								<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal${update.index}">�ק�峹</button>

								<div class="modal fade" id="exampleModal${update.index}" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
									<div class="modal-dialog modal-lg" role="document">
										<div class="modal-content">
											<div class="modal-header">
												<h5 class="modal-title" id="exampleModalLabel">�ק�峹</h5>
												<button type="button" class="close" data-dismiss="modal" aria-label="Close">
													<span aria-hidden="true">&times;</span>
												</button>
											</div>
											<form method="post" action="<%=request.getContextPath()%>/front-end/forum/fa.do">
												<div class="modal-body">
													<c:if test="${not empty errorMsgs}">
														<font style="color: red">�Эץ��H�U���~:</font>
														<ul>
															<c:forEach var="message" items="${errorMsgs}">
																<li style="color: red">${message}</li>
															</c:forEach>
														</ul>
													</c:if>
													<p>
														<label for="topic">�D�D :</label>
														<input type="text" name="faTopic" value="${faVO.faTopic}" id="faTopic">
													</p>
													<p>
														<label for="content">���e :</label>
														<textarea id="summernote${update.index}" name="faContent" id="faContent">${faVO.faContent}</textarea>
													</p>
													<p style="display: inline-flex;">
														<input type="submit" >
														<input type="button" type="button" class="btn btn-secondary" data-dismiss="modal" value="����">
														<input type="hidden" name="action" value="update">
														<input type="hidden" name="memId" value="${memVO.mem_id}">
														<input type="hidden" name="faId" value="${faVO.faId}">
													</p>
												</div>

											</form>
										</div>
									</div>
								</div>
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
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>

	<script type="text/javascript">
		var summerIdIndex = ${faSvc.getOneMemFa(memVO.getMem_id()).size()};
	</script>
	<!-- include summernote css/js -->
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/summernote_updateFa.js"></script>
</body>
</html>