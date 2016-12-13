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
	   	<!-- <a href="#">사건 연대 관리</a>
		<a href="#">국가 관리</a> -->
	</nav>
	<div class="event_wrap">
	<form id="id_editEventForm" name="editEventForm" action="${contextRoot }/manager/editEvent" method="POST">
		<h2 class="sub_tit">사건 분류 관리</h2>
		<div class="event_01 marL">
			<span>대분류</span>
			<ul class="event_list">
			<c:forEach var="item" items="${ eventList }">
				<li name="event" id="${item.eventCd }">
					<a href="#">${item.eventDate } / ${item.eventNm }</a>
				</li>
			</c:forEach>
			</ul>
			<ul class="btn_area">
            	<li><a href="javascript:layer_open('id_addlist', 'layer_add')"><img src="${contextRoot }/images/btn_plus.png" alt="추가" /></a></li>	
                <%-- <li class="marL"><a href="javascript:remove('select', 'event');"><img src="${contextRoot }/images/btn_minus.png" alt="삭제" /></a></li>	
                <li><a href="#"><img src="${contextRoot }/images/turn_up.png" alt="위로" /></a></li>	
                <li><a href="#"><img src="${contextRoot }/images/turn_down.png" alt="아래로" /></a></li> --%>	
			</ul>
			<div class="layer" id="layer_add">
				<div class="bg"></div>
	            <div class="pop-layer" id="id_addlist">
	            	<p>사건 추가<a href="javascript:layer_close('id_addlist')"><img src="${contextRoot }/images/icon_close01.png" alt="닫기" /></a></p>
	                <input id="id_addEventNm" name="addEventNm" type="text" placeholder="사건명"  />
	                <input id="id_addEventDate" name="addEventDate" type="text" placeholder="사건일시"  />
	                <input type="button" onclick="javascript:addEvent();" value="추가">
				</div>
			</div>
			<div class="layer" id="layer_edit">
				<div class="bg"></div>
				<div class="pop-layer" id="id_editlist">
					<p>사건 수정<a href="javascript:layer_close('id_editlist')"><img src="${contextRoot }/images/icon_close01.png" alt="닫기" /></a></p>
					<input id="id_editEventCd" name="editEventCd" type="hidden" value=""/>
					<input id="id_editEventNm" name="editEventNm" type="text" placeholder="사건명" value="" />
					<input id="id_editEventDate" name="editEventDate" type="text" placeholder="사건일시"  value="" />
					<input type="button" onclick="javascript:editEvent();" value="수정">
					<input type="button" onclick="javascript:deleteEvent();" value="삭제">
				</div>
			</div>
		</div>
	</form>
	</div>
</section>
<!-- //content -->