<%@ include file="/WEB-INF/tiles/includes.jsp"
%><%@ page contentType="text/html; charset=utf-8"%>
<script>
var cnt = ${saveCount};
if(cnt>0){
	self.window.alert("저장되었습니다.");
	location.href = "${contextRoot}/editor/editScene?vdoId=${sceneInfo.vdoId}";
}else{
	self.window.alert("저장에 실패했습니다.");
	history.back(-1);
}
</script>