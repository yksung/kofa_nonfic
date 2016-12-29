<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page session="false" 
%><%@ page contentType="text/html; charset=utf-8"
%><%
response.setHeader("Content-Type", "text/html");
response.setContentType("text/html;charset=UTF-8");
response.setCharacterEncoding("utf-8"); 
%>
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html >
<html  lang="ko">
 <head>
  <meta charset="utf-8" />
  <title>장면정보 입력 관리 시스템&nbsp;|&nbsp;한국영상자료원</title>
  <!--[if lt IE 9]>
	<script type="text/javascript" src="${contextRoot}/js/html5shiv.js"></script>
  <![endif]-->
<script type="text/javascript" src="${contextRoot}/js/editor.js"></script>
</head>
<body>
	<tiles:insertAttribute name="content"/>
</body>
</html>