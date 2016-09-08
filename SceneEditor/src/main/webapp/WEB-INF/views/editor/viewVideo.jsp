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
  <title> 영상조회</title>
  <!--[if lt IE 9]>
	<script type="text/javascript" src="${contextRoot}/js/html5shiv.js"></script>
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
	    name   : 'videoGrid',
        url:'/getVideoListAsJson?page=1&pageSize=2000',          
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
        offset: 0,
        searches: [                
            { field: 'vdoTitle', caption: '제목', type: 'text' },
            { field: 'language', caption: '언어', type: 'text' },
            { field: 'productionDate', caption: '제작일시', type: 'date' },
        ],
    	columns:[                
	        { field: 'recid', caption: '순서', size: '2%', attr: 'align=center'},
	        { field: 'vdoId', caption: '영상ID', size: '5%', sortable:true, attr: 'align=center'},
	        { field: 'vdoTitle', caption: '제목', size: '30%', sortable:true, attr: 'align=center' },
	        { field: 'vdoType', caption: '유형', size: '3%', sortable:true, attr: 'align=center' },
	        { field: 'runtime', caption: '상영시간', size: '20%', sortable:true, attr: 'align=right'},
	        { field: 'language', caption: '언어', size: '20%', sortable:true, attr: 'align=center'},
	        { field: 'productionDate', caption: '제작일시', size: '10%', sortable:true, render:'date_format', attr: 'align=center'},
	        { field: 'scnCnt', caption: '장면정보개수', size: '10%', sortable:true, render:'decimalSymbol', attr: 'align=center',
	        	render: function (record) {
	        		if( record.scnCnt > 0){	        			
	                	return '<a href=\"/viewScene?vdoId=' + record.vdoId + '\">' + record.scnCnt +'</a>';
	        		}else{
						return record.scnCnt;	        			
	        		}
	            }
	        }
	    ]
	}
};

function refreshGrid(auto) {
	w2ui['videoGrid'].load("/getVideoListAsJson?page=0&pageSize=3700");
    w2ui['videoGrid'].autoLoad = auto;
    w2ui['videoGrid'].skip(0);    
	w2ui['videoGrid'].refresh();
}

$(function(){
	$('#id_videoGrid').w2grid(config.grid);
	
	w2ui['videoGrid'].on('click', function(target, eventData){
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
         <h1><a href="#"><img src="${contextRoot}/images/title.png" alt="장면정보 입력 관리 시스템" /></a></h1>
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
                   	<select id="id_searchField">
						<option>제목</option>
                        <option>내용</option>
                    </select>
				</li>
				<li><input id="" type="text" /></li>
                <li><a class="btn_search" href="#">검색</a></li>
			</ul>
			<a class="btn_item" href="#">항목관리</a>
		</div> 
		<div class="sub_tit">영상조회 <input type="checkbox" id="autoLoad" onclick="refreshGrid(this.checked)" checked></div>
		<article class="tbl_area" id="id_videoGrid">
		</article>
	</section>
    <!-- //content -->
    
    
</div>
</body>
</html>