<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/style02.css">
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
<c:set var="vdoId" value="${empty vdoId ? 0:vdoId }"/>
<c:set var="offset" value="${empty offset ? 0:offset }"/>
<c:set var="limit" value="${empty limit ? 0:limit }"/>
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
        url:'${contextRoot}/editor/getVideoListAsJson',
        postData: {
        	vdoId : ${vdoId}
        },
        autoLoad: true,
	    show: { 
            toolbar: true,
            footer: true,
        },
        multiSelect: true,         
        reorderColumns: false,      
        msgRefresh: 'Loading...',
        fixedBody: true,
        fixedRecord : true,
        msgAJAXerrror : 'Uncaught AJAX error',
        limit : 100,
        offset: 0,
        searches: [                
            { field: 'vdoTitle', caption: '제목', type: 'text' },
            { field: 'vdoType', caption: '유형', type: 'text' },
            { field: 'language', caption: '언어', type: 'text' },
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
	                	return '<a href=\"${contextRoot}/editor/viewScene?vdoId=' + record.vdoId + '\">' + record.scnCnt +'</a>';
	        		}else{
						return record.scnCnt;	        			
	        		}
	            }
	        }
	    ]
	}
};

$(function(){
	$('#id_videoGrid').w2grid(config.grid);
	
	$("#id_viewOnlyHavingScene").click(function(){
		if($("#id_viewOnlyHavingScene").is(":checked")){		
			w2ui['videoGrid'].postData['viewOnlyHavingScene'] = $(this).val();
		}else{
			w2ui['videoGrid'].postData['viewOnlyHavingScene'] = '';
		}
		w2ui['videoGrid'].reload();
	});
});

</script>
<!-- content -->
<section class="content" id="content">
	<form name="viewVideoForm" id="id_viewVideoForm" action="/editor/viewVideo" method="POST">
	<div class="opt">
		<a class="btn_item" href="${contextRoot }/manager/editEvent">항목관리</a>
	</div> 
	<div class="sub_tit">영상조회
		<span><label for="id_viewOnlyHavingScene">장면정보 존재하는 영상만 보기&nbsp;&nbsp;<input type="checkbox" id="id_viewOnlyHavingScene" name="viewOnlyHavingScene" value="y"/></label></span>
	</div> 
	<article class="tbl_area" id="id_videoGrid"></article>
	</form>
</section>
<!-- //content -->