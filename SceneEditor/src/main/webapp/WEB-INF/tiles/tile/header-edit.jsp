<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<header class="top" id="top">
	<h1><a href="#"><img src="${contextRoot}/images/title.png" alt="장면정보 입력 관리 시스템" /></a></h1>
	<a class="btn_scnSearch" href="#">장면정보 검색</a>
	<ul>
		<li>입력자 : ${sceneInfo.editor }</li>
		<li>마지막 입력시간 : ${ sceneInfo.updDtime }</li>
	</ul>
</header>