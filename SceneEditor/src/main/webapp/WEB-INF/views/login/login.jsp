<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<div class="wrap">
	<!-- header -->
	<header class="top" id="top">
		<h1><a href="#"><img src="${contextRoot }/images/title.png" alt="장면정보 입력 관리 시스템" /></a></h1>
		<a class="btn_scnSearch" href="#">장면정보 검색</a>
	</header>
    <!-- //header -->
    <form id="loginForm" method="post" action="${contextRoot }/login/loginOk">
    <div class="box">	
    	<h2>KOFA 비극영상물 장면정보 입력 관리시스템</h2>
        <ul class="login">
        	<li><input type="text" placeholder="ID" id="id_userName" name="userName"/></li> 
            <li><input type="password" placeholder="Password" id="id_password" name="password"/></li>
		</ul>
		<button type="button" class="btn_login" name="login">LOGIN</button>
	</div>
	</form>
</div>