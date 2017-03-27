$(function(){	
	$("img.popup_close").on("click", function(){
		$("div.map_pop").hide();
	});
	
	$("a.btn_map").on("click", function(){
		$("div.map_pop").find("input[type='text']").val("");
		$("#search_result").html("");
		$("div.map_pop").show();
	});
	
	$(".btn_login").click(function(){
		if($("#id_username").val() == '' || $("#id_password").val() == ''){
			alert('아이디와 비밀번호를 모두 입력하십시오.');
			return false;
		}
		dataString = $("#loginForm").serialize();
		
		$.ajax({
			url : "/login/loginOk",
			data : dataString,
			type : "POST",
			success : function(result){
				if(result=='true'){
					location.href = "/editor/viewVideo?page=0&pageSize=10";
				}else{
					alert("로그인에 실패했습니다.");
				}
			},
			error : function ( request, status, error ){
				alert("code : " + request.status + "\n" + "message : "+ request.responseText + "\n" + "error : " + error);
			}
		});
	});
	
	$("body").on("click", "input[name='searchPerson']", function(e){
		e.preventDefault();
		var id = e.target.getAttribute("id").substring(e.target.getAttribute("id").lastIndexOf("_")+1);
		searchPerson(id);
	});
	
	$("body").on("click", "input[name='celebrityNm']", function(e){
		e.preventDefault();
		var id = e.target.getAttribute("id").substring(e.target.getAttribute("id").lastIndexOf("_")+1);
		layer_open('id_addcelebrity_'+id, 'layer_addcelebrity_'+id);
	});
	
	$("body").on("click", "a.minus", function(e) {
		e.preventDefault();
	    var $parent = $(this).parent(); // <li>
	    // (-) 버튼이 인물명의 것인 경우 장면-인물명 매핑 테이블에서 성공적으로 삭제했는지 여부(result)에 따라
	    // input element 자체를 삭제할지 결정.
	    if($parent.attr("name")=='celebrity' && $(this).prev().val()!=""){
	    	// 직전 element인 input의 인물명 가져오기
	    	var personKorNm = '';
	    	$(this).prevUntil("li").each(function(){
	    		if($(this).is("input")){
	    			personKorNm = $(this).val().substring(0, $(this).val().indexOf("("));        			
	    		}
	    	});
	    	var param = "personKorNm="+encodeURIComponent(personKorNm)+"&scnId="+$("input[name='scnId']").val();
	    	
	    	$.ajax({
	    		url : "/editor/deletePersonFromMapping?"+param,
	    		type : "POST",
	    		dataType : "json",
	    		success : function(result){
	    			if(result.total > 0){
	    				alert("인물명을 매핑 정보에서 삭제했습니다.");
	    				
	    				if($parent.parent().children().length > 1 ){        	
	    	    	    	$parent.remove();
	    	    	    }else{
	    	    	    	$parent.find("input[type='text']").val(""); 
	    	    	    	$parent.find(".list-group").remove();
	    	    	    }
	    			}else{
	    				alert("매핑 정보에서 인물명 삭제에 실패하였습니다.");
	    			}
	    		},
	    		error : function ( request, status, error ){
	    			alert("code : " + request.status + "\n" + "message : "+ request.responseText + "\n" + "error : " + error);
	    		}
	    	});
	    	
	    	
	    }else{ // (-) 버튼이 인물명 것이 아니면 element 를 바로 삭제.
	    	if($parent.parent().children().length > 1 ){        	
    	    	$parent.remove();
    	    }else{
    	    	$(this).prevUntil("li").each(function(){
    	    		if($(this).is("input[type='text']")){
    	    			$(this).val("");        			
    	    		}
    	    	});
    	    }
	    }
	    
	});
	
	$("li[name='event']>a").on("click", function(){
		var val = $(this).text();
		var eventCd = $(this).parent().attr("id");
		var eventDate = "";
		var eventNm = "";
		if( val.indexOf("/") > 0){
			eventDate = val.split("/")[0];
			eventNm = val.split("/")[1];
		}
		$("#id_editlist").find("input[name='editEventNm']").val(eventNm);
		$("#id_editlist").find("input[name='editEventDate']").val(eventDate);
		$("#id_editlist").find("input[name='editEventCd']").val(eventCd);
		layer_open("id_editlist", "layer_edit");
	});
});

function addEvent(){
	var newForm = "";
	newForm += "<form action='/manager/addEvent' method='POST'>";
	newForm += "	<input type='hidden' name='eventCd' value='"+$("#id_addEventCd").val()+"'/>";
	newForm += "	<input type='hidden' name='eventNm' value='"+$("#id_addEventNm").val()+"'/>";
	newForm += "	<input type='hidden' name='eventDate' value='"+$("#id_addEventDate").val()+"'/>";
	newForm += "</form>"
	$(newForm).appendTo("body").submit();
}

function editEvent(){
	var newForm = "";
	newForm += "<form action='/manager/updateEvent' method='POST'>";
	newForm += "	<input type='hidden' name='eventNm' value='"+$("#id_editEventNm").val()+"'/>";
	newForm += "	<input type='hidden' name='eventCd' value='"+$("#id_editEventCd").val()+"'/>";
	newForm += "	<input type='hidden' name='eventDate' value='"+$("#id_editEventDate").val()+"'/>";
	newForm += "</form>"
	$(newForm).appendTo("body").submit();
}

function layer_open(el, layer){
	var temp = $('#' + el);     //레이어의 id를 temp변수에 저장
	var layerId = $("#"+layer);
	
	temp.show();
	var bg = temp.prev().hasClass('bg');    //dimmed 레이어를 감지하기 위한 boolean 변수
	if(bg){
		$(layerId).fadeIn();
	}else{
		temp.fadeIn();  //bg 클래스가 없으면 일반레이어로 실행한다.
	}

	// 화면의 중앙에 레이어를 띄운다.
	if (temp.outerHeight() < $(document).height() ){
		temp.css('margin-top', '-'+temp.outerHeight()/2+'px');
	}
	else{
		temp.css('top', '0px');
	}
	
	if (temp.outerWidth() < $(document).width() ){
		temp.css('margin-left', '-'+temp.outerWidth()/2+'px');
	}
	else{
		temp.css('left', '0px');
	}
	 
	$('.layer .bg').click(function(e){
		$('.layer').fadeOut();
		e.preventDefault();
	});
	 
}

function layer_close(el){
	$("#"+el).hide();
	$('.layer').fadeOut();
}

function deleteEvent(){
	var newForm = "";
	newForm += "<form action='/manager/deleteEvent' method='POST'>";
	newForm += "	<input type='hidden' name='eventCd' value='"+$("#id_editEventCd").val()+"'/>";
	newForm += "</form>"
	$(newForm).appendTo("body").submit();
}


function onEventChange(){
	$("#id_eventLClasCd").on("change", function(){
		var val = $(this).val();
		$.ajax({
			url : "/editor/getEventAsJson?upperClasCd="+val,
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
}

function onDomAbrChange(cntryCd){
	$("body").on("change", "#id_domAbr", function(){
		var val = $(this).val();
		$.ajax({
			url : "/editor/getCountryAsJson?domAbr="+val,
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
				});
				$("#id_cntryCd").html(html);
			},
			error : function ( request, status, error ){
				alert("code : " + request.status + "\n" + "message : "+ request.responseText + "\n" + "error : " + error);
			}
		});
	});
}

function serializeInputArray(selector, delimiter){
	var serializedStr = "";
	var $el = $(selector); // selector must be the name of a input array.
	var loop = 0;
	
	$el.each(function(){
		if($(this).val().trim() != ""){				
			serializedStr += $(this).val() + delimiter;
		}
		if(loop!=0){				
			$(this).remove();
		}
		loop++;
	});
	
	//alert(serializedStr + '\n' + serializedStr.replace(new RegExp(delimiter+"$", "g"), ""));
	$el.val(serializedStr.replace(new RegExp(delimiter+"$", "g"), ""));
}

function saveScene(){
	
	var $eventNm = $("input[name='eventNm']");
	var loop = 0;	
	
	serializeInputArray("input[name='eventNm']", "@^@");
	serializeInputArray("input[name='celebrity1']", "@^@");
	
	document.thisSceneForm.submit();
}

function deleteScene(v, s){
	$.ajax({
		url : "/editor/deleteScene",
		data : "vdoId="+v+"&scnId="+s,
		type : "get",
		contentType : "text/html; charset=UTF-8",
		success : function(data){
			alert(data + '건이 삭제되었습니다.');
						
			location.href = "/editor/viewScene?vdoId="+v;
		},
		error : function ( request, status, error ){
			alert("code : " + request.status + "\n" + "message : "+ request.responseText + "\n" + "error : " + error);
		}
	});
}

function cloneElement(elementType, elementName){ // elementType : celebrity, elementName: input	// ex)
	// <td>
	// 		<input id="id_celebrity1" name="celebrity1" type="text" value=""/>
	// 		<input id="id_celebrity2" name="celebrity2" type="text" value=""/>
	// </td>
	var selectorStr = elementType+"[name="+elementName+"]";
	if($(selectorStr).length==5){
		alert("5개까지만 입력할 수 있습니다.");
		return;
	}
	
	var parent = $(selectorStr).parent(); // <td id="id_celebrity">
	var lastIdx = Number($(selectorStr+":last").attr("id").substring($(selectorStr+":last").attr("id").lastIndexOf("_")+1))+1;
	
	$(selectorStr+":last").clone().appendTo(parent);
	if($(selectorStr).is("input[type='text']")){
		$(selectorStr+":last").val("");
		var clonedId = $(selectorStr+":last").attr("id");
		$(selectorStr+":last").attr("id", clonedId.substring(0, clonedId.lastIndexOf("_"))+"_"+lastIdx);
	}else{	
		$(selectorStr+":last").attr("id", lastIdx);
		$(selectorStr+":last").find("*").each(function(){
			if($(this).attr("id")!=null){
				var clonedId = $(this).attr("id");
				$(this).attr("id", clonedId.substring(0, clonedId.lastIndexOf("_"))+"_"+lastIdx);
			}
		});
		$(selectorStr+":last").find("input[type='text']").val("");
		$(selectorStr+":last").find(".list-group").remove();
	}
}

function plusEvent(elementType, elementName){ // elementType : li,  elementName: event
	
	var selectorStr = elementType+"[name="+elementName+"]";
	if($(selectorStr).length==5){
		alert("사건명은 5개까지만 입력할 수 있습니다.");
		return;
	}
	
	var parent = $(selectorStr).parent(); // <ul>
	
	$(selectorStr+":last").clone().appendTo(parent);
	
	// 이렇게 호출하면 마지막 element가 clone된 새로운 element로 바뀜.
	var $lastElement = $(selectorStr+":last");
	// 현재 마지막 element의 index를 가져와서 children 요소에 새로 id와 value를 부여함.
	var idx = $lastElement.index();
	if($lastElement.children().length>0){
		$lastElement.children().each(function(){
			var id = $(this).attr("id");
			var newId = id.substring(0, id.length-1);
			var $child = $(this);
			$child.attr("id", newId+idx);
			if($child.attr("value") != undefined){				
				$child.val("");
			}
			if($child.attr("onClick") != undefined){				
				$child.attr("onClick", "javascript:doArk('thisSceneForm', 'id_eventNm"+idx+"', 'id_eventArk"+idx+"', 'event')");
			}
			if($child.attr("onKeyUp") != undefined){				
				$child.attr("onKeyUp", "javascript:arkKeyUp(event, 'id_eventArk"+idx+"')");
			}
			if($child.children().length>0){
				$child.children().each(function(){
					$(this).remove();
				});
			}
		});
	}
	// 이 Element의 id를 index 순서에 맞춰 재할당.
	$lastElement.attr("id", "id_"+elementName+$lastElement.index());
	// 이 Element의 value를 빈 값으로 바꿈.
	if($lastElement.attr("value") != undefined ){		
		$lastElement.val("");
	}
}
/*
function add(elementType, elementName){
	var selectorStr = elementType+"[name="+elementName+"]";
	if($(selectorStr).length==5){
		alert("5개까지만 입력할 수 있습니다.");
		return;
	}
	
	var parent = $(selectorStr).parent(); // <td id="id_celebrity">
	
	$(selectorStr+":last").clone().appendTo(parent);
	if(elementType=='input'){
		$(selectorStr+":last").val();
	}else{	
		$(selectorStr+":last>input").val("");
	}
}*/

function open(el){
	$(el).show();
}

function close(el){
	$(el).hide();
	$(el+">input").each(function(){
		$(this).val("");
	});
}


function setPerson(idx, personKorNm, personEngNm, personId, scnId, vdoId){
	var displayName = personKorNm;
	if(personId != ''){
		displayName += "("+personId+")";
	}else{
		displayName += "(-)";
	}
	$("#id_celebrityNm_"+idx).val(displayName);
	var param = "personKorNm="+encodeURIComponent(personKorNm)+"&personEngNm="+personEngNm+"&personId="+personId+"&scnId="+scnId+"&vdoId="+vdoId;
	
	$.ajax({
		url : "/editor/mapSceneAndPerson?"+param,
		type : "POST",
		dataType : "json",
		async : false,
		success : function(result){
			if(result.total > 0){
				alert("인물명과 장면정보 매핑에 성공하였습니다.");
			}else{
				alert("인물명과 장면정보 매핑에 실패하였습니다.");
			}
		},
		error : function ( request, status, error ){
			alert("code : " + request.status + "\n" + "message : "+ request.responseText + "\n" + "error : " + error);
		}
	});
	
	layer_close('id_addcelebrity_'+idx)
}

function searchPerson(idx){
	$.ajax({
		url : "/editor/getCelebrityListAsJson?celebrityNm="+encodeURIComponent($("#id_personKorNm_"+idx).val()),
		type : "POST",
		dataType : "json",
		beforeSend:function(xhr, opts){
			if($("#id_personKorNm_"+idx).val().trim() == ""){
				alert("검색할 이름을 입력하세요.");
				xhr.abort(); // ajax 요청하지 않음.
			}
		},
		success : function(data){
			var str = "<div class=\"list-group\">";
			if (data.total > 0){
				$.each(data.records, function(i, el) {
					str += "<button type=\"button\" onclick=\"javascript:setPerson("+idx+",'"+el.korNm+"','"+el.engNm+"','"+el.personId+"','"+$("input[name='scnId']").val()+"','"+$("input[name='vdoId']").val()+"');\" class=\"list-group-item list-group-item-action\">"+el.korNm+"("+el.engNm+","+el.personId+")</button>";
				});
			}else{
				str += "<p>인명정보가 없습니다. 그래도 장면정보와 인물 간 매핑정보를 저장하겠습니까?</p>"
				str += "<p><a href='javascript:setPerson("+idx+",\""+$("#id_personKorNm_"+idx).val()+"\",\"\",\"\",\""+$("input[name='scnId']").val()+"\",\""+$("input[name='vdoId']").val()+"\");'>저장</a></p>";
			}
			str += "</div>";
			
			$("#id_personList_"+idx).html(str);
		},
		error : function ( request, status, error ){
			alert("code : " + request.status + "\n" + "message : "+ request.responseText + "\n" + "error : " + error);
		}
	});
}

function createNewSceneInfo(vdoNm, vdoId){
	location.href = "/editor/editScene?vdoNm="+vdoNm+"&vdoId="+vdoId;
}

function saveAndCreateNewScene(){
	
	var $eventNm = $("input[name='eventNm']");
	var loop = 0;
	
	serializeInputArray("input[name='eventNm']", "@^@");
	serializeInputArray("input[name='celebrity1']", "@^@");
	
	$("form[name='thisSceneForm']").attr("action", "/editor/saveAndCreateScene");
	
	$("form[name='thisSceneForm']").submit();
}