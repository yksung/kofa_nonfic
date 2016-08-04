<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="UTF-8"%><%

	if(totalCount > 0){
		totalPage = totalCount/PAGE_SIZE;
		if(totalCount%PAGE_SIZE > 0) 
			totalPage++;
	}

//	currentPage = Integer.parseInt(pageNum);//현재 페이지 구하는..
	currentPage = pageNum;
	startRow = (currentPage -1)* PAGE_SIZE;//첫페이지 구하는..
	//if( totalCount/PAGE_SIZE + 1 == currentPage ) {
	if( totalPage == currentPage ) {
		endRow = startRow + (totalCount % PAGE_SIZE);
	}else{
		endRow = currentPage * PAGE_SIZE;
	}
%>
<script>
function popupTarget(radioNum,target_docid, pageNum, task_code){
	var searchForm = document.docListForm;
	//alert("gggg");
	//alert("target_docid = > " + target_docid + " pageNum = > " + pageNum );
	searchForm.target_docid.value = target_docid;
	searchForm.pageNum.value = pageNum;
	searchForm.radioNum.value = radioNum;
	searchForm.task_code.value = task_code;
	searchForm.submit();
}
function goPage(pageNum){
	var searchForm = document.docListForm;
	searchForm.pageNum.value = pageNum;
	searchForm.radioNum.value = (pageNum-1)*10;
	searchForm.submit();
}
</script>
<div id="detailDoc">
    <form id="docListForm" method="post" action="referee.jsp" name="docListForm"
               onkeypress="return event.keyCode!=13">
        <input type="hidden" name="source_docid" value="<%=source_docid%>"/>
        <input type="hidden" name="target_docid" value=""/>
        <input type="hidden" name="pageNum" value="<%=pageNum%>"/>
        <input type="hidden" name="radioNum" value="<%=radioNum%>"/>
		<input type="hidden" name="firstPage" value="<%=firstPage%>"/>
        <input type="hidden" value="viewType"/>
        <input type="hidden" name="task_code" value="<%=task_code%>"/>
      
        <div class="popupdatahead">
            <ul>
                <li class="fr">
                    <ul>
                        <li class="docnum"><strong>총문서수:<%=totalCount%>개</strong>
                        </li>
                    </ul>
                </li>
            </ul>
        </div>

        <div class="popupdatagrid1">
            <table style="width:100%">
				<colgroup>
					<col width=3% />
					<col width=30% />
					<col width=* />
					<col width=10% />
					<col width=10% />
					<col width=10% />
				</colgroup>
                <thead>
                <tr>
                    <th class="thsty1">&nbsp;</th>
                    <th class="thsty1">과제 이름</th>
                    <th class="thsty1">문서 이름</th>
                    <th class="thsty1">학번</th>
                    <th class="thsty1">학생 이름</th>
                    <th class="thsty1">유사도(%)</th>
                </tr>
                </thead>
                <tbody>
                <%
				if( totalCount > 0 )
				{
					for(int i = startRow; i<endRow ; i++)
					{
                %>   
					<tr>	   
						<td class="tdsty11">  
							<input type="radio" name="targetDocNo" 
							<%=radioNum == i ? "checked" : ""%> onclick="popupTarget('<%=i%>','<%=qsearch.getField(i, "DOCID")%>','<%=pageNum%>', '<%=task_code%>')"/>   
						</td>
						<td class="tdsty11 td-left"><%=(qsearch.getField(i, "TASK_NAME")!=null)?	qsearch.getField(i, "TASK_NAME"):"-" %></td>
						<td class="tdsty11 td-left"><%=(qsearch.getField(i, "REPORT_NAME")!=null)?	qsearch.getField(i, "REPORT_NAME"):"-"%></td>
						<td class="tdsty11 td-left"><%=(qsearch.getField(i, "USER_ID")!=null)?	qsearch.getField(i, "USER_ID"):"-" %></td>
						<td class="tdsty11 td-left"><%=(qsearch.getField(i, "USER_NAME")!=null)?	qsearch.getField(i, "USER_NAME"):"-" %></td>
						<td class="tdsty11 td-left"><%=qsearch.getScore(i) %></td>
                    </tr>
				<%
					}
                }
                else
                {
                %>
                	<tr>	   
						<td class="tdsty11" colspan="5">데이터가 없습니다</td>
                    </tr>
                <%
                }
                %>
                  
        	
                </tbody>
            </table>
        </div>

        <div class="popupdatabtn2">※ 보기를 할 문서를 선택해 주세요. 1개만 선택 가능합니다.</div>

        <div class="pagination">
   <%

               //페이징 부분 -->
				int startPage = currentPage-((currentPage-1)%5); 
				int endPage = startPage + 4; 
			
				if(endPage >totalPage){ 
					endPage = totalPage; 
				} 
		
				if(startPage >5){ 
					out.println("<a class=\"direction\" href=\"javascript:goPage('"+(startPage-5)+"')\">[이전]</a>"); 
				} 
				for(int i = startPage ; i < endPage+1 ; i++){ 
					if(currentPage == i){ 
						out.println("<span style=\" position:relative; color:#323232; font:bold 12px/16px Tahoma, Sans-serif; vertical-align:top; display:inline-block; text-decoration:none; padding:1px 4px; margin:0; background-color:#fff; z-index:0;\">["+i+"]</span>"); 
					}else{ 
						out.println("<a class=\"direction\" href=\"javascript:goPage('"+i+"')\">["+i+"]</a>"); 
					} 
				} 
				if(startPage +4 < totalPage){ 
					out.println("<a class=\"direction\" href=\"javascript:goPage('"+(startPage+5)+"')\">[이후]</a>"); 
				} 
				
             %>
      
        </div>


    </form>


</div>



