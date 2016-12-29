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
  <title>장면정보 입력 관리 시스템&nbsp;|&nbsp;한국영상자료원</title>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
  <link rel="stylesheet" href="${contextRoot }/css/default.css" type="text/css"/>
  <link rel="stylesheet" href="${contextRoot }/css/style_login.css" type="text/css"/>
  <!--[if lt IE 9]>
	<script type="text/javascript" src="${contextRoot}/js/html5shiv.js"></script>
  <![endif]-->
  <script type="text/javascript" src="${contextRoot}/js/jquery-3.1.0.min.js"></script>
  <script type="text/javascript" src="${contextRoot}/js/editor.js"></script>
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
