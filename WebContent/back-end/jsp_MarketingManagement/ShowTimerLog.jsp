<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ page import="tools.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="redis.clients.jedis.*"%>
<%@ page import="redis.clients.jedis.exceptions.JedisException"%>

<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
<!-- 自訂css -->
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/main-back.css" />
<!-- Bootstrap CSS -->
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/bootstrap.min.css" />
<style type="text/css">
table {
	table-layout: fixed;
	word-wrap: break-word;
}
</style>
<title>部客匣管理後台</title>
</head>
<body>
	<!-- header -->
	<%@include file="/back-end/header/header.jsp"%>
	<div id="container">
		<main id="center" class="column">
			<h1>排程事件紀錄</h1>
			<%
				Jedis jedis = null;
				// 取得Jedis連線資源
				try {
					SimpleRedisLogger logger = new SimpleRedisLogger();
					JedisPool pool = JedisUtil.getJedisPool();
					jedis = pool.getResource();
					jedis.auth("123456");
					List<Map.Entry<String, Date>> msgs = logger.getInfo(jedis, "TimerLog");
					// 歸還連線資源到Jedis連線池
					JedisUtil.closeJedis(jedis);
					pageContext.setAttribute("msgs", msgs);
				} catch (JedisException e) {
					// 歸還Redis連線資源
					JedisUtil.closeJedis(jedis);
					e.printStackTrace();
				}
			%>
			<c:choose>
				<c:when test="${msgs.size() > 0}">
					<!-- Table - Hoverable rows -->
					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col" style="width: 10%">時間</th>
								<th scope="col" style="width: 90%">訊息</th>
							</tr>
						</thead>
						<tbody>

							<c:forEach var="entry" items="${msgs}">
								<tr>
									<td>
										<fmt:formatDate value="${entry.value}" pattern="yyyy-MM-dd HH:mm:ss" />
									</td>
									<td>${entry.key}</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
				</c:when>
				<c:otherwise>
					<h3>無排程事件紀錄 :(</h3>
				</c:otherwise>
			</c:choose>

		</main>
		<%@include file="/back-end/sidebar/sidebar.jsp"%>
	</div>
	<!-- Optional JavaScript -->
	<!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <%@include file="/back-end/jsp_Common/jquery-popper-bootstrap-js.jsp"%>
</body>

</html>