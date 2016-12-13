<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<script>
var cnt = ${deleteCount};
if(cnt>0){
	self.window.alert("삭제되었습니다.");
	location.href = "${contextRoot}/manager/editEvent";
}else{
	self.window.alert("삭제에 실패했습니다.");
	history.back(-1);
}
</script>