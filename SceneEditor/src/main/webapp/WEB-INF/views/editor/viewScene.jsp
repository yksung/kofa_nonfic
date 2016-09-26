<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/style02.css">
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
        url:'/editor/getSceneListAsJson?vdoId=${videoInfo.vdoId}',          
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
	                return '<a href=\"${contextRoot}/editor/editScene?vdoNm=${videoInfo.vdoTitle}&vdoId=${videoInfo.vdoId}&scnId=' + record.scnId + '\">GO</a>';
	            }
	        }
	    ]
	}
};

function refreshGrid(auto) {
	w2ui['sceneGrid'].load("${contextRoot}/editor/getSceneListAsJson?vdoId=${vdoId}");
    w2ui['sceneGrid'].autoLoad = auto;
    w2ui['sceneGrid'].skip(0);    
	w2ui['sceneGrid'].refresh();
}

function createNewSceneInfo(vdoNm, vdoId){
	location.href = "${contextRoot}/editor/editScene?vdoNm="+vdoNm+"&vdoId="+vdoId;
}

$(function(){
	$('#id_sceneGrid').w2grid(config.grid);
	
	w2ui['sceneGrid'].on('click', function(target, eventData){
		console.log("ddd!!!");
	});
});

</script>
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
			<li><a class="btn_undo" href="#"><img src="${contextRoot}/images/icon_undo.png" alt="영상조회로 돌아가기" /></a></li>
			<li><a class="btn_newvdo" href="javascript:createNewSceneInfo('${videoInfo.vdoTitle}', '${videoInfo.vdoId}')">새 장면 입력하기</a></li>
		</ul>
	</div>
	<article class="tbl_area" id="id_sceneGrid"></article>
</section>
<!-- //content -->