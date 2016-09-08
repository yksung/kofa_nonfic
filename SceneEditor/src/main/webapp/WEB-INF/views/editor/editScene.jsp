<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 
%><%@ page session="false" 
%><%@ page contentType="text/html; charset=utf-8" %><%
response.setHeader("Content-Type", "text/html");
response.setContentType("text/html;charset=UTF-8");
response.setCharacterEncoding("utf-8"); 
%>
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html >
<html  lang="ko">
<head>
<meta charset="utf-8" />
<title>장면정보 입력 관리 시스템 - WISE Scene Editor V1.0</title>
<!--[if lt IE 9]>
<script type="text/javascript" src="${contextRoot}/js/html5shiv.js"></script>
<![endif]-->
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/style01.css">
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/default.css">
<script type="text/javascript" src="${contextRoot}/js/jquery-3.1.0.min.js"></script>
<script type="text/javascript" src="${contextRoot}/js/beta.fix.js"></script>
<script type="text/javascript" src="${contextRoot}/js/ark.js"></script>
<script type="text/javascript">
$(function(){
	$("#id_eventLClasCd").on("change", function(){
		var val = $(this).val();
		$.ajax({
			url : "${contextRoot}/getEventAsJson?upperClasCd="+val,
			type : "get",
			contentType : "text/html; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				var html = '';
				$.each(data, function(i, pair){
					html += "<option value='" + pair.clasCd + "'>" + pair.clasNm + "</option>";
					console.log(i +":"+ pair.clasCd + ", " + pair.clasNm);
				});
				$("#id_eventSClasCd").html(html);
			},
			error : function ( request, status, error ){
				alert("code : " + request.status + "\n" + "message : "+ request.responseText + "\n" + "error : " + error);
			}
		});
	});
		
	$("#id_domAbr").on("change", function(){
		var val = $(this).val();
		var cntryCd = "${sceneInfo.cntryCd}";
		$.ajax({
			url : "${contextRoot}/getCountryAsJson?domAbr="+val,
			type : "get",
			contentType : "text/html; charset=UTF-8",
			dataType : 'json',
			success : function(data){
				var html = '';
				$.each(data, function(i, pair){
					html += "<option value='" + pair.cntryCd;
					if(cntryCd==pair.cntryCd){
						html+= " selected ";
					}
					html += "'>" + pair.cntryNm + "</option>";
					console.log(i +":"+ pair.cntryCd + ", " + pair.cntryNm);
				});
				$("#id_cntryCd").html(html);
			},
			error : function ( request, status, error ){
				alert("code : " + request.status + "\n" + "message : "+ request.responseText + "\n" + "error : " + error);
			}
		});
	});
	
	$("img.popup_close").on("click", function(){
		$("div.map_pop").hide();
	});
	
	$("a.btn_map").on("click", function(){
		$("div.map_pop").show();
	});
});
	
function submit(){
	var f = document.form;
	f.submit();
}
</script>
</head>
<body>
<!-- skip -->
<nav class="skip">
	<a href="#top">헤더 바로가기</a>
	<a href="#vdo_area">재생중인 영상 바로가기</a>
	<a href="#info_area">메타입력 정보 바로가기</a>
</nav>
<!-- //skip -->

<div class="wrap">
	<!-- header -->
	<header class="top" id="top">
         <h1><a href="#"><img src="${contextRoot}/images/title.png" alt="장면정보 입력 관리 시스템" /></a></h1>
         <a class="btn_scnSearch" href="#">장면정보 검색</a>
         <ul>
         	<li>입력자 : ${sceneInfo.editor }</li>
         	<li>마지막 입력시간 : ${ sceneInfo.updDtime }</li>
         </ul>
	</header>
    <!-- //header -->
    
    <!-- content -->
    <section class="content">
    	<article class="vdo_area" id="vdo_area">
            <header>
           		<h2>제목 : <strong>${ sceneInfo.vdoNm }</strong></h2>
           		<a href="#">영상불러오기</a>
            </header>
            <div class="vdo_player">
            		비디오영역
            </div>
         </article>
         
         <article class="info_area" id="info_area">
         	<header>
         		<h2>메타입력 정보</h2>
            	<a href="${contextRoot }/viewScene?vdoId=${sceneInfo.vdoId}">목록보기</a>
                <ul>
                	<li><a class="btn_prev <c:if test='${ prevExists == 1 }'>on</c:if>" href="${contextRoot }/editScene?vdoId=${ sceneInfo.vdoId }&scnId=${sceneInfo.scnId}&direction=-1">이전정보</a></li>
                    <li><a class="btn_next <c:if test='${ nextExists == 1 }'>on</c:if>" href="${contextRoot }/editScene?vdoId=${ sceneInfo.vdoId }&scnId=${sceneInfo.scnId}&direction=1">다음정보</a></li>
				</ul>
            </header>
            <form name="thisScene" action="${contextRoot }/updateScene" method="POST">
            	<input type="hidden" name="scnId" value="${ sceneInfo.scnId }"/>
				<input type="hidden" name="vdoId" value="${ sceneInfo.vdoId }"/>
            	<table summary="메타정보를 입력할 수 있는 양식">
                    <caption>메타입력정보</caption>
                    <colgroup>
                        <col width="68px"/><col width="*"/>
                    </colgroup>
                    <tbody>
                    	<tr>
                          	<th>타임코드</th>
                    		<td>
                               	<label for="id_scnStartCd">시작*</label><input id="id_scnStartCd" type="text" placeholder="mmm:ss" value="${sceneInfo.scnStartCd }"/>
                               	<label for="id_scnEndCd">종료</label><input id="id_scnEndCd" type="text" placeholder="mmm:ss" value="${sceneInfo.scnEndCd }"/> 
                            </td>
						</tr>
                        <tr>
                          	<th>사건<a href="#"><img src="${contextRoot}/images/btn_plus.png" alt="사건 추가" /></a></th>
                            <td>
                        		<label for="">대분류*</label>
                        		<select id="id_eventLcls">
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
						</tr>
                        <tr>
                        	<th></th>
                            <td>
                            	<label for="id_eventNm">직접입력</label><input class="size" id="id_eventNm" type="text" value="${sceneInfo.eventNm }"/> 
                        		<span id="id_eventArk"></span>
							</td>
						</tr>
                        <tr>
							<th>사건연대</th>
                            <td>
                            	<select id="id_eventPrd">
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
                                <select class="marL" id="id_domAbr">
                                	<c:choose>
										<c:when test="${ sceneInfo.domAbr == 'domestic' }">
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
                                <select class="marL"  id="id_cntryCd">
                                	<c:forEach var="item" items="${ countryList }">
										<c:choose>
											<c:when test="${ item.cntryCd == sceneInfo.cntryCd }">
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
								<label for="id_eventPlace">장면 상 장소</label><input id="id_eventPlace" type="text" placeholder="POI 또는 행정구역명" value="${sceneInfo.eventPlace }"/>
								<label for="id_realPlace">실제장소</label><input id="id_realPlace" type="text" placeholder="POI 또는 행정구역명" value="${sceneInfo.realPlace }"/>
							</td>
						</tr>
						<tr>
							<th></th>
							<td>
								<label for="">위/경도 정보</label><input class="bg" id="" type="text" placeholder="자동입력됩니다." value="${sceneInfo.latitude }"/>
                                <input class="bg" id="" type="text" placeholder="자동입력됩니다." value="${sceneInfo.longitude}"/>
								<a class="btn_map" href="#">지도검색</a>
							</td>
						</tr>
                        <tr>
							<th>인물명</th>
							<td>
								<input id="id_celebrity1" type="text" placeholder="유명인만 기재" value="${sceneInfo.celebrity1 }"/>
								<input id="id_celebrity2" type="text" placeholder="유명인만 기재" value="${sceneInfo.celebrity2 }"/>
								<input id="id_celebrity3" type="text" placeholder="유명인만 기재" value="${sceneInfo.celebrity3 }"/>
								<a href="#"><img src="${contextRoot}/images/btn_plus.png" alt="인물 추가" /></a>
							</td>
						</tr>
						<tr class="textarea_h">
							<th>화면묘사</th>
							<td><textarea id="id_description">${sceneInfo.description }</textarea></td>
						</tr>
						<tr class="textarea_h">
							<th>내레이션</th>
							<td><textarea id="id_narration">${sceneInfo.narration }</textarea></td>
						</tr>
						<tr class="textarea_h">
                        	<th>자막</th>
							<td><textarea id="id_subtitles">${sceneInfo.subtitles }</textarea></td>
						</tr>
						<tr class="textarea_h">
							<th>장면요약</th>
							<td><textarea id="id_summary">${sceneInfo.summary }</textarea></td>
						</tr>
                        <tr class="textarea_h">
                        	<th>키워드</th>
                            <td><textarea id="id_keyword">${sceneInfo.keyword }</textarea></td>
						</tr>
					</tbody>
				</table>
                <ul class="btn_area">
					<li><a class="btn_save" href="#">저장</a></li>
					<li><a class="btn_check" href="#">검증</a></li>
					<li><a class="btn_del" href="#">삭제</a></li>
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
</body>
</html>