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
						<h2 class="text-danger h2">
							<b>�n�J���\ !</b>
						</h2>
					</div>
				</div>
			</div>
			<hr>

			<!-- Begin Page Content -->
			<div class="container-fluid">
				<!-- Content Row -->
				<div class="row">
					<div class="col-xl-8 col-lg-7">
						<!-- Area Chart -->
						<div class="card shadow mb-4">
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">�~�׾P��q(��)</h6>
							</div>
							<div class="card-body">
								<div class="chart-area">
									<canvas id="myAreaChart"></canvas>
								</div>
							</div>
						</div>						
					</div>

					<!-- Donut Chart -->
					<div class="col-xl-4 col-lg-5">
						<div class="card shadow mb-4">
							<!-- Card Header - Dropdown -->
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">����P�����(%)</h6>
							</div>
							<!-- Card Body -->
							<div class="card-body">
								<div class="chart-pie pt-4">
									<canvas id="myPieChart"></canvas>
								</div>
							</div>
						</div>
						<div class="card shadow mb-4">
							<!-- Card Header - Dropdown -->
							<div class="card-header py-3">
								<h6 class="m-0 font-weight-bold text-primary">���󦳸ܭn��</h6>
							</div>
							<!-- Card Body -->
							<div class="card-body">
								<div class="row">
								  &nbsp;&nbsp;
									<img class="rounded-circle" src="<%=request.getContextPath()%>/images/login/wu.jpg" width="100px" height="100px" style="box-shadow:7px 4px 9px 1px #333333;">
								&nbsp;&nbsp;&nbsp;&nbsp;		
										  <div style= "position:relative "> 
<div style= "position:absolute; left:60px; top:25px; color:black; font-weight:bold "><h3><b>�ȤW�o�Ӳ�ı�L,<br>
										  &nbsp;&nbsp;&nbsp;�������ƥ��`��</b></<h3> </div> 
<img width="350px" height="128px" src="<%=request.getContextPath()%>/images/login/talk.jpg"> </img> 
</div>											  								 								
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
	</div>
	<jsp:include page="/back-end/sidebar/sidebar.jsp" />
	<script src="<%=request.getContextPath()%>/vendor/jquery/jquery.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script src="<%=request.getContextPath()%>/js/sb-admin-2.min.js"></script>
	<script
		src="<%=request.getContextPath()%>/vendor/chart.js/Chart.min.js"></script>
	<script src="https://code.jquery.com/jquery-3.5.1.min.js"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="<%=request.getContextPath()%>/js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
<script>
//Set new default font family and font color to mimic Bootstrap's default styling
Chart.defaults.global.defaultFontFamily = '-apple-system,system-ui,BlinkMacSystemFont,"Segoe UI",Roboto,"Helvetica Neue",Arial,sans-serif';
Chart.defaults.global.defaultFontColor = '#292b2c';

// Pie Chart Example
var ctx = document.getElementById("myPieChart");
var myPieChart = new Chart(ctx, {
  type: 'pie',
  data: {
    labels: ["����", "�~��", "���e", "���p��", "�r��", "���x", "�ϵe��","��L"],
    datasets: [{
      data: [12.21, 10, 5.58, 2.25, 8.32, 9, 8, 2.25],
      backgroundColor: ['#007bff', '#dc3545', '#ffc107', '#28a745','#58d222', '#ab3546', '#cc3546', '#ff33546'],
    }],
  },
});
</script>
// Area Chart Example
<script type="text/javascript">
var ctx = document.getElementById("myAreaChart");
var myLineChart = new Chart(ctx, {
  type: 'line',
  data: {
    labels: ["�@��", "�G��", "�T��", "�|��", "����", "����", "�C��", "�K��", "�E��", "�Q��", "�Q�@��"],
    datasets: [{
      label: "Sessions",
      lineTension: 0.3,
      backgroundColor: "rgba(2,117,216,0.2)",
      borderColor: "rgba(2,117,216,1)",
      pointRadius: 5,
      pointBackgroundColor: "rgba(2,117,216,1)",
      pointBorderColor: "rgba(255,255,255,0.8)",
      pointHoverRadius: 5,
      pointHoverBackgroundColor: "rgba(2,117,216,1)",
      pointHitRadius: 50,
      pointBorderWidth: 2,
      data: [10000, 30162, 26263, 18394, 18287, 28682, 31274, 33259, 25849, 24159, 39651],
    }],
  },
  options: {
    scales: {
      xAxes: [{
        time: {
          unit: 'date'
        },
        gridLines: {
          display: false
        },
        ticks: {
          maxTicksLimit: 7
        }
      }],
      yAxes: [{
        ticks: {
          min: 0,
          max: 40000,
          maxTicksLimit: 5
        },
        gridLines: {
          color: "rgba(0, 0, 0, .125)",
        }
      }],
    },
    legend: {
      display: false
    }
  }
});
</script>
</body>

</html>