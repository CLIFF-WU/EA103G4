<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<!DOCTYPE html>
<html>

<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 自訂css -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bookManagement.css" />
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<!-- jQuery AutoCompelete -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
<script src="${pageContext.request.contextPath}/js/jquery.auto-complete.min.js"></script>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/jquery.auto-complete.css" />

<title>編輯書籍統計資料</title>
</head>

<body>
	<!--表單內容-->
	<main class="col-md-12" style="margin: 0 auto;">
		<h1 style="display: inline;">編輯書籍統計資料</h1>
		<div style="position: relative; float: right; display: inline;">
			<a href="${pageContext.request.contextPath}/RecommManagement">返回推薦管理首頁</a>
		</div>
		<hr>
		<form role="form" id="updateRecommKey" action="${pageContext.request.contextPath}/UpdateRecommKey?keyName=${recommKey.keyName}" method="post">
			<div class="form-row">
				<div class="col-md-12">
					<div class="form-row">
						<div class="col-md-4">
							<label for="keyName">Key Name</label>
							<h3 id="keyName">
								<a href="${pageContext.request.contextPath}/ShowRecommKeyDetails?keyName=${recommKey.keyName}">${recommKey.keyName}</a>
							</h3>
						</div>
						<div class="col-md-4">
							<label for="size">Size</label>
							<h3 id="size">${recommKey.size}</h3>
						</div>
						<div class="col-md-4">
							<label for="ttl">TTL</label>
							<h3 id="ttl">${recommKey.ttl}</h3>
						</div>
						<div class="col-md-4">
							<label for="bookID">Book ID</label>
							<c:choose>
								<c:when test="${param.bookID eq null}">
								    <input type="text" id='bookID' name='bookID' class="form-control" value="${param.bookID}"  maxlength="12" required>
								</c:when>
								<c:otherwise>
								    <input type="text" class="form-control" value="${param.bookID}" maxlength="12" required disabled>
								    <input type="hidden" id='bookID' name='bookID' class="form-control" value="${param.bookID}"  maxlength="12" required>
								</c:otherwise>
							</c:choose>
						</div>
						<div class="col-md-2">
							<label for="count">Count</label>
							<input type="number" id='count' name='count' min="0" class="form-control" value="${count}" required>
						</div>
					</div>
					<c:choose>
					   <c:when test="${param.bookID eq null}">
					       <button type="submit" id="submitBtn" class="btn btn-danger btn-block" style="position: relative; top: 1em" disabled>確認送出</button>
					   </c:when>
					   <c:otherwise>
					       <button type="submit" id="submitBtn" class="btn btn-danger btn-block" style="position: relative; top: 1em">確認送出</button>
					   </c:otherwise>
					</c:choose>
				</div>
			</div>
		</form>
	</main>
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>

	<%
		pageContext.setAttribute("errorMsgs", (ArrayList<String>) request.getAttribute("errorMsgs"));
		pageContext.setAttribute("successMsg", (String) request.getAttribute("successMsg"));
	%>
	<div id="msgDiv" class="col-md-12" style="color:red;">
		<c:if test="${errorMsgs.size()>0}">
			<script type="text/javascript">
				alert("${errorMsgs}");
			</script>
		</c:if>
	</div>

	<script type="text/javascript">
		$(function(){
			$("#bookID").autocomplete({
				source: function(request, response) {
					$.ajax({
						url: "${pageContext.request.contextPath}/UpdateRecommKey?keyName=${recommKey.keyName}",
					    type: "POST",
					    data: {
					    	term: request.term
					    },
					    dataType: "json",
					    success: function(data) {
					    	response(data);
					    }
					});
				},
				select: function(event, ui) {
		            $("#bookID").val(ui.item.value);
					return false;
				}
			});
		});
		
		$("#bookID").on('change keyup paste', function() {
			let bookID = $(this).val();
			if (bookID.length === 12) {
				$.ajax({
					type: 'post',
					url: '${pageContext.request.contextPath}/UpdateRecommKey?keyName=${recommKey.keyName}',
					data: {
						checkBookID: $("#bookID").val()
					}, 
					success: function(msg) {
						$('#submitBtn').attr("disabled", false);
						$('#msgDiv').css('color', 'green');
						$('#msgDiv').text(msg);
					},
					error: function(msg) {
						$('#submitBtn').attr("disabled", true);
						$('#msgDiv').css('color', 'red')
						$('#msgDiv').text("此商品ID不存在資料庫中");
					}
				});
			}
		});
	</script>
</body>
</html>