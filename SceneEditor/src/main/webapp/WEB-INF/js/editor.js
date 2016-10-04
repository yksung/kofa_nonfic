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
	
	$("body").on("click", "a.minus", function(e) {
		e.preventDefault();
	    var $parent = $(this).parent(); // <li>
	    if($parent.parent().children().length > 1 ){        	
	    	$parent.remove();
	    }else{
	    	$(this).prevUntil("li").each(function(){
	    		if($(this).is("input")){
	    			$(this).val("");        			
	    		}
	    	});
	    }
	});
});



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
	$("#id_domAbr").on("change", function(){
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
					console.log(i +":"+ pair.cntryCd + ", " + pair.cntryNm);
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

function cloneElement(elementType, elementName){ // elementType : celebrity, elementName: input
	// ex)
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
	
	$(selectorStr+":last").clone().appendTo(parent);
	if(elementType=='input'){
		$(selectorStr+":last").val("");
	}else{	
		$(selectorStr+":last>input").val("");
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