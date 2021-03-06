<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.Fa.model.*"%>
<%@ page import="com.mem.model.*"%>

<!DOCTYPE HTML>
<html>
<head>
<title>BookShop討論區</title>
<meta charset="utf-8" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main-front.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/addFaPage.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/header.css">
<!-- bootstrap(4.2.1) -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.2.1/css/bootstrap.min.css">
<!-- summernote(0.8.18) -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css" rel="stylesheet">
</head>

<body class="subpage">
	<!-- Header -->
	<jsp:include page="/front-end/header/header.jsp" />
	<!-- Two -->
	<section id="two" class="wrapper style2">
		<div class="inner">
			<div class="box">
				<div class="content">
					<header class="align-center">
						<h2>
							<b>新增文章</b>
						</h2>
						<c:if test="${not empty errorMsgs}">
							<font style="color: red">請修正以下錯誤:</font>
							<ul>
								<c:forEach var="message" items="${errorMsgs}">
									<li style="color: red">${message}</li>
								</c:forEach>
							</ul>
						</c:if>
					</header>
					<div id="addform">
						<form METHOD="post" id="sendForm" ACTION="<%=request.getContextPath()%>/front-end/forum/fa.do">
							<p>
								<label for="topic">文章主題 :</label>
								<input type="text" id="faTopic" name="faTopic">
							</p>
							<p>
								<label for="content">文章內容 :</label>
								<textarea id="summernote" name="faContent"></textarea>
							</p>
							<p>
								<input type="hidden" name="action" value="insert">
								<input type="hidden" name="memId" value="${memVO.mem_id}">
							</p>
						</form>
						<input id="send" type="submit">
					</div>
				</div>
			</div>
		</div>
	</section>
	<!-- Footer -->
	<jsp:include page="/front-end/footer/footer.jsp" />
	<script src='<%=request.getContextPath()%>/js/jquery.min.js'></script>
	<script src="<%=request.getContextPath()%>/js/jquery.scrollex.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/skel.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/util.js"></script>
	<script src="<%=request.getContextPath()%>/js/main.js"></script>
	<!-- Footer -->
	<!-- include libraries(jQuery, bootstrap) -->
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
	<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.bundle.min.js"></script>
	<!-- include summernote css/js -->
	<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"></script>
	<script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/summernote.js" ></script>
	
	<script>
	$(document).ready(function(){
		$('#send').click(() => {
	        var url = window.location.href.substr(window.location.href.lastIndexOf('/')).substr(1);

	        if (url === "addFaPage.jsp") {
	            console.log("addFa");
	            if ($($("#summernote").summernote('code').replace(/&nbsp;|<br>/g, ' ')).text().trim() === '' || $('#faTopic').val().trim() === '') {
	                swal({
	                	title:"文章或內容請勿空白!!",
	                	icon:"warning"
	                })
	            } else {
	                $("#sendForm").submit();
	            }
	        } else {
	            console.log("other");
	            if ($($("#summernote").summernote('code').replace(/&nbsp;|<br>/g, ' ')).text().trim() === '') {
	            	 swal({
	                 	title:"文章或內容請勿空白!!",
	                 	icon:"warning"
	                 })
	            } else {
	                $("#sendForm").submit();
	            }
	        }

	    })
	})
	
	</script>
</body>

</html>