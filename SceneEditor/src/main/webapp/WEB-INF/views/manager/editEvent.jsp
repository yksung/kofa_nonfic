<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
<c:set var="vdoId" value="${empty vdoId ? 0:vdoId }"/>
<c:set var="page" value="${empty page ? 0:page }"/>
<c:set var="pageSize" value="${empty pageSize ? 0:pageSize }"/>
<!-- content -->
<section class="content" id="content">
	<nav>
		<a class="on" href="#">사건 분류 관리</a>
	   	<a href="#">사건 연대 관리</a>
		<a href="#">국가 관리</a>
	</nav>
	<div class="event_wrap">
	<form id="id_editEventForm" name="editEventForm" action="${contextRoot }/manager/addEvent" method="POST">
		<h2 class="sub_tit">사건 분류 관리</h2>
		<div class="event_01 marL">
			<span>대분류</span>
			<ul class="event_list">
			<c:forEach var="item" items="${ eventList }">
				<li name="event">
					<input name="eventNm" type="text" value="${item.eventNm }"/>
					<input name="eventCd" type="text" value="${item.eventCd }"/>
					<input name="eventDate" type="text" value="${item.eventDate }"/>
				</li>
			</c:forEach>
			</ul>
			<ul class="btn_area">
            	<li><a href="javascript:open('.addlist')"><img src="${contextRoot }/images/btn_plus.png" alt="추가" /></a></li>	
                <li class="marL"><a href="javascript:remove('select', 'event');"><img src="${contextRoot }/images/btn_minus.png" alt="삭제" /></a></li>	
                <%-- <li><a href="#"><img src="${contextRoot }/images/turn_up.png" alt="위로" /></a></li>	
                <li><a href="#"><img src="${contextRoot }/images/turn_down.png" alt="아래로" /></a></li> --%>	
			</ul>
            <div class="addlist">
            	<p>사건 추가<a href="javascript:close('.addlist')"><img src="${contextRoot }/images/icon_close01.png" alt="닫기" /></a></p>
                <input id="id_eventNm" name="eventNm" type="text" placeholder="사건명"  />
                <input id="id_eventDate" name="eventDate" type="text" placeholder="사건일시"  />
                <input type="button" onclick="javascript:plus('li', 'event');" value="추가">
			</div>
		</div>
		<a class="btn_save" href="#">저장</a>
	</form>
	</div>
</section>
<!-- //content -->