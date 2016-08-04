<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 
%><%@ page session="false" 
%><%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>장면정보 입력 관리 시스템 - WISE Scene Editor V1.0</title>
<style type="text/css">
p {text-align:left; margin:50px 10px 50px 30px}
p strong { font-size:50px }
.explain {width:1000px; font-size:15px}
.explain p {margin:10px 10px 10px 30px}
table { float:center; border-collapse:collapse; text-align:center; margin:5px 10px 10px 30px}  
th, td { border-width:1px; border-style:solid; border-color:gray; }
</style>
</head>
<body>
	<div>
		<p>영상 정보 조회</p>
	</div>
	<table>
		<tr>
			<th>순서</th>
			<th>영상 ID</th>
			<th>영상 제목</th>
			<th>유형</th>
			<th>상영시간(분)</th>
			<th>언어</th>
			<th>제작년도</th>
			<th>장면정보개수</th>
		</tr>
		<c:forEach var="result" items="${videoList }">
		<tr>
			<td></td>
			<td>${result.vdoId }</td>
			<td>${result.vdoTitle }</td>
			<td></td>
			<td></td>
			<td>${result.language }</td>
			<td>${result.productionDate }</td>
			<td><a href="/viewScene?vdoId=${result.vdoId}">${result.scnCnt }</a></td>		
		</tr>
		</c:forEach>
	</table>
	<div class="explain">
	<!-- 
	<p>※ 검사상태</p>
	<ul>
		<li>S : 표절검사 완료</li>
		<li>F/M : 표절검사 실패</li>
		<li>N : 초기화 상태, 표절문서 대기상태</li>
		<li>K : 표절검사 진행중</li>
	</ul>
	 -->
	</div>
</body>
</html>