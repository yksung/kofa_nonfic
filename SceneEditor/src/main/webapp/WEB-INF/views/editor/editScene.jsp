<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
<fmt:parseNumber var="strVdoIdx" value="${fn:indexOf(vdoFilePath, 'vod') }"/>
<fmt:parseNumber var="vdoFilePathLen" value="${fn:length(vdoFilePath) }"/>
<c:set var="vdoFilePathReal" value="${fn:substring(vdoFilePath, strVdoIdx-1, vdoFilePathLen )}"/>
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/style01.css">
<script type="text/javascript" src="${contextRoot}/js/beta.fix.js"></script>
<script type="text/javascript" src="${contextRoot}/js/ark_function.js"></script>
<script type="text/javascript" src="${contextRoot}/js/flowplayer-3.2.13.js"></script>
<!-- content -->
<script>
var browserType = getBrowserType();
$(document).ready(function(){
	var str = "";
	
	str += '<a id="id_playerButton" href="#">';
	str += '<img src="${contextRoot}/images/showme.png" />';
	str += '</a>';
	
	$("#id_vdoPlayer").html(str);
	
	$("body").click(function(evt){
		var target = $(evt.target);
		if(target.parent().attr("id")=='id_playerButton' || target.attr("id")=='id_playerButton'){
			var videoFilePath = '${vdoFilePathReal}';
			if(videoFilePath.lastIndexOf('mp4')==videoFilePath.length-3){
				$f("id_vdoPlayer", playerImg, playerConfig).load();
			}else{
				$("#id_vdoPlayer").html('<span>mp4 형식의 영상이 아닙니다.</span>');
			}
		}
	});
});

function resize(obj) {
	obj.style.height = "1px";
	obj.style.height = (10+obj.scrollHeight)+"px";
}
</script>
<section class="content">
	<article class="vdo_area" id="vdo_area">
    	<header>
        	<h2>제목 : <strong>${ sceneInfo.vdoNm }</strong></h2>
        	<!-- <a href="#">영상불러오기</a> -->
		</header>
        <div class="vdo_player" id="id_vdoPlayer">
        </div>
	</article>
    
	<article class="info_area" id="info_area">
      	<header>
      		<h2>메타입력 정보</h2>
      		<c:if test="${ isValidUser }">
            <ul>
            <c:choose>
             	<c:when test='${ prevScene != 0 }'>
             	<li><a class="btn_prev on" href="${contextRoot }/editor/editScene?vdoId=${ sceneInfo.vdoId }&scnId=${prevScene}&direction=-1">이전정보</a></li>
             	</c:when>
             	<c:otherwise>
             	<li><a class="btn_prev" href="#">이전정보</a></li>
             	</c:otherwise>
             </c:choose>
             <c:choose>
             	<c:when test='${ nextScene != 0 }'>
                <li><a class="btn_next on" href="${contextRoot }/editor/editScene?vdoId=${ sceneInfo.vdoId }&scnId=${nextScene}&direction=1">다음정보</a></li>
                </c:when>
                <c:otherwise>
             	<li><a class="btn_next" href="#">다음정보</a></li>
             	</c:otherwise>
             </c:choose>
			</ul>
         	<a href="${contextRoot }/editor/viewScene?vdoId=${sceneInfo.vdoId}">목록보기</a>
			</c:if>
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
                       	<th>관련사건<c:if test="${ isValidUser }"><a href="javascript:plusEvent('li', 'event')" id="id_evnt_add"><img src="${contextRoot}/images/btn_plus.png" alt="사건 추가" /></a></c:if></th>
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
		                     		<c:if test="${ isValidUser }"><a class="minus" href="#"><img src="${contextRoot}/images/btn_minus.png" alt="사건 삭제" /></a></c:if>
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
								<option value="-">-</option>
								<option value="domestic" selected>국내</option>
								<option value="abroad">국외</option>
								</c:when>
								<c:when test="${ fn:trim(sceneInfo.domAbr) == 'abroad' }">
								<option value="-">-</option>
								<option value="domestic">국내</option>
								<option value="abroad" selected>국외</option>
								</c:when>
								<c:otherwise>
								<option value="-" selected>-</option>
								<option value="domestic">국내</option>
								<option value="abroad">국외</option>
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
							<input class="bg" id="id_latitude" name="latitude" type="text" placeholder="자동입력됩니다." value="${sceneInfo.latitude }" readonly/>
                            <input class="bg" id="id_longitude" name="longitude" type="text" placeholder="자동입력됩니다." value="${sceneInfo.longitude}" readonly/>
							<a class="btn_map" href="#">지도검색</a>
						</td>
					</tr>
                    <tr>
						<th>인물명<c:if test="${ isValidUser }"><a href="javascript:cloneElement('li', 'celebrity')" id="id_celb_add"><img src="${contextRoot}/images/btn_plus.png" alt="인물 추가" /></a></c:if></th>
						<td id="id_celebrity">
							<ul class="horizontal">
								<c:if test="${not empty scenePersonMapping }">
								<c:forEach var="celebrity" items="${empty scenePersonMapping ? ' ':scenePersonMapping }" varStatus="status">
								<li name="celebrity" id="id_celebrity_${status.index }">
									<input name="celebrityNm" id="id_celebrityNm_${status.index }" type="text" <c:if test="${ isValidUser eq false }">disabled</c:if>
											placeholder="유명인만 기재" value="${empty celebrity.korNm? '': fn:trim(celebrity.korNm) }(${celebrity.personId != null and fn:trim(celebrity.personId)!='' ? celebrity.personId:'-'})"/>
									<a class="minus" href="#"><img src="${contextRoot}/images/btn_minus.png" alt="인물 삭제" /></a>
									<!-- 인물명팝업 -->
									<div class="layer" id="layer_addcelebrity_${status.index }">
										<div class="bg"></div>
							            <div class="pop-layer" id="id_addcelebrity_${status.index }">
							            	<p>인물 추가<a href="javascript:layer_close('id_addcelebrity_${status.index }')"><img src="${contextRoot }/images/icon_close01.png" alt="닫기" /></a></p>
							                <input id="id_personKorNm_${status.index }" name="personKorNm" type="text" placeholder="인물명(한글)" value=""/>
											<input type="button" name="searchPerson" id="id_searchPerson_${status.index }" value="검색">
											<div id="id_personList_${status.index }"></div>
										</div>
									</div>
								<!-- //인물명팝업 --> 
								</li>
								</c:forEach>
								</c:if>
								<c:if test="${empty scenePersonMapping }">
								<li name="celebrity" id="id_celebrity_0">
									<input name="celebrityNm" id="id_celebrityNm_0" type="text" placeholder="유명인만 기재" value="" <c:if test="${ isValidUser eq false }">disabled</c:if>/>
									<c:if test="${ isValidUser }"><a class="minus" href="#"><img src="${contextRoot}/images/btn_minus.png" alt="인물 삭제" /></a></c:if>
									<!-- 인물명팝업 -->
									<div class="layer" id="layer_addcelebrity_0">
										<div class="bg"></div>
							            <div class="pop-layer" id="id_addcelebrity_0">
							            	<p>인물 추가<a href="javascript:layer_close('id_addcelebrity_0')"><img src="${contextRoot }/images/icon_close01.png" alt="닫기" /></a></p>
							                <input id="id_personKorNm_0" name="personKorNm" type="text" placeholder="인물명(한글)" value=""/>
											<input type="button" name="searchPerson" id="id_searchPerson_0" value="검색">
											<div class="button-list" id="id_personList_0"></div>
										</div>
									</div>
								</li>
								</c:if>
							</ul>
						</td>
					</tr>
					<tr class="textarea_h">
						<th>화면묘사</th>
						<td><textarea id="id_description" name="description" onkeyup="resize(this)">${sceneInfo.description }</textarea></td>
					</tr>
					<tr class="textarea_h">
						<th>내레이션</th>
						<td><textarea id="id_narration" name="narration" onkeyup="resize(this)">${sceneInfo.narration }</textarea></td>
					</tr>
					<tr class="textarea_h">
                     	<th>자막</th>
						<td><textarea id="id_subtitles" name="subtitles" onkeyup="resize(this)">${sceneInfo.subtitles }</textarea></td>
					</tr>
					<tr class="textarea_h">
						<th>장면요약</th>
						<td><textarea id="id_summary" name="summary" onkeyup="resize(this)">${sceneInfo.summary }</textarea></td>
					</tr>
                    <tr class="textarea_h">
                     	<th>키워드</th>
                        <td><textarea id="id_keyword" name="keyword" onkeyup="resize(this)">${sceneInfo.keyword }</textarea></td>
					</tr>
					<tr class="textarea_h">
                     	<th>비고</th>
                        <td><textarea id="id_note" name="note" onkeyup="resize(this)">${sceneInfo.note }</textarea></td>
					</tr>
				</tbody>
			</table>
			<c:if test="${ isValidUser }">
            <ul class="btn_area">
				<li><a class="btn_save" href="javascript:saveScene();">저장</a></li>
				<li><a class="btn_new" href="javascript:createNewSceneInfo('${fn:trim(sceneInfo.vdoNm)}', '${fn:trim(sceneInfo.vdoId)}');">새 장면 입력하기</a></li>
				<!-- <li><a class="btn_check" href="#">검증</a></li> -->
				<li><a class="btn_del" href="javascript:deleteScene('${fn:trim(sceneInfo.vdoId)}', '${fn:trim(sceneInfo.scnId) }');">삭제</a></li>
            </ul>
            </c:if>
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
						<td><input class="map_input" id="id_map_keyword" type="text" /></td>
					</tr>
					<tr>
						<td colspan="2">
						<div id="search_result"></div>
						<a class="btn_search" href="javascript:poiSearch();">검색</a></td>
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
function putLatLon(lat, lon){
	$("#id_latitude").val(lat);
	$("#id_longitude").val(lon);
	$("div.map_pop").hide();
}
function poiSearch(){
	$.ajax({
		url : "https://apis.skplanetx.com/tmap/pois?appKey=343afd6a-d5f8-3991-a8b2-6ca2659ef4a1&version=1&searchKeyword="+encodeURIComponent($("#id_map_keyword").val()),
		//contentType : 'application/json',
		/* data : {
			appKey : '343afd6a-d5f8-3991-a8b2-6ca2659ef4a1',
			version : 1, 	// 필수
			page : 1,		// 선택
			count : 5, 		// 선택
			searchKeyword : ,
			searchType: 'all',
			searchtypeCd: 'A'
		}, */
		type : "GET",
		success : function(response){
			var html = "<ul>";
			$.each(response.searchPoiInfo.pois.poi, function(idx, el){
				html += "<li><a href='javascript:putLatLon(\""+el.noorLat+"\",\""+el.noorLon+"\");'>"+el.name+"</a> &gt;"+el.upperAddrName+" "+el.middleAddrName+" "+el.lowerAddrName+" "+el.detailAddrName+"</li>";
			});
			
			html+="</ul>";
			
			$("#search_result").html(html);
		},
		error : function ( request, status, error ){
			alert("code : " + request.status + "\n" + "message : "+ request.responseText + "\n" + "error : " + error);
		}
	});
}
var playerImg = "http://releases.flowplayer.org/swf/flowplayer-3.2.18.swf";
var playerConfig = {

    clip: {
        url: 'mp4:${vdoFilePathReal}', // ${sceneInfo.vdoId}.mp4'
        scaling: 'fit',
        // configure clip to use hddn as our provider, referring to our rtmp plugin
        provider: 'hddn',
        onStart : function(){
        	$f("id_vdoPlayer").seek(${sceneStartsAt});
        }
    },

    // streaming plugins are configured under the plugins node
    plugins: {

        // here is our rtmp plugin configuration
        hddn: {
            url: "flowplayer.rtmp-3.2.13.swf",

            // netConnectionUrl defines where the streams are found
            netConnectionUrl: 'rtmp://210.124.107.21'
        }
    },
    canvas: {
        //backgroundGradient: 'none',
        backgroundColor: "#000"
    }
};
</script>
</body>
</html>