<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<c:set var="ctp" value="${pageContext.request.contextPath}" />
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 페이지입니다.</title>
	<jsp:include page="/WEB-INF/views/include/bs4.jsp"/>
	<jsp:include page="/WEB-INF/views/include/mainCss.jsp"/>
	<script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
  <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawChart1);
      //google.charts.setOnLoadCallback(drawChart2);
      google.charts.setOnLoadCallback(drawChart3);
      google.charts.setOnLoadCallback(drawChart4);
      google.charts.setOnLoadCallback(drawChart5);
      
      function drawChart1() {
        var data = google.visualization.arrayToDataTable([
          ['주차', '가입자수'],
          <c:forEach items="${statVOS}" var="vo">
          ['${vo.year_week}',  ${vo.res1}],
          </c:forEach>
        ]);

        var options = {
          title: '',
          legend: { position: 'center' }
        };

        var chart = new google.visualization.LineChart(document.getElementById('curve_chart'));

        chart.draw(data, options);
      }
      /* 
      function drawChart2() {

        var data = google.visualization.arrayToDataTable([
          ['게시판', '30일 글 개제 수'],
          ['잡담', ${boaStatVOS[0].res2}],
          ['일상', ${boaStatVOS[1].res2}],
          ['부품', ${boaStatVOS[2].res2}],
        ]);

        var options = {
          title: '게시판별 활동상황'
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart'));

        chart.draw(data, options);
      }
      */
      
      function drawChart3() {
          var data = google.visualization.arrayToDataTable([
            ['게시판', '30일 글 개제 수'],
           	<c:forEach items="${boaStatVOS}" var="vo">
           		['${vo.strRes}',${vo.res2}],
           	</c:forEach>
          ]);

          var options = {
            title: ''
          };

          var chart = new google.visualization.PieChart(document.getElementById('piechart2'));

          chart.draw(data, options);
        }
      
      function drawChart5() {
          var data = google.visualization.arrayToDataTable([
            ['게시판', '30일 댓글 수'],
           	<c:forEach items="${BCRStatVOS}" var="vo">
           		['${vo.strRes}',${vo.res1}],
           	</c:forEach>
          ]);

          var options = {
            title: ''
          };

          var chart = new google.visualization.PieChart(document.getElementById('piechart3'));

          chart.draw(data, options);
        }
      
      function drawChart4() {
          var data = google.visualization.arrayToDataTable([
            ["게시글명", "댓글수" , { role: 'style' }],
           	<c:forEach items="${repStatVOS}" var="vo">
       				['${vo.strRes}',${vo.res1}, '#00CFFF'],
       			</c:forEach>
          ]);

          var view = new google.visualization.DataView(data);
          view.setColumns([0, 1,
                           { calc: "stringify",
                             sourceColumn: 1,
                             type: "string",
                             role: "annotation" },
                           2]);

          var options = {
            title: "",
            width: 600,
            height: 400,
            bar: {groupWidth: "95%"},
            legend: { position: "none" },
          };
          var chart = new google.visualization.ColumnChart(document.getElementById("columnchart_values"));
          chart.draw(view, options);
      }
    </script>
	<script>
		'use Strict';

		
	</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/navbar.jsp"/>
<div class="container">
<jsp:include page="/WEB-INF/views/include/adminHeader.jsp"/>
		<div class="row">
			<div class="col-12 text-left">
				 <!-- <div id="piechart" style="width: auto; height: 500px;"></div> -->	
				<div class="subTitle">주차별 가입자 통계</div>			
				<div id="curve_chart" style="width: auto; height: 500px"></div>
				<div class="subTitle mb-2">최근 게시판 활동 정황</div>
			
			</div>
			<div class="col-6">
				<div class="subTitle">카테고리별 게시글 수</div>
				<div id="piechart2" style="width: 100%%; height: 250px;"></div>
			</div>
			<div class="col-6">
				<div class="subTitle">게시글별 댓글 수(많은 순으로 10개)</div>
				<div id="columnchart_values" style="width: 100%; height: 250px;"></div>	
			</div>
			<div class="col-6">
				<div class="subTitle">카테고리별 댓글 수(news 영역 포함)</div>
				<div id="piechart3" style="width: 100%%; height: 250px;"></div>
			</div>
			<div class="col-12 text-left">
				<div class="subTitle">회원 평균 주행 정보</div>
				<hr style="width: 50%">
				<div class="subTitle">평균속도 : ${rideStatVO.res2}km/h</div>
				<hr style="width: 50%">
				<div class="subTitle">주행시간 : ${rideStatVO.res1}h</div>
				<hr style="width: 50%">
				<div class="subTitle">획득고도 : ${rideStatVO.res3}m</div>
				<hr style="width: 50%">
			</div>
		</div>
	
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>