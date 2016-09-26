<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/style01.css">
<script type="text/javascript" src="${contextRoot}/js/beta.fix.js"></script>
<script type="text/javascript" src="${contextRoot}/js/ark_function.js"></script>
<script type="text/javascript" src="${contextRoot}/js/flowplayer-3.2.13.js"></script>
<!-- content -->
<section class="content">
	<article class="vdo_area" id="vdo_area">
    	<header>
        	<h2>제목 : <strong>${ sceneInfo.vdoNm }</strong></h2>
        	<!-- <a href="#">영상불러오기</a> -->
		</header>
        <div class="vdo_player" id="id_vdoPlayer">
        	<a id="id_playerButton" href="#">
        		<img src="${contextRoot}/images/showme.png" />
        	</a>
        </div>
	</article>
    
	<article class="info_area" id="info_area">
      	<header>
      		<h2>메타입력 정보</h2>
         	<a href="${contextRoot }/editor/viewScene?vdoId=${sceneInfo.vdoId}">목록보기</a>
            <ul>
             	<c:choose>
             	<c:when test='${ prevExists == 1 }'>
             	<li><a class="btn_prev on" href="${contextRoot }/editor/editScene?vdoId=${ sceneInfo.vdoId }&scnId=${sceneInfo.scnId}&direction=-1">이전정보</a></li>
             	</c:when>
             	<c:otherwise>
             	<li><a class="btn_prev" href="#">이전정보</a></li>
             	</c:otherwise>
             	</c:choose>
             	<c:choose>
             	<c:when test='${ nextExists == 1 }'>
                 <li><a class="btn_next on" href="${contextRoot }/editor/editScene?vdoId=${ sceneInfo.vdoId }&scnId=${sceneInfo.scnId}&direction=1">다음정보</a></li>
                 </c:when>
                 <c:otherwise>
             	<li><a class="btn_next" href="#">다음정보</a></li>
             	</c:otherwise>
             	</c:choose>
			</ul>
		</header>
		<form name="thisSceneForm" action="${contextRoot }/editor/saveScene" method="POST">
         	<input type="hidden" name="scnId" value="${fn:trim(sceneInfo.scnId) }"/>
			<input type="hidden" name="vdoId" value="${fn:trim(sceneInfo.vdoId) }"/>
			<input type="hidden" name="editor" value="<%=userName %>"/>
         	<table summary="메타정보를 입력할 수 있는 양식">
                 <caption>메타입력정보</caption>
                 <colgroup>
                     <col width="68px"/><col width="*"/>
                 </colgroup>
                 <tbody>
                 	<tr>
                       	<th>타임코드</th>
                 		<td>
                           	<label for="id_scnStartCd">시작*</label><input id="id_scnStartCd" name="scnStartCd" type="text" placeholder="mmm:ss" value="${fn:trim(sceneInfo.scnStartCd) }"/>
                           	<label for="id_scnEndCd">종료</label><input id="id_scnEndCd" name="scnEndCd" type="text" placeholder="mmm:ss" value="${fn:trim(sceneInfo.scnEndCd) }"/> 
						</td>
					</tr>
					<tr>
                       	<th>관련사건<a href="javascript:plusEvent('li', 'event')" id="id_evnt_add"><img src="${contextRoot}/images/btn_plus.png" alt="사건 추가" /></a></th>
                        <!-- yksung@20160924 : 대분류는 직접입력의 자동완성과 기능적으로 겹치기 때문에 빼는 쪽으로 갔으면 함.
                        <td>
							<label for="">대분류*</label>
                     		<select id="id_eventLcls" name="eventLClasCd" onChange="javascript:onEventChange();">
                     			<c:forEach var="item" items="${ eventList }">
							<c:choose>
								<c:when test="${ item.eventCd == sceneInfo.eventLClasCd }">
						<option value="${item.eventCd }" selected>${item.eventNm }</option>
								</c:when>
								<c:otherwise>
						<option value="${item.eventCd }">${item.eventNm }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
                     		</select>
						</td>
						-->
						<td>
							<ul>
								<c:forTokens var="eventNm" items="${empty sceneInfo.eventNm ? ' ':sceneInfo.eventNm }" delims="@^@" varStatus="status">
								<li name="event">
									<!-- <label for="id_eventNm${status.index }">직접입력</label> -->
									<input class="size" id="id_eventNm${status.index }" name="eventNm" type="text" value="${fn:trim(eventNm) }" onClick="javascript:doArk('thisSceneForm', 'id_eventNm${status.index}', 'id_eventArk${status.index }', 'event');" onKeyUp="javascript:arkKeyUp(event, 'id_eventArk${status.index }')"/> 
		                     		<span id="id_eventArk${status.index }"></span>
	                     		</li>
	                     		</c:forTokens>
							</ul>
	                    	
						</td>
					</tr>
                    <tr>
						<th>사건연대</th>
                        <td>
                        	<select id="id_eventPrd" name="eventPrd">
                             	<c:forEach var="item" items="${ periodList }">
							<c:choose>
								<c:when test="${ item.prdCd == sceneInfo.eventPrd }">
						<option value="${item.prdCd }" selected>${item.prdNm }</option>
								</c:when>
								<c:otherwise>
						<option value="${item.prdCd }">${item.prdNm }</option>
								</c:otherwise>
							</c:choose>
						</c:forEach>
                            </select>
						</td>
					</tr>
                    <tr>
                    	<th>장소</th>
                        <td>
                        	<label for="id_domAbr">국내/국외*</label>
                            <select class="marL" id="id_domAbr" name="domAbr" onChange="javascript:onDomAbrChange('${sceneInfo.cntryCd }');">
                            <c:choose>
								<c:when test="${ fn:trim(sceneInfo.domAbr) == 'domestic' }">
								<option value="domestic" selected>국내</option>
								<option value="abroad">국외</option>
								</c:when>
								<c:otherwise>
								<option value="domestic">국내</option>
								<option value="abroad" selected>국외</option>
								</c:otherwise>
							</c:choose>
                            </select>
                            <label for="id_cntryCd">국가명*</label>
                            <select class="marL"  id="id_cntryCd" name="cntryCd">
                            <c:forEach var="item" items="${ countryList }">
							<c:choose>
								<c:when test="${ item.cntryCd == fn:trim(sceneInfo.cntryCd) }">
								<option value="${item.cntryCd }" selected>${item.cntryNm }</option>
								</c:when>
								<c:otherwise>
								<option value="${item.cntryCd }">${item.cntryNm }</option>
								</c:otherwise>
							</c:choose>
							</c:forEach>
                            </select> 
						</td>
					</tr>
					<tr>
                     	<th></th>
                        <td>
							<label for="id_eventPlace">장면 상 장소</label><input id="id_eventPlace" name="eventPlace" type="text" placeholder="POI 또는 행정구역명" value="${fn:trim(sceneInfo.eventPlace) }"/>
							<label for="id_realPlace">실제장소</label><input id="id_realPlace" name="realPlace" type="text" placeholder="POI 또는 행정구역명" value="${fn:trim(sceneInfo.realPlace)}"/>
						</td>
					</tr>
					<tr>
						<th></th>
						<td>
							<label for="">위/경도 정보</label>
							<input class="bg" id="" name="latitude" type="text" placeholder="자동입력됩니다." value="${sceneInfo.latitude }"/>
                            <input class="bg" id="" name="longitude" type="text" placeholder="자동입력됩니다." value="${sceneInfo.longitude}"/>
							<a class="btn_map" href="#">지도검색</a>
						</td>
					</tr>
                    <tr>
						<th>인물명</th>
						<td id="id_celebrity">
							<input name="celebrity" type="text" placeholder="유명인만 기재" value="${fn:trim(sceneInfo.celebrity1) }"/>
							<input name="celebrity" type="text" placeholder="유명인만 기재" value="${fn:trim(sceneInfo.celebrity2) }"/>
							<input name="celebrity" type="text" placeholder="유명인만 기재" value="${fn:trim(sceneInfo.celebrity3) }"/>
							<a href="javascript:plus('input', 'celebrity')" id="id_celb_add"><img src="${contextRoot}/images/btn_plus.png" alt="인물 추가" /></a>
						</td>
					</tr>
					<tr class="textarea_h">
						<th>화면묘사</th>
						<td><textarea id="id_description" name="description">${sceneInfo.description }</textarea></td>
					</tr>
					<tr class="textarea_h">
						<th>내레이션</th>
						<td><textarea id="id_narration" name="narration">${sceneInfo.narration }</textarea></td>
					</tr>
					<tr class="textarea_h">
                     	<th>자막</th>
						<td><textarea id="id_subtitles" name="subtitles">${sceneInfo.subtitles }</textarea></td>
					</tr>
					<tr class="textarea_h">
						<th>장면요약</th>
						<td><textarea id="id_summary" name="summary">${sceneInfo.summary }</textarea></td>
					</tr>
                    <tr class="textarea_h">
                     	<th>키워드</th>
                        <td><textarea id="id_keyword" name="keyword">${sceneInfo.keyword }</textarea></td>
					</tr>
					<tr class="textarea_h">
                     	<th>비고</th>
                        <td><textarea id="id_note" name="note">${sceneInfo.note }</textarea></td>
					</tr>
				</tbody>
			</table>
            <ul class="btn_area">
				<li><a class="btn_save" href="javascript:saveScene();">저장</a></li>
				<li><a class="btn_check" href="#">검증</a></li>
				<li><a class="btn_del" href="javascript:deleteScene('${fn:trim(sceneInfo.vdoId)}', '${fn:trim(sceneInfo.scnId) }');">삭제</a></li>
            </ul>
			<!-- 스크랩팝업 -->
			<div class="map_pop">
				<p>지도검색<a href="#"><img src="${contextRoot}/images/icon_close01.png" alt="닫기" class="popup_close"/></a></p>
				<table summary="지도검색을 위한 팝업">
					<caption>지도검색</caption>
					<colgroup>
						<col width="25%" />
						<col width="" />
					</colgroup>
					<tr>
						<th><label for="">지역명</label></th>
						<td><input class="map_input" id="" type="text"  /> </td>
					</tr>
					<tr>
						<td colspan="2"><span>검색결과가 없습니다.</span><a class="btn_search" href="#">검색</a></td>
					</tr>
				</table>
			</div>
			<!-- //스크랩팝업 --> 
		</form>
	</article>
</section>
  <!-- //content -->
</div>
<script>
var playerImg = "http://releases.flowplayer.org/swf/flowplayer-3.2.18.swf";
var playerConfig = {

    clip: {
        url: 'mp4:${sceneInfo.vdoId}.mp4',
        scaling: 'fit',
        // configure clip to use hddn as our provider, referring to our rtmp plugin
        provider: 'hddn'
    },

    // streaming plugins are configured under the plugins node
    plugins: {

        // here is our rtmp plugin configuration
        hddn: {
            url: "flowplayer.rtmp-3.2.13.swf",

            // netConnectionUrl defines where the streams are found
            netConnectionUrl: 'rtmp://localhost:1935'
        }
    },
    canvas: {
        //backgroundGradient: 'none',
        backgroundColor: "#000"
    }
};

$("#id_playerButton").click(function(evt){
	$f("id_vdoPlayer", playerImg, playerConfig).load();	
});
</script>
</body>
</html>