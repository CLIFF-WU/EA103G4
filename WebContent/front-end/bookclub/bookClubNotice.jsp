<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="com.mem.model.*"%>
<%@ page import="com.bookclub.model.*"%>
<%@ page import="com.bookclub_regis_detail.model.*"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Notice Page</title>

<link rel="stylesheet" href="<%=request.getContextPath()%>/css/naranja.min.css">

</head>
<body onload="connect();" onunload="disconnect();">

<script src="<%=request.getContextPath()%>/js/naranja.min.js"></script>
<script src="<%=request.getContextPath()%>/js/jquery.min.js"></script>
<script>
		var MyPointNotice = "/NoticeWS/${memVO.mem_id}";
		var hostNotice = window.location.host;
		var pathNotice = window.location.pathname;
		var webCtxNotice = pathNotice.substring(0, pathNotice.indexOf('/', 1));
		var endPointURLNotice = "ws://" + window.location.host + webCtxNotice + MyPointNotice;

		var webSocketNotice;
			 
			function connect() {
				webSocketNotice = new WebSocket(endPointURLNotice);
				
		       		webSocketNotice.onopen = (e) => {
		        	}
		       		webSocketNotice.onmessage = (e) => {
		       			var jobj = JSON.parse(e.data);
		       			if("signIn" === jobj.situtaion){
		       				signIn(jobj);
		       			}
		       			if("successVerify" === jobj.situtaion){
		       				successNotice(jobj);
		       			}
		       			if("failVerify" === jobj.situtaion){
		       				failNotice(jobj);
		       			}
		        	}
		        	webSocketNotice.onclose = (e) => {
		        	}
				}
		    

		    function disconnect() {
		        webSocketNotice.close();
		    }
		    function sendAddBookClubMessage() {
		    	var jobj = {
		                bc_id: '${listOneBookClub.bc_id}',
		                bc_name: '${listOneBookClub.bc_name}',
		                message: "讀書會報名",
		                received: '${listOneBookClub.mem_id}',
		                mem_name: '${memVO.mem_name}',
		                situtaion: 'signIn',
		                type: "private"
		            };
		    	setTimeout(function(){
		    			webSocketNotice.send(JSON.stringify(jobj));
		    	},1000)
	   		}
			function successVerify(e){
				var jobj = {
		                bc_id: '${listOneBookClub.bc_id}',
		                bc_name: '${listOneBookClub.bc_name}',
		                message: "恭喜你審核通過",
		                received: $(e).prev().val(),
		                situtaion: "successVerify",
		                type: "private"
		            };
		        webSocketNotice.send(JSON.stringify(jobj));
			}
			function failVerify(e){
				var jobj = {
		                bc_id: '${listOneBookClub.bc_id}',
		                bc_name: '${listOneBookClub.bc_name}',
		                message: "不好意思 您的審核沒通過",
		                received: $(e).prev().val(),
		                situtaion: "failVerify",
		                type: "private"
		            };
		        webSocketNotice.send(JSON.stringify(jobj));
			}
		    function successNotice (e){
		    	naranja()['success']({
	       		      title: e.bc_name + '審核通知',
	       		      text: e.message,
	       		      timeout: 'keep',
	       		    })
		    }
		    function failNotice (e){
		    	naranja()['error']({
	       		      title: e.bc_name + '審核通知',
	       		      text: e.message,
	       		      timeout: 'keep',
	       		    })
		    }
		    function signIn (e){
		    	naranja()['log']({
	       		      title: e.bc_name + '加入通知',
	       		      text: e.mem_name + "報名了此讀書會，請盡快審核",
	       		      timeout: 'keep',
	       		    })
		    }
	</script>
</body>
</html>