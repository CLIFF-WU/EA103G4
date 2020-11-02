<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.lecture.model.*"%>
<%@ page import="com.categorie.model.*"%>
<%@ page import="java.util.*"%>


<%
	LectureVO lectureVO = (LectureVO) request.getAttribute("lectureVO");
pageContext.setAttribute("lectureVO", lectureVO);
%>

<%
	List<CategorieVO> categorieVO = (List<CategorieVO>) request.getAttribute("categorieVO"); //�ζ��X�ӱ��\�h�v��������
%>
<%
	String admin_name_s = (String) session.getAttribute("admin_name_s");
    String admin_id_s = (String) session.getAttribute("admin_id_s");
%>


<html>

<head>

<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>���u�Ա����</title>

<!--BOOSTRAP CSS -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendors/styles/core.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendors/styles/icon-font.min.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/src/plugins/jquery-steps/jquery.steps.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendors/styles/style.css">



<style>
.main-container {
	padding: 80px 50px 100px 270px
}
</style>


</head>


<body>
	<jsp:include page="/back-end/header/header.jsp" />
	<div class="main-container">
		<main>
			<div class="pd-ltr-20 xs-pd-20-10">
				<div class="min-height-200px">
					<div class="pd-20 card-box mb-30">

						<div class="clearfix">
							<h2 class="text-dark h2">���y��ƸԱ�</h2>
							<div class="pull-right" style="padding-bottom: 10px">

								<a href="<%=request.getContextPath()%>/back-end/lecture/listAllLecture.jsp">�^���y�C�� <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-left-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  								<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
  								<path fill-rule="evenodd" d="M12 8a.5.5 0 0 1-.5.5H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5a.5.5 0 0 1 .5.5z" />
							</svg>
								</a>
							</div>
						</div>
					</div>

					<!-- ���~��C -->
					<c:if test="${not empty errorMsgs}">
						<font style="color: red">�Эץ��H�U���~:</font>
						<ul>
							<c:forEach var="message" items="${errorMsgs}">
								<li style="color: red">${message}</li>
							</c:forEach>
						</ul>
					</c:if>

					<jsp:useBean id="categorieService" scope="page" class="com.categorie.model.CategorieService"></jsp:useBean>
					<form method="post" action="lecture.do" name="form1" enctype="multipart/form-data">
						<section>

							<!-- Area Chart -->
							<div class="card shadow mb-4">
								<div class="card-header py-3">
									<h3 class="m-0 font-weight-bold text-danger">${lectureVO.lc_id}</h3>

								</div>

								<div class="card-body">

									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<div class="h5 text-gray">���y���O�s��:</div>
												<div class="h3 text-dark">${lectureVO.lc_class_id}${categorieVO.lc_class_name}</div>


											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<div class="h5 text-gray">�޲z���s��:</div>
												<div class="h3 text-dark"><%=admin_id_s%> <%=admin_name_s%></div>

											</div>

										</div>
									</div>

									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<div class="h5 text-gray">���y�W��:</div>
												<div class="h3 text-dark">${lectureVO.lc_name}</div>

											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<div class="h5 text-gray">���y�a�I:</div>
												<div class="h3 text-dark">${lectureVO.lc_place}</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<div class="h5 text-gray">���y�ɶ�:</div>
												<div class="h3 text-dark">${lectureVO.lc_time}</div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<div class="h5 text-gray">���y�ɼ�:</div>
												<div class="h3 text-dark">${lectureVO.lc_hr}</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<div class="h5 text-gray">���y���W�}�l���:</div>
												<div class="h3 text-dark">${lectureVO.lc_start_time}</div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<div class="h5 text-gray">���y���W�I����:</div>
												<div class="h3 text-dark">${lectureVO.lc_deadline}</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-md-6">
											<div class="form-group">
												<div class="h5 text-gray">���y�̤֤H��:</div>
												<div class="h3 text-dark">${lectureVO.lc_peo_lim}</div>
											</div>
										</div>
										<div class="col-md-6">
											<div class="form-group">
												<div class="h5 text-gray">���y�̦h�H��:</div>
												<div class="h3 text-dark">${lectureVO.lc_peo_up}</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<div class="h5 text-gray">���y²��:</div>
												<div class="h3 text-dark">${lectureVO.lc_info}</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<div class="h5 text-gray">���y�ŶǷӤ�:</div>
												<div id="img" style="text-align: center;">
													<img width="200px" heigh="200px" src="${pageContext.request.contextPath}/ShowLecturePic?lc_id=${lectureVO.lc_id}" />
												</div>
											</div>
										</div>
									</div>

									<div class="row">
										<div class="col-md-12">
											<div class="form-group">
												<div class="h5 text-gray">���y���A:</div>
												<div class="h3 text-dark">${lectureVO.lc_state}</div>
											</div>
										</div>
									</div>

								</div>
							</div>
						</section>
					</form>
				</div>
			</div>
		</main>
	</div>
	<jsp:include page="/back-end/sidebar/sidebar.jsp" />
	<!-- js -->

	<script src="<%=request.getContextPath()%>/vendors/scripts/core.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/scripts/script.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/scripts/process.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/scripts/layout-settings.js"></script>
	<script src="<%=request.getContextPath()%>/src/plugins/jquery-steps/jquery.steps.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/scripts/steps-setting.js"></script>

</body>

</html>