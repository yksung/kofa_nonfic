<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<script>
var cnt = ${updateCount};
if(cnt>0){
	self.window.alert("변경사항이 저장되었습니다.");
	location.href = "${contextRoot}/manager/editEvent";
}else{
	self.window.alert("저장에 실패했습니다.");
	history.back(-1);
}
</script>