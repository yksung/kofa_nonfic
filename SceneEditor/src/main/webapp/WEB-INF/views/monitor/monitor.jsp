<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 
%><%@ page session="false" 
%><%@ page contentType="text/html; charset=utf-8" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>표절 검사 진행률 체크 페이지 - WISE Referee v2.1</title>
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
		<p><strong>표절 검사 진행률 체크 페이지</strong> by Wisenut Inc.</p>
	</div>
	<table>
		<tr>
			<th>과제코드(discuss_number)</th>
			<th>검사 상태</th>
			<th>진행률(%)</th>
			<th>총 문서건수</th>
			<th>진행 문서건수</th>
			<th>검사 시작 시간</th>
			<th>예상 완료 시간</th>
			<th>총 소요시간</th>
		</tr>
		<c:forEach var="result" items="${taskList }">
		<tr>
			<td>${result.task_code }</td>
			<td>${result.pgm_status }</td>
			<td>${result.pgm_status_psnt }</td>
			<td>${result.pgm_tcnt }</td>
			<td>${result.pgm_cnt }</td>
			<td>${result.pgm_start_dt }</td>
			<td>${result.pgm_expect_dt }</td>
			<td>${result.pgm_progs_sec }</td>		
		</tr>
		</c:forEach>
	</table>
	<div class="explain">
	<p>※ 검사상태</p>
	<ul>
		<li>S : 표절검사 완료</li>
		<li>F/M : 표절검사 실패</li>
		<li>N : 초기화 상태, 표절문서 대기상태</li>
		<li>K : 표절검사 진행중</li>
	</ul>
	</div>
</body>
</html>