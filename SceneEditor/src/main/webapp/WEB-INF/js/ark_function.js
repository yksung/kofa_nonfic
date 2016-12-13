function newMap() {
  var map = {};
  map.value = {};
  map.getKey = function(id) {
    return "k_"+id;
  };
  map.put = function(id, value) {
    var key = map.getKey(id);
    map.value[key] = value;
  };
  map.contains = function(id) {
    var key = map.getKey(id);
    if(map.value[key]!=null) {
      return true;
    } else {
      return false;
    }
  };
  map.get = function(id) {
    var key = map.getKey(id);
    if(map.value[key]!=null) {
      return map.value[key];
    }
    return null;
  };
  map.remove = function(id) {
    var key = map.getKey(id);
    if(map.contains(id)){
      map.value[key] = undefined;
    }
  };
 
  return map;
}

/*
 * 한 화면에 등장하는 모든 자동완성 요소들을 보호하며 표현할 수 있도록 map 방식 채택 (yksung@2016-09-25) 
 */

var g_oConvert		= newMap();	// 정방향, 역방향 값 (ex) "fw"
var isArk			= newMap();	// 자동완성 기능 사용 여부. (ex) true
var isKeydown		= newMap();	// 브라우저가 파이어폭스, 오페라일 경우 keydown 사용 여부. (ex) false
var isListShow		= newMap();	// (ex) true
var cursorPos		= newMap();	// 자동완성 커서 위치 값. (ex) -1
var formName		= newMap();	// ***초기화 필요*** 검색 form의 name을 설정한다. (ex) "thisSceneName"
var queryId			= newMap();	// ***초기화 필요*** 검색어 <input> 의 id을 설정한다. (ex) "#query"
var arkId			= newMap();	// ***초기화 필요*** 자동완성 전체 <div> 의 id을 설정한다. (ex) "#ark"
var wrapId 			= newMap();	// ***초기화 필요*** 자동완성 결과 <div> 의 id을 설정한다. (ex) "ark1_wrap"
var footerId 		= newMap();	// ***초기화 필요*** 자동완성 Footer <div> 의 id을 설정한다. (ex) "ark1_footer"
var contentListId 	= newMap();	// ***초기화 필요*** 자동완성 Content List <li> 의 id을 설정한다. (ex) "ark1_content_list"
var imgDownId 		= newMap();	// ***초기화 필요*** 자동완성 down 이미지 id을 설정한다. (ex) "ark_img_down"
var imgUpId 		= newMap();	// ***초기화 필요*** 자동완성 up 이미지 id을 설정한다. (ex) "ark_img_up"
var arkUpId 		= newMap();	// ***초기화 필요*** 자동완성 up 이미지 <div> 의 id을 설정한다. (ex) "ark_up"
var arkDownId		= newMap(); // ***초기화 필요*** 자동완성 down 이미지 <div> 의 id을 설정한다. (ex) "ark_down"
var totalFwCount 	= newMap();	// 전방 검색 전체 개수. (ex) 0
var totalRwCount 	= newMap();	// 후방 검색 전체 개수. (ex) 0
var target 			= newMap();	// ***초기화 필요*** ARK 웹서버 설정파일의 목록에 있는 추천어 서비스 대상을 지정한다. (ex) "event"
var charset 		= newMap();	// 인코딩 설정 (인코딩이 utf-8이 아닐 경우 8859_1 로 설정해야함). (ex) "utf-8"
var datatype		= newMap();	// 반환받을 Data의 타입을 설정. XML 과 JSON이 가능 (xml | json). (ex) "json"
var arkPath			= newMap();	// ***초기화 필요*** 자동완성 경로. (ex) ""
var transURL 		= newMap();	// ***초기화 필요*** trans 페이지의 URL을 설정한다. (ex) "/ark/event"
var tempQuery		= newMap();	// (ex) ""

/** ARK 구성요소의 위치 및 크기를 아래 변수를 통해 조정함. **/
var arkWidth		= newMap();	// 자동완성 전체 넓이 값을 설정한다(변동폭). (ex) 4
var arkTop			= newMap();	// 자동완성 상단에서의 위치 값을 설정한다. (ex) -55
var arkLeft			= newMap();	// 자동완성 왼쪽에서의 위치 값을 설정한다. (ex) -75
var arkImgTop		= newMap();	// 자동완성 화살표 이미지의 상단에서 위치 값을 설정한다. (ex) -52
var arkImgLeft		= newMap();	// 자동완성 화살표 이미지의 왼쪽에서 위치 값을 설정한다. (ex) -81
var tooltip01TopPos = newMap();	// 자동완성 기능끄기 툴팁의 상단 기준 위치 오차 조정값. (ex) 0
var tooltip01LeftPos= newMap();	// 자동완성 기능끄기 툴팁의 좌측 기준 위치 오차 조정값. (ex) -155
var tooltip02TopPos = newMap();	// 자동완성 기능켜기 툴팁의 상단 기준 위치 오차 조정값. (ex) 0
var tooltip02LeftPos= newMap();	// 자동완성 기능켜기 툴팁의 좌측 기준 위치 오차 조정값. (ex) 0

/**
 *  ARK 구성요소의 위치 및 크기를 아래 변수를 통해 조정함.
 */
var browser = getBrowserType().toUpperCase();

/** ARK 구성요소의 위치 및 크기를 아래 변수를 통해 조정함. **/
var IE6_TOP_OFFSET = -36;				// IE6 일 경우 TOP 옵셋 값 오차 조정
var IE6_LEFT_OFFSET = 20;				// IE6 일 경우 LEFT 옵셋 값 오차 조정
var IE7_TOP_OFFSET = -60;				// IE7 일 경우 TOP 옵셋 값 오차 조정
var IE7_LEFT_OFFSET = -18;				// IE7 일 경우 LEFT 옵셋 값 오차 조정
var IE8_TOP_OFFSET = 0;					// IE8 일 경우 TOP 옵셋 값 오차 조정
var IE8_LEFT_OFFSET = 0;				// IE8 일 경우 LEFT 옵셋 값 오차 조정
var FF_TOP_OFFSET = 0;
var FF_LEFT_OFFSET = 0;
var CHROME_TOP_OFFSET = 0;
var CHROME_LEFT_OFFSET = 0;
var OPERA_TOP_OFFSET = 0;
var OPERA_LEFT_OFFSET = 0;

var keyFix = new beta.fix('query');

function doArk(_formName, _queryId, _arkId, _target){
	g_oConvert.put(_arkId, "fw");
	isArk.put(_arkId, true);
	isKeydown.put(_arkId, false);
	isListShow.put(_arkId, true);
	cursorPos.put(_arkId, -1);
	formName.put(_arkId, _formName);
	queryId.put(_arkId, "#"+_queryId);
	arkId.put(_arkId, "#"+_arkId);
	wrapId.put(_arkId, _arkId + "_wrap");
	footerId.put(_arkId, _arkId + "_footer");
	contentListId.put(_arkId, _arkId + "_content_list");
	imgDownId.put(_arkId, _arkId + "_img_down");
	imgUpId.put(_arkId, _arkId + "_img_up");
	arkUpId.put(_arkId, _arkId + "_up");
	arkDownId.put(_arkId, _arkId + "_down");
	totalFwCount.put(_arkId, 0);
	totalRwCount.put(_arkId, 0);
	target.put(_arkId, _target);
	charset.put(_arkId, "utf-8");
	datatype.put(_arkId, "json");
	arkPath.put(_arkId, "");
	transURL.put(_arkId, "/ark/" + _target);
	tempQuery.put(_arkId, "");
	
	// 자동완성 기능 사용 여부 확인 한다.
	if(getCookie("ark")=="off") {
		isArk = false;
		$(queryId.get(_arkId)).attr("autocomplete","on");
	} else {
		$(queryId.get(_arkId)).attr("autocomplete","off");
	}

	// 브라우져별 ARK 옵셋 설정
	//setArkOffset();

	// 자동완성 <div> 생성
	drawArk(_arkId);

	// 자동완성 위치 설정
	setArkLocation(_arkId); // setArkOffset과 setArkSize과 통폐합.

	// 자동완성 넓이 및 높이 설정
	//setArkSize();

	if (browser == 'OPERA' || browser == 'MOZILLA') {
		//alert("oepra:" + $.browser.opera + " / mozilla:" + $.browser.mozilla);
		/*$(document).keydown(function(event) {
			var query = $(queryId.get(_arkId)).val();
			
			if (event.which == 38 || event.which == 40) {
				if (query != "") {
					showArk(_arkId);
				}
				moveFocusEvent(event, _arkId);
			} else {
				if ($(event.target).is(queryId.get(_arkId))) {
					isKeydown.put(_arkId, true);
					eventKeydown(_arkId);
				}
			}
		});*/
	} else if (browser == 'CHROME') {
		//alert("msie:" + $.browser.msie + " / webkit:" + $.browser.webkit);
		/*$(document).keyup(function(event) {
			var query = $(queryId.get(_arkId)).val();
			
			if (event.keyCode == 38 || event.keyCode == 40) {
				// 아래(40), 위(38) 방향키 조작시의 이벤트 처리
				if (query != "") {
					showArk(_arkId);
				}
				moveFocusEvent(event, _arkId);
			} else if (event.keyCode == 16) {
			} else if (event.keyCode == 8 && query == "") {
				$("#" + contentListId.get(_arkId)).html("");
				hideArk(_arkId);
			} else {
				if ($(event.target).is(queryId.get(_arkId))) {
					if (isArk.get(_arkId) && $(queryId.get(_arkId)).val() != "") {
						if(datatype.get(_arkId) == "json") {
							requestArkJson($(queryId.get(_arkId)).val(), _arkId);
						} else if(datatype.get(_arkId) == "xml") {
							requestArkXml($(queryId.get(_arkId)).val(), _arkId);
						}
					} else if ($(queryId.get(_arkId)).val() == "") {
						hideArk(_arkId);
					}
				}
			}
		});*/
	}

	// Backspace 에 대한 처리
	$(queryId.get(_arkId)).keyup(function(event) {
		if(event.keyCode == 8 && $(this).val() == "") {
			$("#" + contentListId.get(_arkId)).html("");
			hideArk(_arkId);
		}
	});

	// 브라우저에서 일어나는 클릭 이벤트를 체크한다.
	$(document).click(function(event) {
		stopEventBubble(event);
		if ($(event.target).is("#" + imgDownId.get(_arkId))) {
			isListShow.put(_arkId, false);
			showArk(_arkId);
			//showArkGuide();
			//setArkFooter();
		} else if ($(event.target).is("#" + imgUpId.get(_arkId))) {
			hideArk(_arkId);
		} else if ($(event.target).is(queryId.get(_arkId))) {
			if (isArk.get(_arkId)) {
				var query = $(queryId.get(_arkId)).val();
				if (query != "") {
					if(datatype == "json") {
						requestArkJson($(queryId.get(_arkId)).val(), _arkId);
					} else if(datatype == "xml") {
						requestArkXml($(queryId.get(_arkId)).val()), _arkId;
					}
					keyword.put(_arkId, query);
				}
				isKeydown.put(_arkId, true);
			}
		} else if (!$(event.target).is("#" + wrapId.get(_arkId))) {
			hideArk(_arkId);
		}
	});
	
	$("#" + imgUpId.get(_arkId)).hover(
		function() {
			$("#tooltip01_"+_arkId).show();
		},
		function() {
			$("#tooltip01_"+_arkId).hide();
		}
	);
}

function arkKeyUp(event, _ARKID_){
	var query = $(queryId.get(_ARKID_)).val();
	
	if (event.keyCode == 38 || event.keyCode == 40) {
		// 아래(40), 위(38) 방향키 조작시의 이벤트 처리
		if (query != "") {
			showArk(_ARKID_);
		}
		moveFocusEvent(event, _ARKID_);
	} else if (event.keyCode == 16) {
	} else if (event.keyCode == 8 && query == "") {
		$("#" + contentListId.get(_ARKID_)).html("");
		hideArk(_ARKID_);
	} else {
		if ($(event.target).is(queryId.get(_ARKID_))) {
			if (isArk.get(_ARKID_) && $(queryId.get(_ARKID_)).val() != "") {
				if(datatype.get(_ARKID_) == "json") {
					requestArkJson($(queryId.get(_ARKID_)).val(), _ARKID_);
				} else if(datatype.get(_ARKID_) == "xml") {
					requestArkXml($(queryId.get(_ARKID_)).val(), _ARKID_);
				}
			} else if ($(queryId.get(_ARKID_)).val() == "") {
				hideArk(_ARKID_);
			}
		}
	}
}

/************************************************
 * jQuery Event Bubbling 방지를 위한 함수.
 * @name stopEventBubble
 * @param evt 페이지 이벤트
 ************************************************/
function stopEventBubble(evt) {
	var eventReference = (typeof evt !== "undefined") ? evt : event;
	//alert(eventReference.stopPropagation);

	if(eventReference.stopPropagation) {
		eventReference.stopPropagation();
	} else {
		eventReference.cancelBubble = true;
	}
}

/************************************************
 * 자동완성 키워드 목록 출력을 위한 DIV 생성
 * @name drawArk
 ************************************************/
function drawArk(_ARKID_) {
	var str;

	// 자동완성 접기/펼침 이미지 생성
	str = "<div id=\"" + arkDownId.get(_ARKID_) + "\" style=\"position:absolute; display:block; cursor:pointer;\"><img id=\"" + imgDownId.get(_ARKID_) + "\" src=\"" + arkPath.get(_ARKID_) + "/images/arrow_auto.gif\" alt=\"자동완성펼치기\"></div>";
	str += "<div id=\"" + arkUpId.get(_ARKID_) + "\" style=\"position:absolute; display:none; cursor:pointer;\"><img id=\"" + imgUpId.get(_ARKID_) + "\" src=\"" + arkPath.get(_ARKID_) + "/images/arrow_auto2.gif\" alt=\"자동완성접기\" ></div>";
	
	// 툴팁 이미지 생성
	str += "<div id=\"tooltip01_"+_ARKID_+"\" style=\"position:absolute; display:none; cursor:pointer; z-index:999999;\"><img id=\"tooltipIcon01\" src=\"" + arkPath.get(_ARKID_) +"/images/tooltip_01.gif\"/></div>";

	// 자동완성 결과 생성
	str += "<div class=\"ark_wrap\" id=\"" + wrapId.get(_ARKID_) +"\">";
	str += "	<ul>";
	str += "		<li class=\"ark_content\" >";
	str += "			<ul class=\"fl\" id=\"" + contentListId.get(_ARKID_) + "\"></ul>";
	str += "		</li>";
	//str += "		<li class=\"ark_footer\" id=\"" + footerId +"\"></li>";
	str += "	</ul>";
	str += "</div>";

	$(arkId.get(_ARKID_)).html(str);
}

/************************************************
 * 자동완성 DIV의 위치 자동설정.
 * setArkOffset, setArkSize과 통합. (yksung@2016-09-25)
 * @name setArkLocation
 ************************************************/
function setArkLocation(_ARKID_) {
	var offsetTop = $(queryId.get(_ARKID_)).position().top; 
	var offsetLeft = $(queryId.get(_ARKID_)).position().left;

	arkWidth.put(_ARKID_, 4);
	arkTop.put(_ARKID_, offsetTop );
	arkLeft.put(_ARKID_, offsetLeft );
	arkImgTop.put(_ARKID_, offsetTop+34);
	arkImgLeft.put(_ARKID_, offsetLeft);
	tooltip01TopPos.put(_ARKID_, offsetTop+25);
	tooltip01LeftPos.put(_ARKID_, offsetLeft+30);
	tooltip02TopPos.put(_ARKID_, offsetTop+25);
	tooltip02LeftPos.put(_ARKID_, offsetLeft+30);
	

	/*if (browser == "IE") {
		if (browserVersion == "6.0") {
			offsetTop = offsetTop + IE6_TOP_OFFSET;
			offsetLeft = offsetLeft + IE6_LEFT_OFFSET;
		} else if (browserVersion == "7.0") {
			offsetTop = offsetTop + IE7_TOP_OFFSET;
			offsetLeft = offsetLeft + IE7_LEFT_OFFSET;
			offsetTop = offsetTop - 2;
		} else if (browserVersion == "8.0") {
			offsetTop = offsetTop + IE8_TOP_OFFSET;
			offsetLeft = offsetLeft + IE8_LEFT_OFFSET;
		}
	} else */
	if (browser == "FF") {
		offsetTop = offsetTop + FF_TOP_OFFSET;
		offsetLeft = offsetLeft + FF_LEFT_OFFSET;
	} else if (browser == "CHROME") {
		offsetTop = offsetTop + CHROME_TOP_OFFSET;
		offsetLeft = offsetLeft + CHROME_LEFT_OFFSET;
	} else if (browser == "OPERA") {
		offsetTop = offsetTop + OPERA_TOP_OFFSET;
		offsetLeft = offsetLeft + OPERA_LEFT_OFFSET;
	}
	
	var queryWidth = parseInt($(queryId.get(_ARKID_)).width());
	var queryHeight = parseInt($(queryId.get(_ARKID_)).height());

	// 자동완성 전체 위치 설정
	$(_ARKID_).css({"position" : "relative", "z-index":"999999", "top" : offsetTop + "px", "left" : offsetLeft + "px", "width" : (queryWidth + arkWidth.get(_ARKID_)) + "px"});

	// ARK Wrap의 위치 설정
	$("#" + wrapId.get(_ARKID_)).css({"position" : "absolute", "top" : arkTop, "left" : arkLeft, "background-color" : "#FFF" });

	// 화살표 닫기 이미지 위치 설정
	$("#" + arkUpId.get(_ARKID_)).css({"top" : (arkImgTop.get(_ARKID_) - queryHeight) + "px"});
	$("#" + arkUpId.get(_ARKID_)).css({"left" : ((queryWidth - 10) + arkImgLeft.get(_ARKID_)) + "px"});

	// 화살표 열기 이미지 위치 설정
	$("#" + arkDownId.get(_ARKID_)).css({"top" : (arkImgTop.get(_ARKID_) - queryHeight) + "px"});
	$("#" + arkDownId.get(_ARKID_)).css({"left" : ((queryWidth - 10) + arkImgLeft.get(_ARKID_)) + "px"});
	
	// 자동완성접기 툴팁 이미지 위치 설정
	$("#tooltip01_"+_ARKID_).css({"top" : (offsetTop + tooltip01TopPos) + "px", "left" : (offsetLeft + queryWidth + tooltip01LeftPos.get(_ARKID_)) + "px"});
	
	// 자동완성 DIV의 넓이/높이 자동설정
	$("#" + wrapId.get(_ARKID_)).css({"width" : (queryWidth + arkWidth.get(_ARKID_)) + "px"}); // 자동완성 넓이 설정
	$("#" + contentListId.get(_ARKID_)).css({"width" : (queryWidth + arkWidth.get(_ARKID_)) + "px"}); // 자동완성 결과 리스트 넓이 설정
	//$("#" + footerId).css({"width" : (queryWidth + arkWidth) + "px"}); // 자동완성 풋터 넓이 설정
}

/************************************************
 * 자동완성 결과 요청
 * @name requestArk
 * @param query 키보드 입력된 문자열
 ************************************************/
function requestArkJson(query, _ARKID_) {
	jQuery.support.cors = true;

	cursorPos.put(_ARKID_, -1);

	$.ajaxSetup({cache:false});
	$.ajax({
		url: transURL.get(_ARKID_),
		type: "POST",
		dataType: "json",
		data: {"convert":g_oConvert.get(_ARKID_), "target":target.get(_ARKID_), "charset":charset.get(_ARKID_), "query":query, "datatype": datatype.get(_ARKID_)},
		success: function(data) {
			if(data.result.length <= 0) {
				totalFwCount.put(_ARKID_, 0);
				totalRwCount.put(_ARKID_, 0);
			}

			var str = "";

			$.each(data.result, function(i, result) {
				var totalCount = parseInt(result.totalcount);
				if (i == 0) {
					totalFwCount.put(_ARKID_, totalCount);
				} else {
					totalRwCount.put(_ARKID_, totalCount);
				}

				if (totalCount > 0) {
					// 정방향, 역방향 구분선
					if (i > 0 && totalFwCount.get(_ARKID_) > 0 && totalRwCount.get(_ARKID_) > 0) {
						str += "<li style=\"border-top:1px solid #f3f3f3;\"></li>";
					}

					// 자동완성 리스트 설정
					$.each(result.items, function(num,item){
						if (i != 0) {
							num = totalFwCount.get(_ARKID_) + num;
						}

						str += "<li id=\"bg" + num + "\">" + item.hkeyword + "&nbsp;&nbsp;" + item.linkname;
						str += " <span id=\"f" + num + "\" style=display:none;>" + item.keyword + "</span></li>";
					});
				}
			});

			if ((totalFwCount.get(_ARKID_) + totalRwCount.get(_ARKID_)) == 0) {
				$("#" + contentListId.get(_ARKID_)).html("<li>해당 단어로 시작하는 검색어가 없습니다.</li>");
			} else {
				$("#" + contentListId.get(_ARKID_)).html(str);
			}

			//setArkFooter();
			showArk(_ARKID_);
		}
    });
}

function requestArkXml(query, _ARKID_) {
	jQuery.support.cors = true;

	cursorPos.put(_ARKID_, -1);
	totalFwCount.put(_ARKID_, 0);
	totalRwCount.put(_ARKID_, 0);

	$.ajaxSetup({cache:false});
	$.ajax({
		url: transURL.get(_ARKID_),
		type: "POST",
		dataType: "xml",
		data: {"convert":g_oConvert.get(_ARKID_), "target":target.get(_ARKID_), "charset":charset.get(_ARKID_), "query":query, "datatype": datatype.get(_ARKID_)},
		success: function(data, xhr) {
			var str = "";

			var $resultElement = $(data).find("Response").find("Value");
			var returnCode = $resultElement.find("Return").text();

			if (returnCode == 0) {
				if ($resultElement.find("ARKList").size() <= 0) {
					totalFwCount.put(_ARKID_, 0);
				} else {
					var totalCount = $resultElement.find("ARKList").find("TotalCount").text();
					totalFwCount.put(_ARKID_, totalCount);
				}

				if ($resultElement.find("ARKRList").size() <= 0) {
					totalRwCount.put(_ARKID_, 0);
				} else {
					var totalCount = $resultElement.find("ARKRList").find("TotalCount").text();
					totalRwCount.put(_ARKID_, totalCount);
				}

				// ARKList
				$resultElement.find("ARKList").each(function(idx) {
					$(this).find("ARK").each(function(idx) {
						var $ark = $(this);
						var hkeyword = $ark.attr("HKeyword");
						var keyword = $ark.attr("keyword");
						var count = $ark.attr("count");
						var type = $ark.attr("type");

						str += "<li id=\"bg"+ idx +"\" onclick=\"onClickKeyword(" + idx + ");\" onmouseover=\"onMouseOverKeyword(" + idx + ", '"+_ARKID_+"' );\"";
						str += " onmouseout=\"onMouseOutKeyword(" + idx + ", '"+_ARKID_+"' );\">" + showSource(parseInt(type)) + "&nbsp;&nbsp;" + hkeyword;
						str += " <span id=\"f" + idx +"\" style=display:none;>" + keyword + "</span>";
						str += " <span style=\"position:absolute; right:0;\">" + showRankIcon(parseInt(count)) + "&nbsp</span></li>";
					});
				});

				if(totalFwCount.get(_ARKID_) > 0 && totalRwCount.get(_ARKID_) > 0) {
					str += "<li style=\"border-top:1px solid #f3f3f3; padding:0;\"></li>";
				}

				// ARKRList
				$resultElement.find("ARKRList").each(function(idx) {
					$(this).find("ARK").each(function(i) {
						var nums = i + parseInt(totalFwCount.get(_ARKID_));
						var $ark = $(this);
						var hkeyword = $ark.attr("HKeyword");
						var keyword = $ark.attr("keyword");
						var count = $ark.attr("count");
						var type = $ark.attr("type");

						str += "<li id=\"bg"+ nums +"\" onclick=\"onClickKeyword(" + nums + ");\" onmouseover=\"onMouseOverKeyword(" + nums + ", '"+_ARKID_+"' );\"";
						str += " onmouseout=\"onMouseOutKeyword(" + nums + ", '"+_ARKID_+"' );\">" + showSource(parseInt(type)) + "&nbsp;&nbsp;" + hkeyword;
						str += " <span id=\"f" + nums +"\" style=display:none;>" + keyword + "</span>";
						str += " <span style=\"position:absolute; right:0;\">" + showRankIcon(parseInt(count)) + "&nbsp</span></li>";
					});
				});

				if ((totalFwCount.get(_ARKID_) + totalRwCount.get(_ARKID_)) == 0) {
					$("#" + contentListId.get(_ARKID_)).html("<li style=\"padding:6px 0 6px 10px;\">해당 단어로 시작하는 검색어가 없습니다.</li>");
				} else {
					$("#" + contentListId.get(_ARKID_)).html(str);
				}

				//setArkFooter();
				showArk(_ARKID_);
			}
		}
	});
}


var keyword = newMap();

/************************************************
 * 브라우저가 FireFox, Opera 일 경우 한글 입력
 * @name eventKeydown
 ************************************************/
function eventKeydown(_ARKID_) {
	// 방향키 이동시 메소드 실행을 중지시킨다.
	if(!isKeydown.get(_ARKID_)) {
		return;
	}

	if (keyword.get(_ARKID_) != $(queryId.get(_ARKID_)).val()) {
		keyword.put(_ARKID_, $(queryId.get(_ARKID_)).val());
		if (keyword.get(_ARKID_) != "" && isArk.get(_ARKID_)) {
			if(datatype.get(_ARKID_) == "json") {
				requestArkJson($(queryId.get(_ARKID_)).val(), _arkId);
			} else if(datatype.get(_ARKID_) == "xml") {
				requestArkXml($(queryId.get(_ARKID_)).val(), _arkId);
			}
		} else {
			hideArk(_ARKID_);
		}
	}
	setTimeout("eventKeydown()", 20);
}


/************************************************
 * 방향키 이벤트 처리
 * @name moveFocusEvent
 * @param event 페이지 이벤트
 ************************************************/
function moveFocusEvent(event, _ARKID_) {
	isKeydown.put(_ARKID_, false);

	if (event.keyCode == 38) {
		if (cursorPos.get(_ARKID_)==-1 || cursorPos.get(_ARKID_)==0) {
			cursorPos.put(_ARKID_, -1);
			hideArk(_ARKID_);
			$(queryId.get(_ARKID_)).val(tempQuery.get(_ARKID_));
			tempQuery.put(_ARKID_, "");
		} else {
			onMouseOutKeyword(cursorPos.get(_ARKID_), _ARKID_);
			cursorPos.put(_ARKID_, cursorPos.get(_ARKID_) - 1);
			onMouseOverKeyword(cursorPos.get(_ARKID_), _ARKID_);
			$(queryId.get(_ARKID_)).val($("#f" + cursorPos.get(_ARKID_)).text());
		}
	} else if (event.keyCode == 40) {
		if(cursorPos.get(_ARKID_) == -1) {
			tempQuery.put(_ARKID_, $(queryId.get(_ARKID_)).val());
		}
		if ((totalFwCount.get(_ARKID_) + totalRwCount.get(_ARKID_)) > (cursorPos.get(_ARKID_) + 1)) {
			onMouseOutKeyword(cursorPos.get(_ARKID_), _ARKID_);
			cursorPos.put(_ARKID_, cursorPos.get(_ARKID_) + 1);
			onMouseOverKeyword(cursorPos.get(_ARKID_), _ARKID_);
			$(queryId.get(_ARKID_)).val($("#f" + cursorPos.get(_ARKID_)).text());
		}
	}
}

/************************************************
 * MouseOver 일 경우 선택한 배경을 설정
 * @name onMouseOverKeyword
 * @param cursorNum 커서의 위치 인덱스 값
 ************************************************/
function onMouseOverKeyword(cursorNum, _ARKID_) {
	clearCursorPos(_ARKID_);
	cursorPos.put(_ARKID_, cursorNum);
	$("#bg" + cursorNum).css({"backgroundColor" : "#eeeeee"});
	$("#bg" + cursorNum).css({"cursor" : "pointer"});
}

/************************************************
 * MouseOut 일 경우 설정한 배경을 초기화
 * @name onMouseOutKeyword
 * @param cursorNum 커서의 위치 인덱스 값
 ************************************************/
function onMouseOutKeyword(curSorNum, _ARKID_) {
	cursorPos.put(_ARKID_, curSorNum);
	$("#bg" + cursorPos.get(_ARKID_)).css({"backgroundColor" : "#ffffff"});
}

/************************************************
 * 커서 위치가 변경될 때마다 선택되지 않은 부분 초기화
 * @name clearCursorPos
 ************************************************/
function clearCursorPos(_ARKID_) {
	for(var i=0; i<(totalFwCount.get(_ARKID_) + totalRwCount.get(_ARKID_)); i++){
		$("#bg" + i).css({"backgroundColor" : "#ffffff"});
	}
}

/************************************************
 * 마우스 클릭시 검색을 수행
 * @name onClickKeyword
 * @param cursorPos 커서의 위치
 ************************************************/
function onClickKeyword(_ARKID_) {
    $(queryId.get(_ARKID_)).val($("#f" + cursorPos.get(_ARKID_)).text());
    $(formName.get(_ARKID_)).submit();
}

/************************************************
 * 자동완성 목록을 화면에 보여줌
 * @name showArk
 ************************************************/
function showArk(_ARKID_) {
  if(  $(queryId.get(_ARKID_)).val() != ""){
	    $("#" + wrapId.get(_ARKID_)).show();
	    $("#" + arkUpId.get(_ARKID_)).show();
	    $("#" + arkDownId.get(_ARKID_)).hide();
	}
}

/************************************************
 * 자동완성 목록을 화면에서 감춤
 * @name hideArk
 ************************************************/
function hideArk(_ARKID_) {
	$("#" + wrapId.get(_ARKID_)).hide();
	$("#" + arkUpId.get(_ARKID_)).hide();
	$("#" + arkDownId.get(_ARKID_)).show();
}

/************************************************
 * 도움말 팝업
 * @name openHelp
 ************************************************/
function openHelp(_ARKID_) {
	window.open(arkPath.get(_ARKID_) + "/help/help_01.html", "도움말", "height=540,width=768,toolbar=no,menubar=no,scrollbars=yes,resizable=no,location=no,directories=no,status=no");
}

/************************************************
 * 단어 입력 후 정방향/역방향 이미지 버튼 클릭시 이벤트 처리
 * @name onConvert
 * @param convert
 ************************************************/
function onConvert(convert, _ARKID_) {
	var query = $(queryId.get(_ARKID_)).val();

	if (convert == "fw") {
		g_oConvert.put(_ARKID_, "fw");
	} else {
		g_oConvert.put(_ARKID_, "rw");
	}

	if (datatype.get(_ARKID_) == "json") {
		requestArkJson(query, _arkId);
	} else if (datatype.get(_ARKID_) == "xml") {
		requestArkXml(query, _arkId);
	}

	return;
}

/************************************************
 * 쿠키 설정값을 저장
 * @name setCookie
 * @param name 쿠키 항목명
 * @param value 쿠키 항목의 값
 * @param expire 쿠키 만료일자
 ************************************************/
function setCookie(name, value, expire) {
	var expire_date = new Date(expire);
	document.cookie = name + "=" + escape(value) + "; path=/; expires=" + expire_date.toGMTString();
}

/************************************************
 * 쿠키 설정값을 로드
 * @name getCookie
 * @param name 쿠키 항목명
 ************************************************/
function getCookie(name) {
	var dc = document.cookie;
	var prefix = name + "=";
	var begin = dc.indexOf("; " + prefix);
	if (begin == -1) {
		begin = dc.indexOf(prefix);
		if (begin != 0) {
			return null;
		}
	} else {
		begin += 2;
	}

	var end = document.cookie.indexOf(";", begin);

	if (end == -1) {
		end = dc.length;
	}

	return unescape(dc.substring(begin + prefix.length, end));
}

/************************************************
 * 폰트 컬러 설정
 * @name showSource
 * @param count 등급 레벨
 ************************************************/
function showSource(count) {
	var color;
	var ret;

	if (count >= 0 && count <= 4) {
		color = "#989898";
	} else {
		color = "#CC6633";
	}

	if (count == 0 || count == 5) {
		ret = "<font style='font-size:11px;font-family:돋움;color:"+color+"'>사전</font>";
	} else if(count == 1 || count == 6) {
		ret = "<font style='font-size:11px;font-family:돋움;color:"+color+"'>일반</font>"; //색인
	} else if(count == 2 || count == 7) {
		ret = "<font style='font-size:11px;font-family:돋움;color:"+color+"'>인기</font>";
	} else if(count == 3 || count == 8) {
		ret = "<font style='font-size:11px;font-family:돋움;color:"+color+"'>테마</font>";
	} else if(count == 4 || count == 9) {
		ret = "<font style='font-size:11px;font-family:돋움;color:"+color+"'>추천</font>";
	} else {
		ret = "";
	}

	return ret;
}

/************************************************
 * 추천어 리스트 우측에 Ranking 이미지 출력
 * @name showRankIcon
 * @param count 랭크 점수
 ************************************************/
function showRankIcon(count) {
	var str;

	if (count >= 0 && count <= 20) {
		str = "<font style=\"font-size:9px;color:#CC6633\">|</font><font style=\"font-size:9px;color:#C0C0C0\">||||</font>";
	} else if(count > 20 && count <= 40) {
		str = "<font style=\"font-size:9px;color:#CC6633\">||</font><font style=\"font-size:9px;color:#C0C0C0\">|||</font>";
	} else if(count > 40 && count <= 60) {
		str = "<font style=\"font-size:9px;color:#CC6633\">|||</font><font style=\"font-size:9px;color:#C0C0C0\">||</font>";
	} else if(count > 60 && count <= 80) {
		str = "<font style=\"font-size:9px;color:#CC6633\">||||</font><font style=\"font-size:9px;color:#C0C0C0\">|</font>";
	} else if(count > 80 && count <= 100) {
		str = "<font style=\"font-size:9px;color:#CC6633\">|||||</font>";
	} else {
		str = "<font style=\"font-size:9px;color:#CC6633\">|||||</font>";
	}

	return str;
}


var preview = "";
var gobj = "";

function attachEvent_(obj, evt, fuc, useCapture) {
	if (!useCapture) {
		useCapture = false;
	}

	if (obj.addEventListener) {
		// W3C DOM 지원 브라우저
		return obj.addEventListener(evt,fuc,useCapture);
	} else if (obj.attachEvent) {
		// MSDOM 지원 브라우저
		return obj.attachEvent("on"+evt, fuc);
	} else {
		// NN4 나 IE5mac 등 비 호환 브라우저
		MyAttachEvent(obj, evt, fuc);
		obj['on'+evt]=function() { MyFireEvent(obj,evt) };
	}
}

function detachEvent_(obj, evt, fuc, useCapture) {
  if(!useCapture) useCapture=false;
  if(obj.removeEventListener) {
    return obj.removeEventListener(evt,fuc,useCapture);
  } else if(obj.detachEvent) {
    return obj.detachEvent("on"+evt, fuc);
  } else {
    MyDetachEvent(obj, evt, fuc);
    obj['on'+evt]=function() { MyFireEvent(obj,evt) };
  }
}

function MyAttachEvent(obj, evt, fuc) {
  if(!obj.myEvents) obj.myEvents= {};
  if(!obj.myEvents[evt]) obj.myEvents[evt]=[];
  var evts = obj.myEvents[evt];
  evts[evts.length]=fuc;
}

function MyFireEvent(obj, evt) {
  if(!obj.myEvents || !obj.myEvents[evt]) return;
  var evts = obj.myEvents[evt];
  for (var i=0;i<len;i++) {
    len=evts.length;
    evts[i]();
  }
}

function previewShow(e, obj, pv) {
  preview=pv;
  gobj=obj;
  attachEvent_(obj, "mousemove", previewMove, false);
  attachEvent_(obj, "mouseout", previewHide, false);
}

function previewMove(e) {
  var hb = document.getElementById(preview);
  if(hb.parentElement) {
	  hb.parentElement.style.display="block";
  } else {
	  hb.parentNode.style.display="";
  }
  var evt = e ? e : window.event;
  var posx=0;
  var posy=0;

  if (evt.pageX || evt.pageY) { // pageX/Y 표준 검사
    posx = evt.pageX +8;
    posy = evt.pageY +16;
  } else if (evt.clientX || evt.clientY) { //clientX/Y 표준 검사 Opera
    posx = evt.clientX +10;
    posy = evt.clientY +20;
    if (window.event) { // IE 여부 검사
      posx += document.body.scrollLeft - 80;
      posy += document.body.scrollTop;
     }
  }

  hb.style.left = posx + "px";
  hb.style.top = posy + "px";
}

function previewHide() {
  var hb = document.getElementById(preview);
  if(hb.parentElement) hb.parentElement.style.display="none";
  else hb.parentNode.style.display="none";

  detachEvent_(gobj,"mousemove", previewMove, false);
}

function getBrowserType(){
    
    var _ua = navigator.userAgent;
    var rv = -1;
     
    //IE 11,10,9,8
    var trident = _ua.match(/Trident\/(\d.\d)/i);
    if( trident != null )
    {
        if( trident[1] == "7.0" ) return rv = "IE_" + 11;
        if( trident[1] == "6.0" ) return rv = "IE_" + 10;
        if( trident[1] == "5.0" ) return rv = "IE_" + 9;
        if( trident[1] == "4.0" ) return rv = "IE_" + 8;
    }
     
    //IE 7...
    if( navigator.appName == 'Microsoft Internet Explorer' ) return rv = "IE_" + 7;
     
    /*
    var re = new RegExp("MSIE ([0-9]{1,}[\.0-9]{0,})");
    if(re.exec(_ua) != null) rv = parseFloat(RegExp.$1);
    if( rv == 7 ) return rv = "IE" + 7; 
    */
     
    //other
    var agt = _ua.toLowerCase();
    if (agt.indexOf("chrome") != -1) return 'Chrome';
    if (agt.indexOf("opera") != -1) return 'Opera'; 
    if (agt.indexOf("staroffice") != -1) return 'Star Office'; 
    if (agt.indexOf("webtv") != -1) return 'WebTV'; 
    if (agt.indexOf("beonex") != -1) return 'Beonex'; 
    if (agt.indexOf("chimera") != -1) return 'Chimera'; 
    if (agt.indexOf("netpositive") != -1) return 'NetPositive'; 
    if (agt.indexOf("phoenix") != -1) return 'Phoenix'; 
    if (agt.indexOf("firefox") != -1) return 'Firefox'; 
    if (agt.indexOf("safari") != -1) return 'Safari'; 
    if (agt.indexOf("skipstone") != -1) return 'SkipStone'; 
    if (agt.indexOf("netscape") != -1) return 'Netscape'; 
    if (agt.indexOf("mozilla/5.0") != -1) return 'Mozilla';
}