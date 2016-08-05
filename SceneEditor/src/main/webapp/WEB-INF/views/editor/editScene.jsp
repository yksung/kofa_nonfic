<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 
%><%@ page session="false" 
%><%@ page contentType="text/html; charset=utf-8" %><%
response.setHeader("Content-Type", "text/html");
response.setContentType("text/html;charset=UTF-8");
response.setCharacterEncoding("utf-8"); 
%>
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8"/>
	<title>장면정보 입력 관리 시스템 - WISE Scene Editor V1.0</title>
	<style type="text/css">
	p {text-align:left; margin:50px 10px 50px 30px}
	p strong { font-size:50px }
	.explain {width:1000px; font-size:15px}
	.explain p {margin:10px 10px 10px 30px}
	table { float:center; border-collapse:collapse; text-align:center; margin:5px 10px 10px 30px}  
	th, td { border-width:1px; border-style:solid; border-color:gray; }
	</style>
	<script type="text/javascript" src="${contextRoot}/js/jquery-3.1.0.min.js"></script>
	<script type="text/javascript">
	$(function(){
		$("#id_eventLClasCd").on("change", function(){
			var val = $(this).val();
			$.ajax({
				url : "${contextRoot}/getEventAsJson?upperClasCd="+val,
				type : "get",
				contentType : "text/html; charset=UTF-8",
				dataType : 'json',
				success : function(data){
					var html = '';
					$.each(data, function(i, pair){
						html += "<option value='" + pair.clasCd + "'>" + pair.clasNm + "</option>";
						console.log(i +":"+ pair.clasCd + ", " + pair.clasNm);
					});
					$("#id_eventSClasCd").html(html);
				},
				error : function ( request, status, error ){
					alert("code : " + request.status + "\n" + "message : "+ request.responseText + "\n" + "error : " + error);
				}
			});
		});
		
		$("#id_domAbr").on("change", function(){
			var val = $(this).val();
			$.ajax({
				url : "${contextRoot}/getCountryAsJson?domAbr="+val,
				type : "get",
				contentType : "text/html; charset=UTF-8",
				dataType : 'json',
				success : function(data){
					var html = '';
					$.each(data, function(i, pair){
						html += "<option value='" + pair.cntryCd + "'>" + pair.cntryNm + "</option>";
						console.log(i +":"+ pair.cntryCd + ", " + pair.cntryNm);
					});
					$("#id_cntryCd").html(html);
				},
				error : function ( request, status, error ){
					alert("code : " + request.status + "\n" + "message : "+ request.responseText + "\n" + "error : " + error);
				}
			});
		});
	});
	</script>
</head>
<body>
	<div>
		<p><strong>${sceneInfo.scnStartCd }~${sceneInfo.scnEndCd }</strong>의 장면 정보 수정하기</p>
		<p>입력자 : ${sceneInfo.editor } / 마지막 입력시간 : ${ sceneInfo.updDtime } </p>
	</div>
	<table>
		<tr>
			<th>순서</th>
			<th>장면 ID</th>
			<th>타임코드</th>
			<th>사건분류</th>
			<th>사건연대</th>
			<th>장소</th>
			<th>인물</th>
			<th>화면묘사</th>
			<th>내레이션</th>
			<th>자막</th>
			<th>장면요약</th>
			<th>키워드</th>
		</tr>
		<tr>
			<td></td>
			<td>${sceneInfo.scnId }</td>
			<td>
				시작코드* : <input type="text" name="scnStartCd" value="${sceneInfo.scnStartCd }" pattern="\d{3}:[0-60]{2}">
				/ 종료코드* : <input type="text" name="scnEndCd" value="${sceneInfo.scnEndCd }" pattern="\d{3}:[0-60]{2}">
			</td>
			<td>
				대분류 : <select name="eventLClasCd" id="id_eventLClasCd">
					<c:forEach var="item" items="${ eventCategoryList }">
						<c:if test="${item.upperClas == null }">
					<option value="${item.clasCd }">${item.clasNm }</option>
						</c:if>
					</c:forEach>
				</select>
				/ 소분류 :
				<select name="eventSClasCd" id="id_eventSClasCd"></select>
				/ 사건명 : <input type="text" name="eventNm" value="${sceneInfo.eventNm }">
			</td>
			<td>
				<select name="eventPrd" id="id_eventPrd">
					<c:forEach var="item" items="${ periodList }">
					<option value="${item.prdCd }">${item.prdNm }</option>
					</c:forEach>
				</select> 
			</td>
			<td>
				국내/국외* : <select name="domAbr" id="id_domAbr">
					<option value="domestic">국내</option>
					<option value="abroad">국외</option>
				</select>
				/ 국가명 : <select name="cntryCd" id="id_cntryCd"></select>
				/ 장면 상 장소 : <input type="text" name="eventPlace" value="${sceneInfo.eventPlace }">
				/ 실제 장소 : <input type="text" name="realPlace" value="${sceneInfo.realPlace }">
			</td>
			<td>
				<input type="text" name="celebrity1" value="${sceneInfo.celebrity1 }">
				<input type="text" name="celebrity2" value="${sceneInfo.celebrity2 }">
				<input type="text" name="celebrity3" value="${sceneInfo.celebrity3 }">	
			</td>
			<td><textarea rows=5 cols="20" name="description">${sceneInfo.description }</textarea></td>
			<td><textarea rows=5 cols="20" name="narration">${sceneInfo.narration }</textarea></td>
			<td><textarea rows=5 cols="20" name="subtitles">${sceneInfo.subtitles }</textarea></td>
			<td><textarea rows=5 cols="20" name="summary">${sceneInfo.summary }</textarea></td>
			<td><textarea rows=5 cols="20" name="keyword">${sceneInfo.keyword }</textarea></td>
		</tr>
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