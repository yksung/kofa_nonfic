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
		<p><strong>~</strong>의 장면 정보 조회</p>
	</div>
	<table>
		<tr>
			<th>순서</th>
			<th>장면 ID</th>
			<th>시작코드</th>
			<th>종료코드</th>
			<th>사건대분류</th>
			<th>사건소분류</th>
			<th>입력자</th>
			<th>마지막 수정 일시</th>
			<th>상세보기</th>
		</tr>
		<c:forEach var="result" items="${sceneList }">
		<tr>
			<td></td>
			<td>${result.scnId }</td>
			<td>${result.scnStartCd }</td>
			<td>${result.scnEndCd }</td>
			<td>${result.eventLClasCd }</td>
			<td>${result.eventSClasCd }</td>
			<td>${result.editor }</td>
			<td>${result.updDtime }</td>		
			<td><a href="/editScene/${result.scnId }">GO</a></td>		
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