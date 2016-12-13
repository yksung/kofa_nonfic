<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
<header class="top" id="top">
   	<h1><a href="${contextRoot }/"><img src="${contextRoot }/images/title.png" alt="장면정보 입력 관리 시스템" /></a></h1>
       <a class="btn_scnSearch" href="${contextRoot}/search">장면정보 검색</a>
       <ul>
       	<li><strong><%=userName %></strong> 님 <a class="btn_logout" href="${contextRoot}/login/logout">로그아웃</a></li>
       </ul>
</header>