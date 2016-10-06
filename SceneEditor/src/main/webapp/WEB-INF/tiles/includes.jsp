<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"
%><%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" 
%><%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" 
%><%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"
%><%@ page import="kr.co.wisenut.login.model.User"%><%
User loginInfo = (User)request.getSession().getAttribute("loginInfo");
String userName = "";
if(loginInfo != null) {
	userName = loginInfo.getUserName();
}
%>