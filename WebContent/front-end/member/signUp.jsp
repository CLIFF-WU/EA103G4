<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.mem.controller.*"%>

<%
	MemVO memVO = (MemVO) request.getAttribute("memVO");
%>


<html lang="en">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1" />
<title>BOOKSHOP部客匣</title>

<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/main-front.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/header.css" />

<link rel="stylesheet" type="text/css"
	href="<%=request.getContextPath()%>/css/jquery.datetimepicker.css" />
<link rel="stylesheet"
	href="<%=request.getContextPath()%>/css/signUp.css" />

</head>

<body>
	<jsp:include page="/front-end/header/header.jsp" />

	<div id="wrapper">
		<div id="formBlock">
			<form METHOD="post"
				ACTION="<%=request.getContextPath()%>/mem/mail.do"
				enctype="multipart/form-data" onchange="loadImageFile(event)">
				<fieldset id="myFieldset">
					<legend>SIGN UP</legend>
					<div id="fontSpace">
						<div id="font1">如果您還沒成為BOOKSHOP會員</div>
						<div id="font2">請填下您的個人資料，成為我們的會員吧。</div>

					</div>
					<div id="Data-Content">
						<div id="Data-Title">
							<div id="AlignRight">
								<div>
									<label><span>*</span>會員帳號</label>
								</div>
								<div>
									<label><span>*</span>密碼</label>
								</div>
								<div>
									<label><span>*</span>確認密碼</label>
								</div>
								<div>
									<label><span>*</span>姓名</label>
								</div>
								<div>
									<label><span>*</span>E-MAIL</label>
								</div>
								<div>
									<label>暱稱</label>
								</div>
								<div>
									<label><span>*</span>性別</label>
								</div>
								<div>
									<label><span>*</span>生日</label>
								</div>
								<div>
									<label><span>*</span>住址</label>
								</div>
								<div>
									<label><span>*</span>電話</label>
								</div>
								<div>
									<label>上傳大頭照</label>
								</div>
							</div>
						</div>
						<div id="Data-Items">
							<div class="input-div">
								<input type="text" id="account" placeholder="請輸入帳號"
									name="mem_account"
									value="<%=(memVO == null) ? "" : memVO.getMem_account()%>" />
								<div class="errorMsg" id="msg"></div>
								<c:if test="${not empty errorMsgs.account}">
									<div class="errorMsg" id="msg">${errorMsgs.account}</div>
								</c:if>
							</div>
							<div class="input-div">
								<input type="password" id="psw" placeholder="請輸入密碼"
									name="mem_password" />
								<c:if test="${not empty errorMsgs.password}">
									<div class="errorMsg">${errorMsgs.password}</div>
								</c:if>
							</div>
							<div class="input-div">
								<input type="password" id="confirmpsw" placeholder="請再次輸入密碼"
									name="confirPassword" />
								<div class="errorMsg" id="pswmsg"></div>

							</div>
							<div class="input-div">
								<input type="text" id="name" placeholder="請輸入姓名" name="mem_name"
									value="<%=(memVO == null) ? "" : memVO.getMem_name()%>" />
								<c:if test="${not empty errorMsgs.name}">
									<div class="errorMsg">${errorMsgs.name}</div>
								</c:if>
							</div>
							<div class="input-div">
								<input type="email" id="email" placeholder="請輸入E-MAIL"
									name="mem_email"
									value="<%=(memVO == null) ? "" : memVO.getMem_email()%>" />
								<div class="errorMsg" id="emailmsg"></div>
								<c:if test="${not empty errorMsgs.email}">
									<div class="errorMsg">${errorMsgs.email}</div>
								</c:if>
							</div>
							<div class="input-div">
								<input type="text" id="nickname" placeholder="請輸入暱稱"
									name="mem_nickname"
									value="<%=(memVO == null) ? "" : memVO.getMem_nickname()%>" />
							</div>
							<div class="input-div">
								<input id="sex" list="sexlist" placeholder="請選擇你的性別"
									name="mem_sex" />
								<datalist id="sexlist">
									<option value="男">男</option>
									<option value="女">女</option>
								</datalist>
								<c:if test="${not empty errorMsgs.sex}">
									<div class="errorMsg">${errorMsgs.sex}</div>
								</c:if>
							</div>
							<div class="input-div">
								<!-- 								<input type="text" name="mem_birth" -->
								<%-- 									value="<%=(memVO == null) ? "" : memVO.getMem_birth()%>" id="f_date1" /> --%>
								<%-- 								<c:if test="${not empty errorMsgs.birth}"> --%>
								<%-- 									<div class="errorMsg">${errorMsgs.birth}</div> --%>
								<%-- 								</c:if> --%>
								<input type="date" name="mem_birth"
									value="<%=(memVO == null) ? "" : memVO.getMem_birth()%>"
									id="f_date1" />
								<c:if test="${not empty errorMsgs.birth}">
									<div class="errorMsg">${errorMsgs.birth}</div>
								</c:if>
							</div>
							<div class="input-div">
								<input type="text" id="addr" placeholder="請輸入地址" name="mem_addr"
									value="<%=(memVO == null) ? "" : memVO.getMem_addr()%>" />
								<c:if test="${not empty errorMsgs.addr}">
									<div class="errorMsg">${errorMsgs.addr}</div>
								</c:if>
							</div>
							<div class="input-div">
								<input type="tel" id="tel" placeholder="請輸入電話" name="mem_tel"
									value="<%=(memVO == null) ? "" : memVO.getMem_tel()%>" /><br />
								<c:if test="${not empty errorMsgs.tel}">
									<div class="errorMsg">${errorMsgs.tel}</div>
								</c:if>
							</div>
							<div class="input-div-file">
								<span id="personalpic"> <img id="image"
									src="<%=request.getContextPath()%>/images/member/0.png" />
								</span> <input type="file" name="mem_pic" id="myFile" />
							</div>
							<div id="nothing">* 為必填欄位，請填妥欄位資訊。</div>
							<div>
								<input type="hidden" name="from"
									value="bookshop.ea103@gmail.com" /> <input type="hidden"
									name="subject" value="註冊驗證碼" />
								<button type="submit" class="btn" id="btn-submit">SUBMIT</button>
							</div>
						</div>
					</div>
				</fieldset>
			</form>
		</div>
	</div>
	<jsp:include page="/front-end/footer/footer.jsp" />

	<script src='<%=request.getContextPath()%>/js/jquery.min.js'></script>
	<script
		src="<%=request.getContextPath()%>/js/jquery.datetimepicker.full.js"></script>


	<script>
		$.datetimepicker.setLocale('zh');
		$('#f_date1').datetimepicker({
			theme : '', //theme: 'dark',
			timepicker : false, //timepicker:true,
			step : 1, //step: 60 (這是timepicker的預設間隔60分鐘)
			format : 'Y-m-d', //format:'Y-m-d H:i:s',
			value : new Date()
		// value:   new Date(),
		//disabledDates:        ['2017/06/08','2017/06/09','2017/06/10'], // 去除特定不含
		//startDate:	            '2017/07/10',  // 起始日
		//minDate:               '-1970-01-01', // 去除今日(不含)之前
		//maxDate:               '+1970-01-01'  // 去除今日(不含)之後
		});

		var somedate2 = new Date();
		$('#f_date1')
				.datetimepicker(
						{
							beforeShowDay : function(date) {
								if (date.getYear() > somedate2.getYear()
										|| (date.getYear() == somedate2
												.getYear() && date.getMonth() > somedate2
												.getMonth())
										|| (date.getYear() == somedate2
												.getYear()
												&& date.getMonth() == somedate2
														.getMonth() && date
												.getDate() > somedate2
												.getDate())) {
									return [ false, "" ]
								}
								return [ true, "" ];
							}
						});

		function loadImageFile(event) {
			var image = document.getElementById('image');
			image.src = URL.createObjectURL(event.target.files[0]);
		};

		window.onload = function() {
			var mem_account = document.getElementsByName("mem_account")[0];
			var mem_email = document.getElementsByName("mem_email")[0];
			//为昵称选项注册onblur事件
			mem_account.onblur = function() {
				var mem_account = this.value;
				//1.获取XMLHttpRequest对象
				var req = getXMLHttpRequest();
				//4.处理响应结果
				req.onreadystatechange = function() {
					if (req.readyState == 4) {//XMLHttpRequest对象读取成功
						if (req.status == 200) {//服务器相应正常
							var msg = document.getElementById("msg");
							var btn = document.getElementById("btn-submit");
							//根据返回的结果显示不同的信息
							if (req.responseText === "true") {
								msg.innerText = "👎🏻此帳號已被註冊";
								btn.disabled = true;
							} else {
								msg.innerHTML = "<font color='green'>👌🏻此帳號可以使用</font>";
								btn.disabled = false;
							}
						}
					}
				}
				//2.建立一个连接
				req.open("get",
						"${pageContext.request.contextPath}/mem/AccountCheck.do?mem_account="
								+ mem_account);
				//3.发送get请求
				req.send(null);
			}

			mem_email.onblur = function() {
				var mem_email = this.value;
				//1.获取XMLHttpRequest对象
				var req = getXMLHttpRequest();
				//4.处理响应结果
				req.onreadystatechange = function() {
					if (req.readyState == 4) {//XMLHttpRequest对象读取成功
						if (req.status == 200) {//服务器相应正常
							var emailmsg = document.getElementById("emailmsg");
							var emailRule = /^\w+((-\w+)|(\.\w+))*\@[A-Za-z0-9]+((\.|-)[A-Za-z0-9]+)*\.[A-Za-z]+$/;
							var btn = document.getElementById("btn-submit");
							//根据返回的结果显示不同的信息
							if (req.responseText === "true") {
								emailmsg.innerText = "👎🏻此E-Mail已被註冊";
								btn.disabled = true;
							} else if (mem_email.search(emailRule) == -1) {
								emailmsg.innerText = "👎🏻此E-Mail格式不正確";
								btn.disabled = true;
							} else {
								emailmsg.innerHTML = "<font color='green'>👌🏻此E-Mail可以使用</font>";
								btn.disabled = false;
							}
						}
					}
				}
				//2.建立一个连接
				req.open("get",
						"${pageContext.request.contextPath}/mem/EmailCheck.do?mem_email="
								+ mem_email);
				//3.发送get请求
				req.send(null);
			}

			var psw = document.getElementById("psw");
			var confirmpsw = document.getElementById("confirmpsw");

			function validatePassword() {
				var pswmsg = document.getElementById("pswmsg");
				var btn = document.getElementById("btn-submit");
				if (psw.value != confirmpsw.value && confirmpsw.value != "") {
					pswmsg.innerText = "密碼不一致";
					btn.disabled = true;
				} else if (psw.value != "" && confirmpsw.value == "") {
					pswmsg.innerText = "請確認密碼";
					btn.disabled = true;
				} else if (psw.value != "" && confirmpsw.value != "") {
					pswmsg.innerHTML = "<font color='green'>OK</font>";
					btn.disabled = false;
				} else {
					pswmsg.innerText = "";
				}

			}
			psw.onchange = validatePassword;
			confirmpsw.onkeyup = validatePassword;
		}

		function getXMLHttpRequest() {
			var xmlhttp;
			if (window.XMLHttpRequest) {// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp = new XMLHttpRequest();
			} else {// code for IE6, IE5
				xmlhttp = new ActiveXObject("Microsoft.XMLHTTP");
			}
			return xmlhttp;
		}
	</script>



	<script src="<%=request.getContextPath()%>/js/skel.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/util.js"></script>
	<script src="<%=request.getContextPath()%>/js/main.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.jquery.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/jquery.scrollex.min.js"></script>


</body>

</html>