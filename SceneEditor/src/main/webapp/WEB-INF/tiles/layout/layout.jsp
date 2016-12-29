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
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/default.css">
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/style02.css">
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/style03.css">
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/w2ui-1.4.3.min.css">
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/listgroup.css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
<script type="text/javascript" src="${contextRoot}/js/w2ui-1.4.3.min.js"></script>
<script type="text/javascript" src="${contextRoot}/js/editor.js"></script>
</head>
<body>
<!-- skip -->
<tiles:insertAttribute name="navigation"/>
<!-- //skip -->
<div class="wrap">
	<!-- header -->
	<tiles:insertAttribute name="header"/>
    <!-- //header -->
    
    <!-- content -->
    <tiles:insertAttribute name="content"/>
    <!-- //content -->
    
    
</div>
</body>
</html>