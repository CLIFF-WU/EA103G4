<%@ page contentType="text/html; charset=UTF-8" pageEncoding="Big5"%>
<!DOCTYPE html>
<html>

<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">
<meta http-equiv="Pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache">
<meta http-equiv="Expires" content="0">
<title>�n�J���\</title>
<!-- BOOSTRAP CSS -->
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/vendors/styles/core.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/vendors/styles/icon-font.min.css">
<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/vendors/styles/style.css">
<!-- �ۭqCSS -->
<style type="text/css">
.main-container {
	padding-left: 270px;
	padding-top: 80px;
	padding-right: 30px;
}
</style>
</head>

<body>
	<jsp:include page="/back-end/header/header.jsp" />
	<div class="main-container">
		<main>
			<div class="pd-20 card-box mb-30">
				<div class="clearfix mb-20">
					<div class="pull-left">
						<h1 class="text-danger h1">
							<b>�n�J���\ !</b>
						</h1>
					</div>
				</div>
				<table class="table">
						<tr>
							<td>
								<div>
									<h2 class="text-secondary">�C��@�y:</h2>
								</div> <br>
								<div>
									<h2 class="text-dark">
										�ȤW�o�Ӳ�ı�L,<br>&nbsp;&nbsp;�������ƥ��`��
									</h2>
								</div>
							</td>
							<td>
								<div class="pull-center">
									<img src="<%=request.getContextPath()%>/images/login/wu.jpg"
										width="500px" height="500px">
								</div>
							</td>
						</tr>
				</table>
			</div>
		</main>
	</div>
	<jsp:include page="/back-end/sidebar/sidebar.jsp" />
</body>

</html>