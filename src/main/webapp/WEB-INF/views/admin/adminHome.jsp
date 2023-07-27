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

      function drawChart1() {
        var data = google.visualization.arrayToDataTable([
          ['주차', '가입자수'],
          <c:forEach items="${statVOS}" var="vo">
          ['${vo.year_week}',  ${vo.res1}],
          </c:forEach>
        ]);

        var options = {
          title: '신규 가입자 수',
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
            title: '게시판별 활동상황'
          };

          var chart = new google.visualization.PieChart(document.getElementById('piechart2'));

          chart.draw(data, options);
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
			<div class="col-12">
				 <!-- <div id="piechart" style="width: auto; height: 500px;"></div> -->				
				<div id="curve_chart" style="width: auto; height: 500px"></div>
				<div id="piechart2" style="width: auto; height: 500px;"></div>				
			</div>
			<div class="col-12">
			</div>
		</div>
	
</div>
<jsp:include page="/WEB-INF/views/include/footer.jsp"/>	
</body>
</html>