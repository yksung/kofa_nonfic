<%@ page language="java" contentType="text/html; charset=utf-8" %><%@ page import="java.io.IOException"%><%@ page pageEncoding="UTF-8" %><%@ include file="./common/WNSearch.jsp"%><% request.setCharacterEncoding("utf-8");%>
<% 
	boolean isDebug = Boolean.valueOf(request.getParameter("isDebug"));
	
	WNSearch wnsearch = new WNSearch(isDebug, COLLECTIONS);
	
	ArrayList<String> docidList = new ArrayList<String>();
	
	// browsing query - to get list of whole docid
	wnsearch.search(null, BROWSING_QUERY);
	int allDocumentCount = wnsearch.getResultCount();
	for( int i=0; i<allDocumentCount; i++){
		docidList.add(wnsearch.getField(i, "DOCID"));
	}
	
	int ret = wnsearch.closeServer();
	if ( ret != 0 ) {
		printout(pageContext, BROWSING_QUERY, "Closing server error.");
		System.exit(1);
	}
	
	if(isDebug){
		printout(pageContext, BROWSING_QUERY, wnsearch.printDebug());
	}
	
	// query by docid
	for (int k=0; k<docidList.size(); k++)
	{
		WNSearch docidSearch = new WNSearch(isDebug, COLLECTIONS);
		docidSearch.search( docidList.get(k), QUERY_BY_DOCID); // source = docidList.get(k)
		
		printout(pageContext, QUERY_BY_DOCID, "--------------------------- " + docidList.get(k) + " ---------------------------");
		
		for(int num=0; num<docidSearch.getResultCount(); num++)
		{
			String docid = docidSearch.getField(num, "DOCID");
			
			printout(pageContext, QUERY_BY_DOCID, docid + ":" + docidSearch.getScore(num) );
		}
		
		docidSearch.closeServer();
	}
	
	if(isDebug){
		printout(pageContext, QUERY_BY_DOCID, wnsearch.printDebug());
	}

	
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>view all result - referee test page</title>
</head>
<body>

</body>
</html>
<%!
public void printout(PageContext pageContext, int resultType, String str){
	JspWriter out = null;
	try{
		out = pageContext.getOut();
		out.println("[" + getQueryName(resultType) + "] " + str + "<br>");
	}catch(IOException e){
		System.out.println(e.getMessage());
	}
}
%>