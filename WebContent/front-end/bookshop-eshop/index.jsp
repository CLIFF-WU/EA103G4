<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.*"%>
<%@ page import="com.book.model.*"%>
<%@ page import="com.adver.model.*"%>
<%@ page import="com.category.model.*"%>
<%@ page import="com.promo.model.*"%>
<%@ page import="com.promodetail.model.*"%>
<%@ page import="java.util.concurrent.ThreadLocalRandom"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>部客匣Bookshop</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main-front.css" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header.css" />
<!--書城首頁CSS-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bookshop-eshop-index.css" />
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z" crossorigin="anonymous">
<!--商品展示Slider CSS與字體-->
<link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.1.0/css/all.css" integrity="sha384-lKuwvrZot6UHsBSfcMvOkWwlCMgc0TaWr+30HWe3a4ltaBwTZhyTEggF5tJv8tbt" crossorigin="anonymous">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/product-slider.css">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/animate.css/3.5.2/animate.min.css">
<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@500;700&display=swap" rel="stylesheet">
<!--Header購物車、次Header搜尋欄-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/header-front-with-cart-and-search.css">
<!--下拉式書籍類別選單-->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sm-core-css.css">
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/sm-clean.css">

</head>

<body>
	<!-- Header With Cart-->
	<%@include file="/front-end/header/header-with-cart.jsp"%>
	<section id="One" class="wrapper style4">
		<!-- Eshop Header -->
		<div id="logoDiv">
			<%@include file="/front-end/header/eshop-header.jsp"%>
		</div>
		<!-- Eshop Body -->
		<div class="col-md-8" id="bookshop-body">
			<!-- Advertisements1 -->
			<%
				// AdService取用邏輯待改善
				AdService adService = new AdService();
				List<AdVO> ads = adService.getAll();
				request.setAttribute("adList1", ads.subList(0, ads.size() / 2));
				request.setAttribute("adList2", ads.subList((ads.size() / 2), ads.size()));
			%>
			<jsp:include page="/front-end/bookshop-eshop/adSliderHorizontal.jsp">
				<jsp:param name="type" value="adList1" />
			</jsp:include>
			<!-- End of Advertisements1 -->
			<hr>
			<%
				// 待Redis銷售統計完成再修正bestsellers取得方式
				BookService bookService = (BookService) getServletContext().getAttribute("bookService");
				PromoDetailService promoDetailService = (PromoDetailService) getServletContext()
						.getAttribute("promoDetailService");
				PromoService promoService = (PromoService) getServletContext().getAttribute("promoService");

				List<Book> popularBooks = bookService.getPopularBooks(30, 500);
				// 待名人收藏書單完成再修正celebrityBooks取得方式
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("publisherName", "歐萊禮");
				map.put("bookName", "python");
				List<Book> celebrityBooks = bookService.getByAdvSearch(map, true);
				Collections.shuffle(celebrityBooks);

				List<Book> promoBooks = bookService.getPromoBooks(30, promoDetailService, promoService);
				List<Book> newBooks = bookService.getNewBooks(30);

				// 將bestsellers等slider需要的物件設定在request scope，使productSlider.jsp取出
				request.setAttribute("popularBooks", popularBooks);
				request.setAttribute("celebrityBooks", celebrityBooks);
				request.setAttribute("promoBooks", promoBooks);
				request.setAttribute("newBooks", newBooks);

				// 需傳入自訂名稱的書籍清單，並把type參數設定為此名稱，title參數則為顯示標題
			%>
			<!-- Popular Books -->
			<jsp:include page="/front-end/bookshop-eshop/productSlider.jsp">
				<jsp:param name="title" value="熱門書籍" />
				<jsp:param name="type" value="popularBooks" />
			</jsp:include>
			<!-- End of Popular Books -->
			<hr>
			<!-- Celebrity Books -->
			<jsp:include page="/front-end/bookshop-eshop/productSlider.jsp">
				<jsp:param name="title" value="逸洪的私房書單" />
				<jsp:param name="type" value="celebrityBooks" />
			</jsp:include>
			<!-- End of Celebrity Books -->
			<hr>
			<br>
			<!-- Advertisements2 -->
			<jsp:include page="/front-end/bookshop-eshop/adSliderHorizontal.jsp">
				<jsp:param name="type" value="adList2" />
			</jsp:include>
			<!-- End of Advertisements2 -->
			<hr>
			<!-- Promo Products -->
			<c:if test="${promoBooks.size() > 0}">
				<jsp:include page="/front-end/bookshop-eshop/productSlider.jsp">
					<jsp:param name="title" value="特惠主題" />
					<jsp:param name="type" value="promoBooks" />
				</jsp:include>
				<!-- End of Promo Products -->
				<hr>
			</c:if>
			<!-- New Books -->
			<jsp:include page="/front-end/bookshop-eshop/productSlider.jsp">
				<jsp:param name="title" value="注目新品" />
				<jsp:param name="type" value="newBooks" />
			</jsp:include>
			<!-- End of New Books -->
		</div>
		<!-- End of Eshop Body -->
	</section>
	<!-- Footer -->
	<%@include file="/front-end/footer/footer.jsp"%>
	<!-- Scripts -->
	<script src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
	<script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js" integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN" crossorigin="anonymous"></script>
	<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js" integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV" crossorigin="anonymous"></script>
	<script src="${pageContext.request.contextPath}/js/jquery.scrollex.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/skel.min.js"></script>
	<script src="${pageContext.request.contextPath}/js/util.js"></script>
	<script src="${pageContext.request.contextPath}/js/main.js"></script>
	<!--carousel slider滑入滑出顯示contorls-->
	<script src="${pageContext.request.contextPath}/js/carousel-control-react.js"></script>
	<!--Header進階搜尋toggle顯示/隱藏表單、一般搜尋按鈕註冊-->
	<script src="${pageContext.request.contextPath}/front-end/header/header-search-bar-js.jsp"></script>
	<!--Header下拉式書籍類別選單-->
	<script src="${pageContext.request.contextPath}/js/jquery.smartmenus.min.js"></script>
	<!--錯誤訊息提示-->
	<%
		List<String> errorMsgs = (ArrayList<String>) request.getAttribute("errorMsgs");
		pageContext.setAttribute("errorMsgs", errorMsgs);
	%>
	<c:if test="${errorMsgs.size()>0}">
		<script type="text/javascript">
			alert("${errorMsgs}");
		</script>
	</c:if>
</body>

</html>