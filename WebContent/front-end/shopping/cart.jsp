<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.shping.model.*"%>
<%@ page import="com.mem.model.*"%>

<!DOCTYPE html>
<html>
<head>
<title>我的部客匣購物車</title>
<meta charset="UTF-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- 	購物車每分鐘刷新一次 -->
<meta http-equiv="refresh" content="60">



<link rel="stylesheet" href="<%= request.getContextPath()%>/css/main-front.css" />
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/header.css" />
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/memSpace.css" />
<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bootstrap.min.css">
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/bookshop_index.css" />

<script>
	window.console = window.console || function(t) {
	};
</script>
<script>
	if (document.location.search.match(/type=embed/gi)) {
		window.parent.postMessage("resize", "*");
	}
</script>

</head>

<body translate="no" class="subpage" style="background-color: #EBE5D9;">
	<jsp:include page="/front-end/header/header.jsp" />


	<div class="container">
		<main id="center" class="column">
			<div class="container-fluid">
				<div class="row">
					<!-- multistep form -->
					<div class=" col-md-12" id="main_in">

						<div class="container-fluid">
							<nav class="navbar navbar-light bg-light">
								<h2><font>│ 鑲 金 購 物 車</font></h2>

								<hr size="10px" align="center" width="100%">

								<%
									@SuppressWarnings("unchecked")
									List<Cart> cartlist = (Vector<Cart>) session.getAttribute("shpingcart");
									String[] totalPrice = (String[]) session.getAttribute("getTotal");
									pageContext.setAttribute("totalPrice", totalPrice);
									pageContext.setAttribute("cartlist", cartlist);
									MemVO memVO = (MemVO)session.getAttribute("memVO");
								%>
									
								<%	
									if (memVO.getMem_id() != null) {
									if (cartlist != null && cartlist.size() > 0) {
								%>
								<c:set var="count" scope="session"/>

								<table class="cartprd">
									
									<c:forEach var="cart" items="${cartlist}"
										varStatus="cartstatus" >
										
										<tr >
											<!--項目 -->
											<td style="vertical-align:middle;"><h5>${count=count+1}</h5></td>
											<!--商品圖 -->
											<td id="imgTd" style="vertical-align:middle;">
									<img class="prdimgTd" alt="404 NOT FOUND"
										src="${pageContext.request.contextPath}/ShowBookPic?bookID=${cart.book_Id}">
								</td>
											<!--ISBN -->
											<td style="vertical-align:middle;">
												<h6>ISBN：${cart.isbn}</h6> <!--商品名稱  -->
												<h3>${cart.book_Name}</h3> <!--出版社  -->
												<h6>${cart.publisher_Id}</h6></td>
											<!--購買數量  -->
											<td style="vertical-align:middle;"><h5>${cart.comm_Qty}個</h5></td>
											<!--價錢小計  -->
											<td style="vertical-align:middle;"><h5>
													TWD$
													<fmt:formatNumber type="number"
														value="${cart.price*cart.comm_Qty}" maxFractionDigits="0" />
												</h5></td>
											<!--單項獲得紅利  -->
											<td style="vertical-align:middle;"><h5>
											<fmt:formatNumber type="number"
																value="${cart.book_BP*cart.comm_Qty}"
																maxFractionDigits="0" />點</h5></td>
																
											<!--刪除商品  -->
											<td style="vertical-align:middle;"><div class="cardright">
													<FORM class="form-inline" name="delFrom" method="POST"
														action="<%=request.getContextPath()%>/Shopping.html">
														<input type="hidden" name="action" value="DEL"> <input
															type="hidden" name="del" value="${cartstatus.index}">
														<button class="btn btn-sm btn-outline-secondary"
															type="submit" style="width: 25px; height: 25px;">X</button>
													</FORM>
												</div></td>
										</tr>

									</c:forEach>
									
								</table>
									<div id=chelisBtn>
										<button class="btn btn-sm btn-outline-secondary"
											onClick="self.location.href='index.jsp'">繼續選購</button>
									</div>
									<div id=chelisInf>
										<p>
											總金額(活動優惠已折扣)：<span id="prdtotal">${totalPrice[0]}</span>
										</p>
									</div>
									<!-- 結帳 -->
									<div id=chelisBtn>
										<FORM class="form-inline" name="checkFrom" method="POST"
											action="<%=request.getContextPath()%>/Shopping.html">
											<!-- 訂單資訊 -->
											
											<input type="hidden" name="action" value="PAYCHECK">
												
											<button class="btn btn-sm btn-outline-secondary"
												type="submit">下一步</button>
										</FORM>
									</div>


								<%
									} else {
								%>
								<a style="color: #668787; font-size: 20px; text-aglin: center;">
								<c:out value="購物車空空der...與您的腦一樣ＱＱ" /></a>
								<%
									}}else{
								%>
<%-- 								<jsp:forward page="/front-end/member/signIn.jsp" /> --%>
								<jsp:forward page="/front-end/shopping/index.jsp"/>
								
								<%} %>
							</nav>
						</div>
					</div>
				</div>
				</div>
		</main>
	</div>
		<jsp:include page="/front-end/footer/footer.jsp" />
	<script
		src="<%=request.getContextPath()%>/js/stopExecutionOnTimeout.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.easing.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/js/jquery.datetimepicker.full.js"></script>


</body>
</html>