<%@ page language="java" contentType="text/html; charset=utf-8" 
	%><%@ page import="java.io.IOException"
	%><%@ page pageEncoding="UTF-8" 
	%><%@ include file="./common/WNUtils.jsp"
	%><%@ include file="./common/WNSearch.jsp"
	%><%@ include file="./common/highlight.jsp"
	%><% request.setCharacterEncoding("utf-8");
	%><% 
	/*
	 * subject: 표절 검사 결과 페이지
	 * @original author: 성유경
	 */
 
	//페이징 처리
	int totalCount = 0;//총 글갯수
	int totalPage = 0;//총페이지수
	int currentPage = 0;//현재 페이지
	int startRow = 0;
	int endRow = 0;
	int pageNum = Integer.parseInt(getCheckReqXSS(request,"pageNum","1"));
	int radioNum = Integer.parseInt(getCheckReqXSS(request,"radioNum","0"));
	String firstPage = getCheckReqXSS(request,"firstPage","N");
	
	/* 
	 *	표절 검사 결과를 보려는 DOCID (source_docid)
	 */
	String source_docid = getCheckReqXSS(request,"source_docid","");
	if( "".equals(source_docid) )
	{
		printout(pageContext, -1, "source_docid is an empty string.");
		return;
	}
	
	/* 
	 *	표절 검사 범위(과제) 지정 (task_code)
	 *	task_code를 지정하지 않으면 QueryByDocid에서 다른 과제까지 비교 검사한 결과까지 가져오게 된다.
	 */
	String task_code = getCheckReqXSS(request, "task_code", "");
	if( "".equals(task_code) )
	{
		printout(pageContext, -1, "task_code is an empty string.");
		return;
	}

	// 페이징할 때마다 첫번째 줄 DOCID를 가져옴
	String target_docid = getCheckReqXSS(request,"target_docid","");
	if( target_docid.equals("")){
		target_docid = getFirstTargetDocid(radioNum, source_docid, task_code);
	}
	
	long startTime = System.currentTimeMillis();  //처리시간 종료

	//디버깅 보기 설정
	boolean isDebug = false;
	response.setHeader("Access-Control-Allow-Origin", "*"); //html 의 보안문제 해결

	String QUOT = "\"";

	//////////////////////////////////////////////////////////////////////////////////////////////////////// 1:1 하이라이팅 추출
	String sourcehighlight = "";
	String targethlight = "";
	
	WNSearch dtdSearch = null;
	
	if( target_docid != null && !"".equals(target_docid) && task_code != null && !"".equals(task_code) )
	{
		dtdSearch = new WNSearch(isDebug, COLLECTIONS);
		
		for(int i=0; i<COLLECTIONS.length; i++)
		{
			String prefixQuery = "<TASK_CODE:contains:"+task_code+">";
			dtdSearch.setCollectionInfoValue(COLLECTIONS[i], PREFIX_QUERY, prefixQuery);
		}
		
		if( dtdSearch.search(source_docid, target_docid, HIGHLIGHT_DOCID_TO_DOCID) >= 0 )
		{
			sourcehighlight = dtdSearch.getSourceHighlight();
			if( sourcehighlight != null && !sourcehighlight.trim().equals("") )
			{
				sourcehighlight = replaceHighLight( sourcehighlight.replaceAll("<", "&lt;").replaceAll(">", "&gt;"), "s_", "t_" );
			}
			
			targethlight = dtdSearch.getTargetHighlight();
			if( targethlight != null && !targethlight.trim().equals("") )
			{
				targethlight = replaceHighLight( targethlight.replaceAll("<", "&lt;").replaceAll(">", "&gt;"), "t_", "s_" );
			}
		}
		else
		{
			out.println("An exception has occured during \"dtdSearch.search.\"");
		}
		
		// 디버그 메시지 출력
		if(isDebug)
		{
			printout(pageContext, HIGHLIGHT_DOCID_TO_DOCID, dtdSearch.printDebug());
		}
	}
	
	////////////////////////////////////////////////////////////////////////////////////////////////////////////////////// 1:N 비교
	float pgm_gen_psnt = 0.0f;
	boolean isComposite = false;
	
	WNSearch qsearch = new WNSearch(isDebug, COLLECTIONS);
	
	for(int i=0; i<COLLECTIONS.length; i++)
	{
		String prefixQuery = "<TASK_CODE:contains:"+task_code+">";
		qsearch.setCollectionInfoValue(COLLECTIONS[i], PREFIX_QUERY, prefixQuery);
	}
	
	if ( qsearch.search(source_docid, QUERY_BY_DOCID) >= 0 ){
		pgm_gen_psnt = qsearch.getOneToNScore();
		isComposite = qsearch.isComposite(COMPOSITE_THRESHOLD);
		totalCount = qsearch.getResultCount();
		
		System.out.println("[QueryByDocid] totalCount is " + totalCount);
	}
	else
	{
		out.println("An exception has occured during \"qsearch.search.\"");
	}

	// 디버그 메시지 출력
	if(isDebug)
	{
		printout(pageContext, QUERY_BY_DOCID, qsearch.printDebug());
	}
	
	firstPage = "Y";//라디오 버튼 첫번째로 유지시키기
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>모사 보고서 샘플 페이지 - WISE Referee v2.1</title>
</head>
<link href="css/reset.css" rel="stylesheet" type="text/css" />
<link href="css/search.css" rel="stylesheet" type="text/css" />
<style type="text/css">
a.no-uline { text-decoration:none }
.originp {direction:rtl; text-align:right}
#wn_high{font-weight: bold; background-color: #FF6666;}
#wn_low{font-weight: bold; background-color: #ffcc00;}
#wn_cit{font-weight: bold; background-color: #66CC66;}
#wn_highlight{font-weight: bold; background-color: #FFFF33;}
</style>
<script>
/*
window.onload=function() {
	alert( "source_docid=<%=source_docid%>, target_docid=<%=target_docid%>, radioNum=<%=radioNum%>");
}
*/
</script>
<body>

<%
	/*
	 * 상세보기에서 전체보기 팝업창
	 * @company WISENut
	 * @date 2012. 7.18
	*/
%>

<div class="popup">
	
	<div class="popuptit">
		<h1 class="fl"><img src="images/tit_dview1.gif" alt="상세보기_전체보기"/></h1>
	</div>
	<div class="dviewhead"> <!--  <div class="dviewhead" style="width:962px;">-->
		<div class="dviewheadin">
			<div class="reportname" style="width:45%;">
				<ul>
					<li>
						<div id="dviewTitle" class="root ellipsis1">                      
						<%=( dtdSearch != null && dtdSearch.getSourceField("TASK_NAME") !=null )? dtdSearch.getSourceField("TASK_NAME"):"" %>
						</div>
					</li>
					<li>
						<div id="dviewDocName" class="name ellipsis1">
						   <%=(  dtdSearch != null &&  dtdSearch.getSourceField("REPORT_NAME") !=null )? dtdSearch.getSourceField("REPORT_NAME"):"" %>
						  <br><%=( dtdSearch != null && dtdSearch.getSourceField("USER_ID") !=null )? dtdSearch.getSourceField("USER_ID")+",":""%> <%=(  dtdSearch != null && dtdSearch.getSourceField("USER_NAME") !=null )? dtdSearch.getSourceField("USER_NAME"):""%>
						</div>
					</li>
				</ul>
			</div>

			<div class="fr" style="width:55%; ">
				<ul>
					<li class="chart">
						<ul>
							<li class="wbar">
								<ul>
									<li class="movebar">
										<div class="progress-container">
											<div class="red" style="width:"></div>
										</div>
									</li>
									<li class="per">종합표절의심도
										<span class="fbold"><%=numberFormat(pgm_gen_psnt, "##.##")%>%</span>
									</li>
								</ul>
							</li>
							<li class="wbar">
								<ul>
									<li class="movebar">
										<div class="progress-container">
											<div class="blue" style="width: "></div>
										</div>
									</li>
									<li class="per"><!-- 최고 <span class="fbold"></span--></li>  
								</ul>
							</li>
							<li class="wbar">
								<ul>
									<li class="movebar">
										<div class="progress-container">
											<div class="green" style="width:"></div>
										</div>
									</li>
									<li class="per"><!--  최저 <span class="fbold"></span--></li>
								</ul>
							</li>
						</ul>
					</li>
					<li class="thisdoc">
						<ul>
							<li class="tit">현재비교문서</li>
							<li class="per">
								<%= dtdSearch != null ? numberFormat(dtdSearch.getOneToOneScore(), "##.##"):"-"%>%
							</li>
						</ul>
					</li>
					<li class="mix">
						<ul>
							<li class="tit">짜깁기</li>
							<li class="icostate">   
							<%
							if (!isComposite)
							{
							%>   
								<img src="images/ico_mix2.gif"/>          
							<%
							}
							else if (isComposite)
							{
							%> 
								<img src="images/ico_mix.gif"/>  
							<%
							}
							else
							{
							%> 
								<img src="images/ico_mix2.gif"/>  
							<%
							}
							%>                           
							</li>
						</ul>
					</li>
				  
				</ul>
			</div>
		</div>
	</div>
	<div class="popuptab">
		<ul>
			<li><a id="allBtn"> <img src="images/tab_popup12.gif"
									 alt=""/></a></li>
			<li class="advice">* <strong>전체검사</strong> : 선택 문서의 본문과 1:1로 비교해 보실 수 있습니다.</li>
		</ul>
	</div>
	<div class="popupwrap">
		
			<%@ include file="refereeList.jsp" %>

		<div class="dview">
			<div class="cont fl">
				<ul>
					<li class="light">
						<img src="images/lightstep1.gif" alt="완전일치 "/>완전일치(100% 구문일치)
						<img src="images/lightstep2.gif" alt="부분일치 "/>부분일치(50~99% 구문일치)
					</li>
					<li class="subject">
						<ul>
							<li class="doctit">
								<div id="sourceDocName" class="ellipsis2">
								<%=( dtdSearch != null && dtdSearch.getSourceField("REPORT_NAME") !=null )? dtdSearch.getSourceField("REPORT_NAME"):"" %> 
								<%=( dtdSearch != null && dtdSearch.getSourceField("USER_ID") !=null )? dtdSearch.getSourceField("USER_ID")+",":""%> 
								<%=( dtdSearch != null && dtdSearch.getSourceField("USER_NAME") !=null )? dtdSearch.getSourceField("USER_NAME"):""%>
								</div>
							</li>
						</ul>
					</li>
					<li class="originp">
						<%=(sourcehighlight!=null)? sourcehighlight:"" %>
					</li>
				</ul>
			</div>
			<div class="cont fr">
				<ul>
					<li class="prvnext">
				 
					</li>
					<li class="subject">
						<ul>
							<li class="doctit">
								<div id="targetDocName" class="ellipsis2">
								<%=( dtdSearch != null && dtdSearch.getTargetFieldInHighlight("REPORT_NAME") !=null )? dtdSearch.getTargetFieldInHighlight("REPORT_NAME"):"-"%> 
								<%=( dtdSearch != null && dtdSearch.getTargetFieldInHighlight("USER_ID") !=null )? dtdSearch.getTargetFieldInHighlight("USER_ID")+",":""%> 
								<%=( dtdSearch != null && dtdSearch.getTargetFieldInHighlight("USER_NAME") !=null )? dtdSearch.getTargetFieldInHighlight("USER_NAME"):""%>
								</div>
							</li>
						
						</ul>
					</li>
					<li class="originp">
						<%=(targethlight!=null)? targethlight:"" %>
					</li>
					<li class="prvnext">
					  
					</li>
				</ul>
			</div>
		</div>
		<%--확인 버튼 닫기 기능--%>
		<div class="popupbtn" ></div> 
	</div>
</div>
</body>
</html>
<%
	long endTime = System.currentTimeMillis();  //처리시간 종료
	if(isDebug)
	{
		long elapsedTime = endTime - startTime;
		out.println( "elapsedTime : " + elapsedTime );
	}
	
	if(dtdSearch != null ){
		dtdSearch.closeServer();
	}
	
	if( qsearch != null ){
		qsearch.closeServer();
	}
%>
<%!
public void printout(PageContext pageContext, int resultType, String str){
	JspWriter out = null;
	try{
		out = pageContext.getOut();
		out.println("[" + getQueryName(resultType) + "]\n" + str);
	}catch(IOException e){
		System.out.println("[referee.jsp] " + e.getMessage());
	}
}

public String getFirstTargetDocid(int radioNum, String source_docid, String task_code)
{
	System.out.println("---------------------------------------");
	System.out.println("radioNum : " + radioNum + " / source_docid : " + source_docid);
	String target_docid = "";
	try
	{
		WNSearch wnsearch = new WNSearch(true, COLLECTIONS);
		
		for(int i=0; i<COLLECTIONS.length; i++)
		{
			String prefixQuery = "<TASK_CODE:contains:" + task_code + ">";
			wnsearch.setCollectionInfoValue(COLLECTIONS[i], PREFIX_QUERY, prefixQuery);
		}
		
		wnsearch.search(source_docid, QUERY_BY_DOCID);
		
		// psc에 요청
		int resultCount = wnsearch.getResultCount();
		if( resultCount > 0 ){
			target_docid = wnsearch.getField(radioNum, "DOCID")!=null ? wnsearch.getField(radioNum, "DOCID"):"";
		}
		
		System.out.println("target_docid : " + target_docid);
		System.out.println("resultCount : " + resultCount);
		System.out.println("---------------------------------------");
		
		wnsearch.closeServer();
	}
	catch(Exception e)
	{
		System.out.println("[getFirstTargetDocid]" + e.getMessage());
	}
 	
	return target_docid;
}
%>