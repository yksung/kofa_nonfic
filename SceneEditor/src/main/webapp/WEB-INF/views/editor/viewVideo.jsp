<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<link rel="stylesheet" type="text/css" href="${contextRoot}/css/style02.css">
<c:set var="contextRoot" value="${pageContext.request.contextPath }"/>
<c:set var="vdoId" value="${empty vdoId ? 0:vdoId }"/>
<c:set var="page" value="${empty page ? 0:page }"/>
<c:set var="pageSize" value="${empty pageSize ? 0:pageSize }"/>
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
        url:'${contextRoot}/editor/getVideoListAsJson?vdoId=${vdoId}&page=${page}&pageSize=${pageSize}',          
	    show: { 
            toolbar: true,
            footer: true,
        },
        //multiSelect: false,         
        //reorderColumns: false,      
        msgRefresh: 'Loading...',
        //fixedBody: true,
        //fixedRecord : true,
        msgAJAXerrror : 'Uncaught AJAX error',
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
	                	return '<a href=\"${contextRoot}/editor/viewScene?vdoId=' + record.vdoId + '\">' + record.scnCnt +'</a>';
	        		}else{
						return record.scnCnt;	        			
	        		}
	            }
	        }
	    ]
	}
};

function refreshGrid(auto) {
	w2ui['videoGrid'].load("${contextRoot}/editor/getVideoListAsJson?vdoId=${vdoId}&page=${page}&pageSize=${pageSize}");
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
		<%-- <a class="btn_item" href="${contextRoot }/manager/">항목관리</a> --%>
	</div> 
	<div class="sub_tit">영상조회 <input type="checkbox" id="autoLoad" onclick="refreshGrid(this.checked)" checked></div>
	<article class="tbl_area" id="id_videoGrid"></article>
</section>
<!-- //content -->