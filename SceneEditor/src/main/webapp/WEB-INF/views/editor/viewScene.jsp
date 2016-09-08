<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 
%><%@ page session="false" 
%><%@ page contentType="text/html; charset=utf-8" %>
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
<!DOCTYPE html>
<html lang="ko">
 <head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <title>장면정보 입력 관리 시스템 - WISE Scene Editor V1.0</title>
  <!--[if lt IE 9]>
	<script type="text/javascript" src="js/html5shiv.js"></script>
  <![endif]-->
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/style02.css">
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/default.css">
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/w2ui-1.4.3.min.css">
<script type="text/javascript" src="http://ajax.googleapis.com/ajax/libs/jquery/2.1.0/jquery.min.js"></script>
<script type="text/javascript" src="${contextRoot}/js/w2ui-1.4.3.min.js"></script>
<script>
var localSettingsSI = {
	    "locale"         : "si-SI",
	    "date_format"    : "dd.mm.yyyy",
	    "date_display"    : "dd.mm.yyyy",
	    "time_format"    : "h24",
	    "float"          : "^[-+]?[0-9]*[\\.,]?[0-9]+$",
	    "currency"       : "^[-+]?[0-9]*[\\.,]?[0-9]+$",
	    "currencyPrefix" : "",
	    "currencySuffix" : "",
	    "currencyPrecision" : 2,
	    "groupSymbol"    : ".",
		"decimalSymbol"  : ","
	};
	
var config = {
	grid : { 
	    name   : 'sceneGrid',
        url:'/getSceneListAsJson?vdoId=${videoInfo.vdoId}',          
	    show: { 
            toolbar: true,
            footer: true,
        },
        //multiSelect: false,         
        //reorderColumns: false,      
        msgRefresh: 'Loading...',
        //fixedBody: true,
        //fixedRecord : true,
        limit : 50,
        offset: 0,/* 
        searches: [                
            { field: 'vdoTitle', caption: '제목', type: 'text' },
            { field: 'language', caption: '언어', type: 'text' },
            { field: 'productionDate', caption: '제작일시', type: 'date' },
        ], */
    	columns:[                
	        { field: 'recid', caption: '순서', size: '10%', attr: 'align=center'},
	        { field: 'scnId', caption: '장면ID', size: '10%', sortable:true, attr: 'align=center'},
	        { field: 'scnStartCd', caption: '시작코드', size: '20%', sortable:true, attr: 'align=center' },
	        { field: 'scnEndCd', caption: '종료코드', size: '20%', sortable:true, attr: 'align=center' },
	        { field: 'editor', caption: '입력자', size: '10%', sortable:true, render:'date_format', attr: 'align=center'},
	        { field: 'updDtime', caption: '마지막 수정 일시', size: '20%', sortable:true, render:'date_format', attr: 'align=center'},
	        { field: 'goEditoScene', caption: '상세보기', size: '10%', sortable:true, attr: 'align=center',
	        	render: function (record) {
	                return '<a href=\"/editScene?vdoId=${videoInfo.vdoId}&scnId=' + record.scnId + '\">GO</a>';
	            }
	        }
	    ]
	}
};

function refreshGrid(auto) {
	w2ui['sceneGrid'].load("/getSceneListAsJson?vdoId=${vdoId}");
    w2ui['sceneGrid'].autoLoad = auto;
    w2ui['sceneGrid'].skip(0);    
	w2ui['sceneGrid'].refresh();
}

$(function(){
	$('#id_sceneGrid').w2grid(config.grid);
	
	w2ui['sceneGrid'].on('click', function(target, eventData){
		console.log("ddd!!!");
	});
});

</script>
</head>
<body>
<!-- skip -->
<nav class="skip">
		<a href="#top">헤더 바로가기</a>
		<a href="#contnet">본문내용 바로가기</a>
</nav>
<!-- //skip -->
<div class="wrap">
	<!-- header -->
	<header class="top" id="top">
    	<h1><a href="#"><img src="images/title.png" alt="장면정보 입력 관리 시스템" /></a></h1>
        <a class="btn_scnSearch" href="#">장면정보 검색</a>
        <ul>
        	<li><strong>홍길동</strong> 님 (admin@admin.com) <a class="btn_logout" href="#">로그아웃</a></li>
            <li><a class="btn_myinfo" href="#">정보수정</a></li>
        </ul>
	</header>
    <!-- //header -->
    
    <!-- content -->
    <section class="content" id="content">
    	<div class="opt">
    		<ul>
    			<li>
    				<select id="">
    					<option>사건명</option>
    					<option>사건명</option>
					</select>
				</li>
				<li><input id="" type="text" /></li>
				<li><a class="btn_search" href="#">검색</a></li>
			</ul>
			<a class="btn_item" href="#">항목관리</a>
		</div> 
		<div class="sub_tit">
			<strong>${videoInfo.vdoTitle}</strong>의 장면 정보 조회
			<ul>
				<li><a class="btn_undo" href="#"><img src="images/icon_undo.png" alt="영상조회로 돌아가기" /></a></li>
				<li><a class="btn_newvdo" href="#">새 장면 입력하기</a></li>
			</ul>
		</div>
		<article class="tbl_area" id="id_sceneGrid"></article>
	</section>
    <!-- //content -->
</body>
</html>