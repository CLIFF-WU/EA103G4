<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="com.lecture.model.*"%>
<%@ page import="com.categorie.model.*"%>
<%@ page import="java.util.*"%>
<%
	LectureVO lectureVO = (LectureVO) session.getAttribute("lectureVO");
pageContext.setAttribute("lectureVO", lectureVO);
%>
<%
	List<CategorieVO> categorieVO = (List<CategorieVO>) request.getAttribute("categorieVO");
%>

<html>

<head>

<meta charset="utf-8">
<title>修改講座資料</title>
<!--BOOSTRAP CSS -->
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendors/styles/core.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendors/styles/icon-font.min.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/src/plugins/jquery-steps/jquery.steps.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendors/styles/style.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/css/jquery.datetimepicker.css" />

<style>
.main-container {
	padding: 80px 30px 100px 270px
}

.city, .town {
	width: 100%;
}

.f1 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(5% - 10px)
}

.f2 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(10% - 10px)
}

.f3 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(15% - 10px)
}

.f4 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(20% - 10px)
}

.f5 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(25% - 10px)
}

.f6 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(30% - 10px)
}

.f7 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(35% - 10px)
}

.f8 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(40% - 10px)
}

.f9 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(45% - 10px)
}

.f10 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(50% - 10px)
}

.f11 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(55% - 10px)
}

.f12 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(60% - 10px)
}

.f13 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(65% - 10px)
}

.f14 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(70% - 10px)
}

.f15 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(75% - 10px)
}

.f16 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(80% - 10px)
}

.f17 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(85% - 10px)
}

.f18 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(90% - 10px)
}

.f19 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(95% - 10px)
}

.f20 {
	float: left;
	margin-left: 5px;
	margin-right: 5px;
	width: calc(100% - 10px)
}

/* datetimepicker  */
.xdsoft_datetimepicker .xdsoft_datepicker {
	width: 300px; /* width:  300px; */
}

.xdsoft_datetimepicker .xdsoft_timepicker .xdsoft_time_box {
	height: 151px; /* height:  151px; */
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
							<h2 class="text-dark h2">修改講座資料</h2>
							<div class="pull-right">
								<a href="<%=request.getContextPath()%>/back-end/lecture/listAllLecture.jsp">回講座列表 <svg width="1em" height="1em" viewBox="0 0 16 16" class="bi bi-arrow-left-circle" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
  								<path fill-rule="evenodd" d="M8 15A7 7 0 1 0 8 1a7 7 0 0 0 0 14zm0 1A8 8 0 1 0 8 0a8 8 0 0 0 0 16z" />
  								<path fill-rule="evenodd" d="M12 8a.5.5 0 0 1-.5.5H5.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L5.707 7.5H11.5a.5.5 0 0 1 .5.5z" />
									</svg>
								</a>
							</div>
						</div>
						<!-- 錯誤表列 -->
						<c:if test="${not empty errorMsgs}">
							<font style="color: red">請修正以下錯誤:</font>
							<ul>
								<c:forEach var="message" items="${errorMsgs}">
									<li style="color: red">${message}</li>
								</c:forEach>
							</ul>
						</c:if>
						<jsp:useBean id="categorieService" scope="page" class="com.categorie.model.CategorieService"></jsp:useBean>
						<form method="post" action="lecture.do" name="form1" enctype="multipart/form-data">
							<section>
								<div class="h3">
									<td>講座編號:<font color=red><b>*</b></font></td>
									<td>${lectureVO.lc_id}</td>
									<td>講座類別編號:<font color=red><b>*</b></font></td>
									<td>${lectureVO.lc_class_id}</td> <input type="hidden" name="lc_class_id" value="${lectureVO.lc_class_id}">
									<td>管理員編號:<font color=red><b>*</b></font></td>
									<td>${lectureVO.admin_id}</td> <input type="hidden" name="admin_id" value="${lectureVO.admin_id}">
									<td>講座名稱:<font color=red><b>*</b></font></td>
									<td>${lectureVO.lc_name}</td> <input type="hidden" name="lc_name" value="${lectureVO.lc_name}">
								</div>
								<div class="row">
									<div class="col-md-4">
										<div class="form-group">
											<label>講座地點:</label> <input type="text" class="form-control" name="lc_place" value="<%=lectureVO.getLc_place()%>" />
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>講座日期:</label> <input type="text" class="date form-control" id="lc_time" name="lc_time" value="<fmt:formatDate value="${lectureVO.lc_time}" pattern="yyyy-MM-dd HH:mm"/>" />
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group">
											<label>講座時數:</label> <input type="text" class="form-control" name="lc_hr" value="<%=lectureVO.getLc_hr()%>" />
										</div>
									</div>

								</div>
								<hr>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label>講座報名開始日期:</label> <input type="text" class="date form-control" id="lc_start_time" name="lc_start_time" value="<fmt:formatDate value="${lectureVO.lc_start_time}" pattern="yyyy-MM-dd HH:mm"/>" />
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label>報名截止日期:</label> <input type="text" class="date form-control" id="lc_deadline" name="lc_deadline" value="<fmt:formatDate value="${lectureVO.lc_deadline}" pattern="yyyy-MM-dd HH:mm"/>" />
										</div>
									</div>
								</div>
								<hr>
								<div class="row">
									<div class="col-md-6">
										<div class="form-group">
											<label>講座最低人數:</label> <input type="text" class="form-control" name="lc_peo_lim" value="<%=lectureVO.getLc_peo_lim()%>" />
										</div>
									</div>
									<div class="col-md-6">
										<div class="form-group">
											<label>講座至多人數:</label> <input type="text" class="form-control" name="lc_peo_up" value="<%=lectureVO.getLc_peo_up()%>" />
										</div>
									</div>
								</div>
								<hr>
								<div class="row">
									<div class="col-md-12">
										<div class="form-group">
											<label>講座簡介:</label> <input type="text" size="40" class="form-control" name="lc_info" value="<%=lectureVO.getLc_info()%>" />
										</div>
									</div>
								</div>
								<hr>
								<div class="row">
									<div class="col-md-4">
										<div class="form-group">
											<label>講座狀態:</label> <select class="custom-select form-control" name="lc_state">
												<option value="0">未開放</option>
												<option value="1">報名中</option>
												<option value="2">已截止</option>
												<option value="3">已結束</option>
												<option value="4">已取消</option>
											</select>
										</div>
									</div>
								</div>
								<hr>
								<div class="row">
									<div class="col-md-4">
										<div class="form-group">
											<input type="hidden" name="action" value="update"> <input type="hidden" name="lc_id" value="<%=lectureVO.getLc_id()%>"> <input type="submit" value="送出" class="btn btn-dark btn-sm">
										</div>
									</div>
								</div>
							</section>
						</form>
					</div>
				</div>
			</div>

		</main>
	</div>
	<jsp:include page="/back-end/sidebar/sidebar.jsp" />


	<!-- 自訂js -->
	<!-- 圖片 -->
	<script type="text/javascript">
		function init() {

			var admin_pic = document.getElementById("admin_pic");
			var preview = document.getElementById('preview');

			admin_pic.addEventListener('change', function() {

				var files = admin_pic.files;

				if (files !== null) {
					for (var i = 0; i < files.length; i++) {
						var file = files[i];
						console.log(file);

						if (file.type.indexOf('image') > -1) {

							var reader = new FileReader();

							reader.addEventListener('load', function(e) {

								var img = document.createElement('img');
								img.setAttribute('src', e.target.result);
								preview.append(img);
							});
							reader.readAsDataURL(file); // ***** trigger
						} else {
							alert('請上傳圖片！');
						}
					}
				}
			});
		}
		window.onload = init;
	</script>
	<!-- js -->
	<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/scripts/core.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/scripts/script.min.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/scripts/process.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/scripts/layout-settings.js"></script>
	<script src="<%=request.getContextPath()%>/src/plugins/jquery-steps/jquery.steps.js"></script>
	<script src="<%=request.getContextPath()%>/vendors/scripts/steps-setting.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-datetimepicker/2.5.20/jquery.datetimepicker.full.min.js"></script>
	<script>
		$.datetimepicker.setLocale('zh'); // kr ko ja en
		$(function() {
			$('#lc_start_time').datetimepicker(
					{
						format : 'Y-m-d H:i',
						onShow : function() {
							this.setOptions({
								maxDate : $('#lc_deadline').val() ? $(
										'#lc_deadline').val() : false
							})
						},
						timepicker : true
					});

			$('#lc_deadline').datetimepicker(
					{
						format : 'Y-m-d H:i',
						onShow : function() {
							this.setOptions({
								minDate : $('#lc_start_time').val() ? $(
										'#lc_start_time').val() : false,
								maxDate : $('#lc_time').val() ? $('#lc_time')
										.val() : false

							})
						},
						timepicker : true
					});

			$('#lc_time').datetimepicker(
					{
						format : 'Y-m-d H:i',
						onShow : function() {
							this.setOptions({
								minDate : $('#lc_deadline').val() ? $(
										'#lc_deadline').val() : false
							})
						},
						timepicker : true
					});
		});
		// ----------------------------------------------------------以下用來排定無法選擇的日期-----------------------------------------------------------

		//1.以下為某一天之前的日期無法選擇
		var somedate1 = new Date();
		$('#lc_start_time')
				.datetimepicker(
						{
							beforeShowDay : function(date) {
								if (date.getYear() < somedate1.getYear()
										|| (date.getYear() == somedate1
												.getYear() && date.getMonth() < somedate1
												.getMonth())
										|| (date.getYear() == somedate1
												.getYear()
												&& date.getMonth() == somedate1
														.getMonth() && date
												.getDate() < somedate1
												.getDate())) {
									return [ false, "" ]
								}
								return [ true, "" ];
							}
						});
	</script>

</body>
</html>