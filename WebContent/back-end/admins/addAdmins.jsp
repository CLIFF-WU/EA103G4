<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="com.admins.model.*"%>
<%
  AdminsVO adminsVO = (AdminsVO) request.getAttribute("adminsVO");
%>
<!DOCTYPE html>
<html>

<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>新增員工資料</title>
    <!-- CSS -->
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendors/styles/core.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendors/styles/icon-font.min.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/src/plugins/jquery-steps/jquery.steps.css">
    <link rel="stylesheet" type="text/css" href="<%=request.getContextPath()%>/vendors/styles/style.css">
    <style>
        .main-container {
  padding: 80px 30px 100px 270px
}

#preview img {
  height: 200px;
  width: 200px;
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
</style>
    <!-- 下拉式地址 -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.0/jquery.min.js"></script>
    <script src="<%=request.getContextPath()%>/js/jquery.twzipcode.min.js"></script>
</head>

<body>
    <jsp:include page="/back-end/header/header.jsp" />
    <div class="main-container">
        <div class="pd-ltr-20 xs-pd-20-10">
            <div class="min-height-200px">
                <div class="pd-20 card-box mb-30">
                    <div class="clearfix">
                        <h2 class="text-dark h2"><i class="fas fa-user-plus"></i>&nbsp;新增員工資料</h2>
                        <input type="image" src="<%=request.getContextPath()%>/images/admins/back.png" width="30px" height="30px" onClick="history.go(-1)" class="pull-right">
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
                    <form method="post" action="<%=request.getContextPath()%>/back-end/admin/admins.do" name="form1" enctype="multipart/form-data">
                        <section>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class="fas fa-user-alt"></i>&nbsp;姓名:</label> <input type="text" class="form-control" id="admin_name" name="admin_name" value="<%=(adminsVO == null) ? " " : adminsVO.getAdmin_name()%>" maxlength="10" required />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class="far fa-id-card"></i>&nbsp;身分證:</label> <input type="text" class="form-control" id="admin_id_no" name="admin_id_no" value="<%=(adminsVO == null) ? " " : adminsVO.getAdmin_id_no()%>" maxlength="10" required />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class="fas fa-envelope-open"></i>&nbsp;Email:</label> <input type="email" class="form-control" id="admin_mail" name="admin_mail" value="<%=(adminsVO == null) ? " " : adminsVO.getAdmin_mail()%>" required />
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class="fas fa-mobile-alt"></i>&nbsp;手機:</label> <input type="text" class="form-control" id="admin_mobile" name="admin_mobile" value="<%=(adminsVO == null) ? " " : adminsVO.getAdmin_mobile()%>" maxlength="10" required />
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-12">
                                    <div id="twzipcode"></div>
                                    <div class="form-group">
                                        <label><i class="fas fa-map-marker-alt"></i>&nbsp;地址:</label>
                                        <div id="zipcode3">
                                            <div class="f3" data-role="county" name="city"></div>
                                            <div class="f4" data-role="district" name="town"></div>
                                            <input type="text" class="f13 address form-control" style="margin-top: 10px" name="address" id="address">
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class="fas fa-calendar-day"></i>&nbsp;雇用日期:</label> <input type="date" class="date form-control" id="admin_dutydate" name="admin_dutydate" value="<%=(adminsVO == null) ? " " : adminsVO.getAdmin_dutydate()%>" required>
                                    </div>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class="fas fa-user-secret"></i>&nbsp;在職狀態:</label> <select class="custom-select form-control" name="admin_jobstate">
                                            <option>請選擇</option>
                                            <option value="1" selected>在職</option>
                                            <option value="0">離職</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class="fas fa-image"></i>&nbsp;上傳照片:</label><br>
                                        <input type="file" name="admin_pic" id="admin_pic">
                                    </div>
                                    <table>
                                        <tr>
                                            <td width="100" height="100" id="preview"></td>
                                        </tr>
                                    </table>
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <label><i class="fas fa-briefcase"></i>&nbsp;權限:</label>
                                        <div class="form-group">
                                            <jsp:useBean id="permissiondelimitSvc" scope="page" class="com.permissiondelimit.model.PermissionDelimitService" />
                                            <c:forEach var="permissiondelimitVO" items="${permissiondelimitSvc.all}">
                                                <label><input type="checkbox" name="per_id[]" value="${permissiondelimitVO.per_id}">${permissiondelimitVO.per_name}
                                                </label>
                                            </c:forEach>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <input type="hidden" name="action" value="insert"> <input type="hidden" name="admin_id" value="${adminsVO.admin_id}">
                                <input type="submit" value="送出" class="btn btn-dark btn-sm">
                            </div>
                        </section>
                    </form>
                    <div>
                        <img style="cursor: pointer" id="button" src="<%=request.getContextPath()%>/images/login/8.png" height="60px" width="60px" align="right">
                    </div>
                </div>
            </div>
        </div>
    </div>
    <jsp:include page="/back-end/sidebar/sidebar.jsp" />
    
    <!-- 自訂js -->
    <!-- 神奇按鈕 -->
    <script type="text/javascript">
    var button = document.getElementById("button");
    var admin_name = document.getElementById("admin_name");
    var admin_id_no = document.getElementById("admin_id_no");
    var admin_mail = document.getElementById("admin_mail");
    var admin_mobile = document.getElementById("admin_mobile");
    var address = document.getElementById("address");
    var admin_dutydate = document.getElementById("admin_dutydate");
    var per_id = document.getElementsByName("per_id[]");

    button.addEventListener("click", function(e) {
        e.preventDefault();
        admin_name.value = "吳永志";
        admin_id_no.value = "A176696093";
        admin_mail.value = "xuzhewei199583@gmail.com";
        admin_mobile.value = "0988168168";
        address.value = "中大路300號";
        admin_dutydate.value = "2020-11-10";
        for (let i = 0; i < per_id.length; i++) {
            per_id[i].checked = true;
        }
    });
    </script>
    <!-- 圖片 -->
    <script type="text/javascript">
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
    </script>
    <!-- 地址 -->
    <script>
    $("#zipcode3").twzipcode({
        "zipcodeIntoDistrict": true,
        "css": ["city form-control", "town form-control"],
        "countyName": "city", // 指定城市 select name
        "districtName": "town" // 指定地區 select name
    });
    </script>
    <script type="text/javascript" src="<%=request.getContextPath()%>/js/taiwan_address_auto_change.js" charset="UTF-8"></script>
    <!-- js -->
    <script src="<%=request.getContextPath()%>/vendors/scripts/core.js"></script>
    <script src="<%=request.getContextPath()%>/vendors/scripts/script.min.js"></script>
    <script src="<%=request.getContextPath()%>/vendors/scripts/process.js"></script>
    <script src="<%=request.getContextPath()%>/vendors/scripts/layout-settings.js"></script>
    <script src="<%=request.getContextPath()%>/src/plugins/jquery-steps/jquery.steps.js"></script>
    <script src="<%=request.getContextPath()%>/vendors/scripts/steps-setting.js"></script>
</body>
</html>