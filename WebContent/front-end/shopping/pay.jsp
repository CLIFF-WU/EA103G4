<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="java.util.*"%>
<%@ page import="com.shping.model.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.payme.model.*"%>




<!DOCTYPE html>
<html>
<head>
<title>部客匣-結帳流程</title>
<meta charset="UTF-8">


<link rel="stylesheet" href="<%= request.getContextPath()%>/css/main-front.css" />
<link rel="stylesheet" href="<%= request.getContextPath()%>/css/header.css" />
<!--書城首頁CSS-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bookshop-eshop-index.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bootstrap.min.css">
<!--商品展示Slider CSS與字體-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/product-slider.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@500;700&display=swap" rel="stylesheet">
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/bookshop_index.css" />
<!--Header購物車、次Header搜尋欄-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-front-with-cart-and-search.css">
<!--下拉式書籍類別選單-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sm-core-css.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sm-clean.css">

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

<body>
<%-- 	統一版<jsp:include page="/front-end/header/header.jsp" /> --%>
	<jsp:include page="/front-end/header/header-with-cart.jsp" />
	<section id="One" class="wrapper style4">
	<!-- Eshop Header -->
	<div id="logoDiv">
		<%@include file="/front-end/header/eshop-header.jsp"%>
	</div>


	<div class="container">
		<div class="row">
			<!-- multistep form -->
			<div class="row mx-md-n6" id="main_in" style="text-algin: center; width: 100%;">

				<div class="container-fluid">
					<nav class="navbar navbar-light bg-light">
						<h2>
							<font>│ 結帳流程</font>
						</h2>

						<hr size="10px" align="center" width="100%">

						<%
							@SuppressWarnings("unchecked")
							List<Cart> cartlist = (Vector<Cart>) session.getAttribute("shpingcart");
							pageContext.setAttribute("cartlist", cartlist);

							String[] totalPrice = (String[]) session.getAttribute("getTotal");
							pageContext.setAttribute("totalPrice", totalPrice);

							MemVO memVO = (MemVO) session.getAttribute("memVO");
							pageContext.setAttribute("memVO", memVO);

							MemService memSvc = new MemService();
							MemVO memSvcVO = memSvc.getOneMem(memVO.getMem_id());
							pageContext.setAttribute("memSvcVO", memSvcVO);

							PayService paySvc = new PayService();
							List<PayVO> payVO = paySvc.getOneMemPay(memVO.getMem_id());
							pageContext.setAttribute("payVO", payVO);
						%>

						</nav>
						<FORM class="form-inline" name="checkFrom" method="POST"
							action="<%=request.getContextPath()%>/back-end/order/order.do">

							<div class="accordion" id="accordionExample" style="width: 100%;">
								<!-- 購物清單 -->

								<div class="card">
									<div class="card-header" id="headingOne">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left"
												type="button" data-toggle="collapse"
												data-target="#collapseOne" aria-expanded="true"
												aria-controls="collapseOne" onClick="listBtn()" id="cardBtn">＞
												購物車商品明細</button>
										</h2>
									</div>

									<div id="collapseOne" class="collapse show"
										aria-labelledby="headingOne" data-parent="#accordionExample">
										<div class="card-body">

											<table class="cartprd">
												<c:set var="count" scope="session" />

												<c:forEach var="cart" items="${cartlist}"
													varStatus="cartstatus">

													<tr>
														<!--項目 -->
														<td style="vertical-align: middle;"><h5>${count=count+1}</h5></td>
														<!--商品圖 -->
														<td id="imgTd" style="vertical-align: middle;"><img
															class="prdimgTd" alt="404 NOT FOUND"
															src="${pageContext.request.contextPath}/ShowBookPic?bookID=${cart.book_Id}">
														</td>
														<!--ISBN -->
														<td style="vertical-align: middle;">
															<h6>ISBN：${cart.isbn}</h6> <!--商品名稱  -->
															<h3>${cart.book_Name}</h3> <!--出版社  -->
															<h6>${cart.publisher_Id}</h6>
														</td>
														<!--購買數量  -->
														<td style="vertical-align: middle;"><h5>${cart.comm_Qty}個</h5></td>
														<!--價錢小計  -->
														<td style="vertical-align: middle;"><h5>
																TWD$
																<fmt:formatNumber type="number"
																	value="${cart.price*cart.comm_Qty}"
																	maxFractionDigits="0" />
															</h5></td>
														<!--單項獲得紅利  -->
														<td style="vertical-align: middle;"><h5>
																<fmt:formatNumber type="number"
																	value="${cart.book_BP*cart.comm_Qty}"
																	maxFractionDigits="0" />
																點
															</h5> <!-- input 商品資料 --> <input type="hidden" name="book_Id"
															value="${cart.book_Id}"> <input type="hidden"
															name="book_Name" value="${cart.book_Name}"> <input
															type="hidden" name="price"
															value="${cart.price*cart.comm_Qty}"> <input
															type="hidden" name="comm_Qty" value="${cart.comm_Qty}">
															<input type="hidden" name="book_BP"
															value="<fmt:formatNumber type="number" value="${cart.book_BP*cart.comm_Qty}" maxFractionDigits="0" />">

														</td>
												</c:forEach>

											</table>

											<div class="alert alert-info">
												<b>POINT： + <span id="prdtotal">${totalPrice[1]}</span></b><br>
												<b>小計(優惠已折)： TWD$ <span id="prdtotal">${totalPrice[0]}</span></b>
											</div>
										</div>
									</div>
								</div>

								<!-- 收件資訊 -->
								<div class="card">
									<div class="card-header" id="headingTwo">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left collapsed"
												type="button" data-toggle="collapse"
												data-target="#collapseTwo" aria-expanded="false"
												aria-controls="collapseTwo" onClick="listBtn2()"
												id="cardBtn2">＞ 收件資訊</button>
										</h2>
									</div>
									<div id="collapseTwo" class="collapse"
										aria-labelledby="headingTwo" data-parent="#accordionExample">
										<div class="card-body">
											<div class="form-row">
												<div class="form-group col-md-6">
													<label for="inputEmail4">收&nbsp;件&nbsp;人&nbsp;：&nbsp;</label><input
														type="text" class="form-control" id="rec_Name"
														name="rec_Name" size="10" value="${memSvcVO.mem_name}"
														placeholder="請填寫正確全名">
												</div>
												<div class="form-group col-md-6">
													<label for="inputPassword4">連絡電話：&nbsp;</label> <input
														type="Text" class="form-control" id="rec_Tel"
														name="rec_Tel" size="10" value="${memSvcVO.mem_tel}"
														placeholder="請填寫正確號碼">
												</div>

												<label for="inputAddress">收件地址：&nbsp;</label> <input
													type="text" class="form-control" id="rec_Add"
													name="rec_Add" size="50" value="${memSvcVO.mem_addr}"
													placeholder="請填寫正確地址">
											</div>
										</div>
									</div>
								</div>
								<!-- 付款資訊 -->
								<div class="card">
									<div class="card-header" id="headingThree">
										<h2 class="mb-0">
											<button class="btn btn-link btn-block text-left collapsed"
												type="button" data-toggle="collapse"
												data-target="#collapseThree" aria-expanded="false"
												aria-controls="collapseThree" onClick="listBtn3()"
												id="cardBtn3">＞ 付款資訊</button>
										</h2>
									</div>
									<div id="collapseThree" class="collapse"
										aria-labelledby="headingThree" data-parent="#accordionExample">
										<div class="card-body">

											<div class="input-group mb-3">
												<div class="input-group-prepend">
													<label class="input-group-text" for="inputGroupSelect01">收貨方式</label>
												</div>
												<select class="custom-select" name="delivery" id="delivery">
													<option selected>請選擇...</option>
													<option value="1">宅配</option>
													<option value="2">超商取貨</option>
												</select>
											</div>

											<div class="input-group mb-3">
												<div class="input-group-prepend">
													<label class="input-group-text" for="inputGroupSelect01">付款方式</label>
												</div>
												<select class="custom-select" name="order_Pay"
													id="order_Pay">
													<option selected>請選擇...</option>
													<option value="1">信用卡(一次付清)</option>
													<option value="2">貨到付款(運費100)</option>
												</select>
											</div>
											<!-- 信用卡彈出視窗 -->
											<div class="form-row">
												<hr size="10px" align="center" width="100%">
												<div class="form-group col-md-12">
													<label>信用卡資料</label> <input type="number" name="credit"
														value=""> <span for="pro">有效日期：</span> <input
														id="mm" type="text" list="MM" name="mm" placeholder="MM"
														maxlength="2"> / <input id="yy" type="text"
														list="YY" name="yy" placeholder="YY" maxlength="2">
													<datalist id="MM">
														<option value="1">01</option>
														<option value="2">02</option>
														<option value="3">03</option>
														<option value="4">04</option>
														<option value="5">05</option>
														<option value="6">06</option>
														<option value="7">07</option>
														<option value="8">08</option>
														<option value="9">09</option>
														<option value="10">10</option>
														<option value="11">11</option>
														<option value="12">12</option>
													</datalist>
													<datalist id="YY">
														<option value="20"></option>
														<option value="21"></option>
														<option value="22"></option>
														<option value="23"></option>
														<option value="24"></option>
														<option value="25"></option>
														<option value="26"></option>
														<option value="27"></option>
														<option value="28"></option>
														<option value="29"></option>
													</datalist>
												</div>
											</div>


											<!-- 紅利點數 -->
											<hr size="10px" align="center" width="100%">
											<div id=chelisInf>
												<span> ◎您累計的紅利點數：<span><b><fmt:formatNumber
																type="number" value="${memSvcVO.mem_bonus}" /></b> 點</span> <c:if
														test="${memSvcVO.mem_bonus >=1}">
																 , 使用：
													<input type="number" id="use_Bonus" name="use_Bonus"
															step="5" min="0" max="10000" value="0"
															style="width: 80px; height: 30px;">點
													<p>◎註： 1 Point = TWD $1</p>
													</c:if>
												</span>
											</div>

											<!-- 發票資料 -->
											<hr size="10px" align="center" width="100%">
											<div id=vehicle>
												<span> ◎電子載具歸戶：</span> <input type="text" id="use_Bonus"
													max="8" size="8" value="/HBHNTYT">
											</div>

											<!-- 備註 -->
											<hr size="10px" align="center" width="100%">
											<div id=mem_Note>
												<span> 備註</span> <input type="text" id="mem_Note"
													name="mem_Note" max="10000" style="height: 80px;">

											</div>

										</div>
									</div>
								</div>

								<!-- 帳務資訊 -->
								<hr size="10px" align="center" width="100%">
								<div class="alert alert-secondary" align="center">
									<div class="container"></div>
									<div class="alert">
										<h3 class="display-5">本次訂單金額：${totalPrice[0]}</h3>
									</div>

									<div class="alert">
										<!-- input 訂單資料 -->
										<input type="hidden" name="mem_Id" value="${memVO.mem_id}">
										<%-- 	<input type="hidden" name="mem_Bonus" value="${memSvcVO.mem_bonus}"> --%>
										<input type="hidden" name="order_Total"
											value="${totalPrice[0]}"> <input type="hidden"
											name="get_Bonus" value="${totalPrice[1]}"> <input
											type="hidden" name="order_Qty" value="${count}"> <input
											type="hidden" name="action" value="PAY">
										<button type="submit" class="btn btn-sm btn-outline-secondary"
											style="font-size: 16px;">確認結帳</button>

									</div>

								</div>
							</div>
						</FORM>
					
				</div>
			</div>

		</div>
	</div>
	</section>
		<jsp:include page="/front-end/footer/footer.jsp" />
	<script
		src="<%=request.getContextPath()%>/js/stopExecutionOnTimeout.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.easing.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/js/jquery.datetimepicker.full.js"></script>
	<script>
		function listBtn() {
			var listBtn = document.getElementById('cardBtn');
			var listext = document.getElementById('collapseOne');
			if (listext.style.display !== 'block') {
				listext.style.display = 'block';
			} else {
				listext.style.display = 'none';
			}
		}
		function listBtn2() {
			var listBtn2 = document.getElementById('cardBtn2');
			var listext2 = document.getElementById('collapseTwo');
			if (listext2.style.display !== 'block') {
				listext2.style.display = 'block';
			} else {
				listext2.style.display = 'none';
			}
		}
		function listBtn3() {
			var listBtn3 = document.getElementById('cardBtn3');
			var listext3 = document.getElementById('collapseThree');
			if (listext3.style.display !== 'block') {
				listext3.style.display = 'block';
			} else {
				listext3.style.display = 'none';
			}
		}
	</script>

</body>
</html>