<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html >
<html  lang="ko">
<head>
	<meta charset="utf-8" />
	<title>통합검색</title>
	<!--[if lt IE 9]>
		<script type="text/javascript" src="js/html5shiv.js"></script>
 	<![endif]-->
	<script src="https://code.jquery.com/jquery-1.12.4.js"></script>
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<link rel="stylesheet" type="text/css" href="css/search_sty.css">
	<link rel="stylesheet" type="text/css" href="css/search_default.css">
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
<script>
function doPaging( page ){
	var form = document.searchForm;
	form.page.value = page;
	
	form.submit();
}
function goSearch(){
	var form = document.searchForm;
	form.searchField.value = "ALL";
	form.categoryField.value = "";
	form.categoryQuery.value = "";
	form.categorySearch.value = false;
	
	form.submit();
}

function setSearchField(field){
	var form = document.searchForm;
	form.searchField.value = field;
	form.categoryField.value = "";
	form.categoryQuery.value = "";
	form.categorySearch.value = false;
	
	form.submit();
}

function goCategorySearch(cateField, cateValue){
	var form = document.searchForm;
	form.categoryField.value = cateField;
	form.categoryQuery.value = cateValue;
	form.categorySearch.value = true;
	
	form.submit();
}

function goSort(sort){
	var form = document.searchForm;
	form.sort.value = sort;
	
	form.submit();
}

$(function(){
	$("#id_rangeslider").slider({
	      range: true,
	      min: 0,
	      max: ${maxRuntime},
	      values: [ ${form.runtimeMin}, ${form.runtimeMax} ],
	      slide: function( event, ui ) {
	    	  $("#runtime").val( ui.values[0]+"min. - " + ui.values[1]+"min." );
	      }
	});
	
	$("#id_rangeslider").on("slidechange", function(event, ui){
		var form = document.searchForm;
		if($("#id_rangeslider").slider("values",0)!=null){
			form.runtimeMin.value = ui.values[0];
		}else{
			form.runtimeMin.value = ui.min;
		}
		if($("#id_rangeslider").slider("values",1)!=null){
			form.runtimeMax.value = ui.values[1];
		}else{
			form.runtimeMax.value = ui.max;
		}
		
		form.submit();
	});
	
	$("#runtime").val( $("#id_rangeslider").slider("values", 0)+"min. - " + $("#id_rangeslider").slider("values", 1) + "min." );
});
</script>
</head>
<body>
<!-- skip -->
<nav class="skip">
		<a href="#top">검색창 영역 바로가기</a>
		<a href="#leftArea">왼쪽 영역 바로가기</a>
		<a href="#contents">검색결과 영역 바로가기</a>
        <a href="#rightArea">오른쪽 영역 바로가기</a>
</nav>
<!-- //skip -->

<div class="wrap">
	
	<!-- header -->
	<header class="header">
	<form name="searchForm" id="id_searchForm" action="/search" method="POST">
		<input type="hidden" name="page" value="0"/>
		<input type="hidden" name="pageSize" value="10"/>
		<input type="hidden" name="categorySearch" value="false"/>
		<input type="hidden" name="categoryGroupby" value="${strCategoryGroupby }"/>
		<input type="hidden" name="categoryField" value="${form.categoryField }"/>
		<input type="hidden" name="categoryQuery" value="${form.categoryQuery }"/>
		<input type="hidden" name="searchField" value="${form.searchField }"/>
		<input type="hidden" name="sort" value="${form.sort }"/>
		<input type="hidden" name="runtimeMin" value="${form.runtimeMin }"/>
		<input type="hidden" name="runtimeMax" value="${form.runtimeMax }"/>
		
		<div class="top" id="top">
        	<h1>
         		<a href="/search">
					<p><img src="images/icon_search.png" alt="검색" /></p>
                    <ul><li class="sm">비극영상물</li>
                    <li class="lg">장면정보 검색 시스템</li></ul>
				</a>
            </h1>
            <dl class="search_area">
            	<dd class="input_box"><input type="text" name="query" value="${form.query }" /></dd>
			</dl>
			<a class="searchBtn" href="javascript:goSearch();">검색</a>
		</div>
	</form>
	</header>
    <!-- //header -->
    
    <!-- container -->
    <c:if test="${totalCount > 0 }">
    <div class="container">
    </c:if>
    <c:if test="${totalCount <= 0 }">
    <div class="container2">
    </c:if>
		<!-- leftArea -->
		<section class="leftArea" id="leftArea">
			<article class="cateArea">
				<p class="tit">영상분류</p>
				<c:if test="${ fn:length(categoryResult.VDO_KIND)>0 }">
                <ul class="depth_1">
                <c:forTokens var="cate" items="${empty categoryResult.VDO_KIND ? ' ':categoryResult.VDO_KIND }" delims="@" varStatus="status">
					<li><a class="on" href="javascript:goCategorySearch('VDO_KIND', '${fn:split(cate, "^")[0] }')">${fn:split(cate, "^")[0] }<span>${fn:split(cate, "^")[1] }</span></a></li>
                </c:forTokens>
				</ul>
				</c:if>
			</article>
            <article class="cateArea">
            	<p class="tit">영상제작년도</p>
            	<c:if test="${ fn:length(categoryResult.VDO_PRODYEAR)>0 }">
					<ul class="depth_1">
					<c:forTokens var="cate" items="${empty categoryResult.VDO_PRODYEAR ? ' ':categoryResult.VDO_PRODYEAR }" delims="@" varStatus="status">
						<li><a class="on" href="javascript:goCategorySearch('VDO_PRODYEAR', '${fn:split(cate, "^")[0] }')">${fn:split(cate, "^")[0] }<span>${fn:split(cate, "^")[1] }</span></a></li>
					</c:forTokens>
					</ul>
				</c:if>
            </article>
			<article class="optionArea">
				<dl class="align">
					<dt>정렬</dt>
					<dd class="divi <c:if test='${fn:startsWith(form.sort, "RANK") or sort == ""}'>on</c:if>"><a href="javascript:goSort('RANK/DESC')">정확도순</a></dd>
					<dd class="divi <c:if test='${fn:startsWith(form.sort, "UPD_DTIME")}'>on</c:if>"><a href="javascript:goSort('UPD_DTIME/DESC')">최근수정순</a></dd>
				</dl>
				<dl class="area">
					<dt>검색영역</dt>
					<dd class="divi <c:if test='${form.searchField == "" or form.searchField == "ALL"}'>on</c:if>"><a href="javascript:setSearchField('ALL')">전체</a></dd>
					<dd class="divi <c:if test='${form.searchField == "EVENT_NM"}'>on</c:if>"><a href="javascript:setSearchField('EVENT_NM')">사건명</a></dd>
					<dd class="divi <c:if test='${form.searchField == "EVENT_PLACE,REAL_PLACE"}'>on</c:if>"><a href="javascript:setSearchField('EVENT_PLACE,REAL_PLACE')">사건장소</a></dd>
					<dd class="divi <c:if test='${form.searchField == "CELEBRITY"}'>on</c:if>"><a href="javascript:setSearchField('CELEBRITY')">인물명</a></dd>
					<dd class="divi <c:if test='${form.searchField == "DESCRIPTION"}'>on</c:if>"><a href="javascript:setSearchField('DESCRIPTION')">장면묘사</a></dd>
					<dd class="divi2 <c:if test='${form.searchField == "NARRATION,SUBTITLES"}'>on</c:if>"><a href="javascript:setSearchField('NARRATION,SUBTITLES')">내레이션/<br />자막</a></dd>
					<dd class="divi <c:if test='${form.searchField == "SUMMARY"}'>on</c:if>"><a href="javascript:setSearchField('SUMMARY')">장면요약</a></dd>
					<dd class="divi <c:if test='${form.searchField == "KEYWORD"}'>on</c:if>"><a href="javascript:setSearchField('KEYWORD')">키워드</a></dd>
				</dl>
				<dl>
					<dt>영상시간 범위</dt>
					<p style="padding-bottom:10px">
					  <input type="text" id="runtime" readonly style="border:0; color:#f6931f;">
					</p>
					<div id="id_rangeslider"></div>
				</dl>
			</article>
		</section>
         <!-- //leftArea -->
         
         <!-- contents -->
         <c:if test="${totalCount >0 }">
         <section class="contents" id="contents">
         	<c:choose>
         		<c:when test="${form.categoryField == 'VDO_KIND' }"><c:set var='vdoKindNm' value='영상분류'/></c:when>
         		<c:when test="${form.categoryField == 'VDO_PRODYEAR' }"><c:set var='vdoKindNm' value='영상제작년도'/></c:when>
         		<c:when test="${form.categoryField == 'EVENT_PRD' }"><c:set var='vdoKindNm' value='장면연대'/></c:when>
         		<c:when test="${form.categoryField == 'CNTRY_CD' }"><c:set var='vdoKindNm' value='장면지역'/></c:when>
         		<c:otherwise></c:otherwise>
         	</c:choose>
         	<div class="result_top">
         	[&nbsp;<c:choose><c:when test="${ form.categorySearch == true}">${vdoKindNm }>${fn:trim(form.categoryQuery) }</c:when>
         	<c:otherwise>전체영상</c:otherwise></c:choose>&nbsp;] 중 <strong>${query }</strong> (으)로 찾은 장면정보 검색 결과(<fmt:formatNumber value="${totalCount }" pattern="#,###" />건)입니다.</div>
         	<c:forEach var="result" items="${ resultList }" varStatus="status">
            <div class="sectit01">
                <h2><a href="/editor/editScene?vdoId=${result.VDO_ID }&scnId=${result.DOCID}">${ result.VDO_NM }<span> (<c:if test="${result.VDO_KIND != '-' and result.VDO_KIND!='' }">${result.VDO_KIND }, </c:if><c:if test="${result.VDO_PRODYEAR != 0 }">${result.VDO_PRODYEAR}년作, </c:if><c:if test="${result.VDO_LANG!='-' and result.VDO_LANG!='' }">${result.VDO_LANG }, </c:if><c:if test="${result.VDO_RUNTIME!=0}">${result.VDO_RUNTIME }분)</c:if> </span></h2>
                <div class="txt">${result.SCN_START_CD }~${result.SCN_END_CD }&nbsp;/&nbsp;${ result.SUMMARY }</div>
                <ul>
              		<li>&bull; <c:if test="${result.EVENT_PRD != 0}">${result.EVENT_PRD}년대, </c:if>${result.DOM_ABR }&gt;${result.CNTRY_CD }</li>
                	<c:if test="${result.DESCRIPTION != ''}"><li>&bull; <span>화면묘사</span> ${result.DESCRIPTION }</li></c:if>
                	<c:if test="${result.NARRATION != ''}"><li>&bull; <span>내레이션 </span> ${result.NARRATION }</li></c:if>
                	<c:if test="${result.SUBTITLES != ''}"><li>&bull; <span>자막</span> ${result.SUBTITLES }</li></c:if>
                </ul> 
			</div>
			</c:forEach>
        		<div class="btn_num">${paging }</div>
         </section>
         </c:if>
         <c:if test="${totalCount <= 0 }">
         <div class="contents">
             <div class="no_result">
                <div class="nort_img"><img src="images/no_result_img.png"  alt="검색결과 없음 이미지"/></div>
                <ul>
                  <li>단어의 철자가 정확한지 확인해주세요.</li>
                  <li>검색어의 단어 수를 줄이거나, 다른 검색어로 검색해 보세요.</li>
                  <li>보다 일반적인 검색어로 다시 검색해 보세요.</li>
                </ul>
          	</div>
          </div>
         </c:if>
         
         <!-- //contents -->
        
         <!-- rightArea -->
         <section class="rightArea" id="rightArea">
         	<article class="cateArea">
            		<p class="tit">연대</p>
            		<c:if test="${ fn:length(categoryResult.EVENT_PRD)>0 }">
					<ul class="depth_1">
					<c:forTokens var="cate" items="${empty categoryResult.EVENT_PRD ? ' ':categoryResult.EVENT_PRD }" delims="@" varStatus="status">
						<li><a class="on" href="javascript:goCategorySearch('EVENT_PRD', '${fn:split(cate, "^")[0] }')">${fn:split(cate, "^")[0] }<span>${fn:split(cate, "^")[1] }</span></a></li>
					</c:forTokens>
					</ul>
					</c:if>
            </article>
            <article class="cateArea">
            		<p class="tit">지역</p>
            		<c:if test="${ fn:length(categoryResult.CNTRY_CD)>0 }">
					<ul class="depth_1">
					<c:forTokens var="cate" items="${empty categoryResult.CNTRY_CD ? ' ':categoryResult.CNTRY_CD }" delims="@" varStatus="status">
						<li><a class="on" href="javascript:goCategorySearch('CNTRY_CD', '${fn:split(cate, "^")[0] }')">${fn:split(cate, "^")[0] }<span>${fn:split(cate, "^")[1] }</span></a></li>
					</c:forTokens>
                   	</ul>
                   	</c:if>
            </article>
		</section>
         <!-- //rightArea -->
	</div>
    <!-- //container -->
    
</div>
</body>
</html>