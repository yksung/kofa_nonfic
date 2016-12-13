<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<script>
var cnt = ${addCount};
if(cnt>0){
	self.window.alert("추가되었습니다.");
	location.href = "${contextRoot}/manager/editEvent";
}else{
	self.window.alert("추가에 실패했습니다.");
	history.back(-1);
}
</script>