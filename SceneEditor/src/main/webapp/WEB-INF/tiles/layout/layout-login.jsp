<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page session="false" 
%><%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %><%
response.setHeader("Content-Type", "text/html");
response.setContentType("text/html;charset=UTF-8");
response.setCharacterEncoding("UTF-8"); 
%>
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html >
<html lang="ko">
 <head>
  <meta charset="UTF-8" />
  <title>로그인</title>
  <!--[if lt IE 9]>
	<script type="text/javascript" src="js/html5shiv.js"></script>
  <![endif]-->
  <script type="text/javascript" src="${contextRoot}/js/jquery-3.1.0.min.js"></script>
  <script type="text/javascript" src="${contextRoot}/js/editor.js"></script>
  <link rel="stylesheet" type="text/css" href="${contextRoot }/css/style_login.css">
  <link rel="stylesheet" type="text/css" href="${contextRoot }/css/default.css">
</head>
<body>
<!-- skip -->
<nav class="skip">
	<a href="#top">헤더 바로가기</a>
</nav>
<!-- //skip -->
<tiles:insertAttribute name="content"/>
</body>
</html>
