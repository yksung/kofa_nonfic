package kr.co.wisenut.search.service.impl;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Properties;

import javax.annotation.PostConstruct;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.env.Environment;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.wisenut.bic.analyzer.Request;
import com.wisenut.bic.analyzer.common.APIRequest;
import com.wisenut.bic.analyzer.model.Request.RequestRes;
import com.wisenut.bic.analyzer.model.Request.RequestVO;
import com.wisenut.bic.analyzer.types.APIRequestType;

import QueryAPI530.Search;
import kr.co.wisenut.search.model.JsonResult;
import kr.co.wisenut.search.model.Result;
import kr.co.wisenut.search.model.SearchForm;
import kr.co.wisenut.search.model.Variable;
import kr.co.wisenut.search.model.WNAnchor;
import kr.co.wisenut.search.service.*;
import kr.co.wisenut.util.StringUtil;

@Service
public class SearchServiceImpl implements SearchService {

	@Autowired
	private Environment env;
	
	private static final Logger LOGGER = LoggerFactory.getLogger(SearchServiceImpl.class);
	
	public static final String SPACE = " ";
    
	public static final String FIELD_DELIMITER = ",";
    public static final String AND_OPERATOR = " ";
    public static final String OR_OPERATOR = "|";
    public static final String GTE_OPERATOR = ":gte:";
    public static final String LTE_OPERATOR = ":lte:";
    public static final String CONTAINS_OPERATOR = ":contains:";
    public static final String PROP_DOCUMENT_FIELDS = "wisesf1.documentfields.";
    public static final String PROP_SEARCH_FIELDS = "wisesf1.searchfields.";
	
	public static Properties prop;
	
	private Search search;
	
	public String searchIP;
	public int searchPort;
	public int searchTimeout;

	public String collection;
	public String sort;
	public String ranking;
	public String highlight;
	public String queryAnalyzer;
 
	public String documentFields;
	public String searchFields;
	public String categoryFields;
	public String categoryDepthList;
	
	private int ret;
	private int totalResultCount;
	private int resultCount;
	
	private ArrayList<HashMap<String,String>> resultList; // 연관 기사 리스트
	private ArrayList<String> docidList; // 연관 기사 DOCID 리스트
	private HashMap<String,String> categoryGroupby;
	
	private String errorMsg;
	
	/*
	 * ark 설정
	 */
	private String MANAGER_IP;
	private String MANAGER_PORT;
	private String convert;
	private String datatype;
	private String charset;
	
	/*
	 * Wise BicAnalyzer 설정
	 */
	private String analyzerIp;
	private int analyzerPort;
	
	public boolean debug = true;
	
	@PostConstruct
	public void init(){
		resultList = new ArrayList<HashMap<String,String>>();
		docidList = new ArrayList<String>();
		categoryGroupby = new HashMap<String,String>();
		
		searchIP = env.getProperty("wisesf1.ip");
		searchPort = Integer.parseInt(env.getProperty("wisesf1.port"));
		searchTimeout = Integer.parseInt(env.getProperty("wisesf1.timeout"));
		
		collection = env.getProperty("wisesf1.collection");
		sort = env.getProperty("wisesf1.sort");
		ranking = env.getProperty("wisesf1.ranking");
		highlight = env.getProperty("wisesf1.highlight");
		queryAnalyzer = env.getProperty("wisesf1.queryanalyzer");
		
		documentFields = env.getProperty("wisesf1.documentfields");
		searchFields = env.getProperty("wisesf1.searchfields");
		categoryFields = env.getProperty("wisesf1.categoryfields");
		categoryDepthList = env.getProperty("wisesf1.categorydepthlist");
		
		LOGGER.debug("------------------------------------------------------------------");
		LOGGER.debug("searchIP : "+ searchIP);
		LOGGER.debug("searchPort : "+ searchPort);
		LOGGER.debug("searchTimeout : "+ searchTimeout);
		LOGGER.debug(" ");
		LOGGER.debug("collection : "+ collection);
		LOGGER.debug("sort : "+ sort);
		LOGGER.debug("ranking : "+ ranking);
		LOGGER.debug("highlight : "+ highlight);
		LOGGER.debug("queryAnalyzer : "+ queryAnalyzer);
		LOGGER.debug(" ");
		LOGGER.debug("documentFields : "+ documentFields);
		LOGGER.debug("searchFields : "+ searchFields);
		LOGGER.debug("categoryFields : "+ categoryFields);
		LOGGER.debug("categoryDepthList : "+ categoryDepthList);
		LOGGER.debug("------------------------------------------------------------------");
		
		MANAGER_IP = env.getProperty("wiseark.ip");
		MANAGER_PORT = env.getProperty("wiseark.port");
		datatype = env.getProperty("wiseark.datatype");
		charset = env.getProperty("wiseark.charset");
		convert = env.getProperty("wiseark.convert");
		
		LOGGER.debug("------------------------------------------------------------------");
		LOGGER.debug("managerIP : "+ MANAGER_IP);
		LOGGER.debug("managerPort : "+ MANAGER_PORT);
		LOGGER.debug("datatype : "+ datatype);
		LOGGER.debug("charset : "+ charset);
		LOGGER.debug("convert : "+ convert);
		LOGGER.debug("------------------------------------------------------------------");
		
		analyzerIp = env.getProperty("wiseba.ip");
		analyzerPort = (env.getProperty("wiseba.port")!=null)? Integer.parseInt(env.getProperty("wiseba.port")):0;
		
		LOGGER.debug("----------------------------------------------------------- -------");
		LOGGER.debug("analyzerIp : "+ analyzerIp);
		LOGGER.debug("analyzerPort : "+ analyzerPort);
		LOGGER.debug("------------------------------------------------------------------");
	}
	
	public void setSearchCondition(SearchForm form) throws Exception{ //
		ret = 0;
		
		ret = search.w3SetCodePage("UTF-8");
		ret = search.w3SetQueryLog(1);
		ret = search.w3SetTraceLog(10);
		if(form.getQuery() == null || "".equals(form.getQuery())){		
			ret = search.w3SetCommonQuery("", 0);
		}else{
			String query = form.getQuery();
			String orQuery = getTMResultAsQuery(form.getQuery());
			
			query += "|" + orQuery;
			ret = search.w3SetCommonQuery(query, 0);
		}
		
		LOGGER.debug(" - collection : " + collection);			
		ret = search.w3AddCollection(collection);
		
		String[] rankingArr = ranking.split(",");
		LOGGER.debug(" - ranking : "+rankingArr[0]+", "+rankingArr[1]+", " + rankingArr[2]);
		ret = search.w3SetRanking(collection, rankingArr[0], rankingArr[1], Integer.parseInt(rankingArr[2]));
		
		String[] hlArr = highlight.split(",");
		LOGGER.debug(" - highlight : 1,1");
		ret = search.w3SetHighlight(collection, Integer.parseInt(hlArr[0]), Integer.parseInt(hlArr[1]));
		
		LOGGER.debug(" - sort : " + form.getSort());
		if( null == form.getSort() || "".equals(form.getSort())){
			sort = "RANK/DESC,UID/ASC";
		}else{
			sort = form.getSort() + ",UID/ASC";
		}
		ret = search.w3SetSortField(collection, sort);
		
		String[] qaArr = queryAnalyzer.split(",");
		LOGGER.debug(" - query analyzer : 1,1,1,1");
		ret = search.w3SetQueryAnalyzer(collection, Integer.parseInt(qaArr[0]), Integer.parseInt(qaArr[1]), Integer.parseInt(qaArr[2]), Integer.parseInt(qaArr[3]));
		
		if(form.getQuery() == null || "".equals(form.getQuery())){				
			LOGGER.debug(" - date range : ");
			ret = search.w3SetDateRange(collection, "1970/01/01", "2030/12/31");
		}
		
		LOGGER.debug(" - prefixQuery : " + form.getPrefixQuery());
		if(form.getPrefixQuery()!=null && form.getPrefixQuery().length()>0){
			// PrefixQuery와 Common Query를 OR 검색
			ret = search.w3SetPrefixQuery(collection, form.getPrefixQuery(), 0);
		}
		
		if( null == form.getSearchField() || "".equals(form.getSearchField()) || "ALL".equals(form.getSearchField()) ){
			LOGGER.debug(" - search fields : " + searchFields);				
			ret = search.w3SetSearchField(collection, searchFields);
		}else{
			LOGGER.debug(" - search fields : " + form.getSearchField());		
			ret = search.w3SetSearchField(collection, form.getSearchField());
		}
		
		LOGGER.debug(" - document fields : " + documentFields);
		String[] arrDocumentFields = documentFields.split(",");
		ret = search.w3AddDocumentField(collection, "DOCID", 0); // DOCID는 항상 출력.
		for(String dfield : arrDocumentFields){
			if("DOCID".equals(dfield)) continue; // DOCID가 출력항목으로 들어온 경우엔 건너뜀.
			String df = dfield;
			if(dfield.contains("/")){
				int snippetlength = Integer.parseInt(dfield.split("/")[1]);
				df = dfield.split("/")[0];

				ret = search.w3AddDocumentField(collection, df, snippetlength);
			}else{
				ret = search.w3AddDocumentField(collection, df, 0);
			}
		}
		//ret = search.w3SetDocumentField(collectionId, documentFields);
		
		LOGGER.debug(String.format(" - page info : %d, %d", form.getPage(), form.getPageSize()));
		// getPageLinks 메소드를 사용해 paging을 표현하면 page 값은 viewListCount 수만큼 증가한 값으로 들어온다.
		// (예) viewListCount=10 이면, page는 0, 10, 20, .... 이런 식으로 입력됨.
		if(form.getPageSize()==0){			
			ret = search.w3SetPageInfo(collection, form.getPage(), 10);
		}else{
			ret = search.w3SetPageInfo(collection, form.getPage(), form.getPageSize());			
		}
		
		LOGGER.debug(" - filterQuery : " + form.getFilterQuery());
		if(form.getRuntimeMin()!=0 || form.getRuntimeMax()!=0){
			form.setFilterQuery("<VDO_RUNTIME:gte:"+form.getRuntimeMin()+"> <VDO_RUNTIME:lte:"+form.getRuntimeMax()+">");
		}
		if(form.getFilterQuery()!=null && form.getFilterQuery().length()>0){
			ret = search.w3SetFilterQuery(collection, form.getFilterQuery());
		}
		
		if(!form.isCategorySearch()){			
			LOGGER.debug(String.format(" - categoryGroupBy : %s", categoryDepthList));
			for(String category : categoryDepthList.split(",")){
				String categoryField = category.split("\\^")[0];
				String depthList = category.split("\\^")[1];
				ret = search.w3AddCategoryGroupBy(collection, categoryField, depthList);
			}
		}
		
		LOGGER.debug(" - categoryQuery : " + form.getCategoryQuery());
		if(form.getCategoryQuery()!=null && form.getCategoryQuery().length()>0){
			ret = search.w3AddCategoryQuery(collection, form.getCategoryField(), form.getCategoryQuery());
		}
			
		LOGGER.info(" - search ip : " + searchIP);
		LOGGER.info(" - search port : " + searchPort);
		LOGGER.info(" - search timeout : " + searchTimeout);
		ret = search.w3ConnectServer(searchIP, searchPort, searchTimeout);
		
		ret = search.w3ReceiveSearchQueryResult(3);
		if(ret != 0) {
            LOGGER.error(search.w3GetErrorInfo() + " (Error Code : " + search.w3GetError() + " )");
            errorMsg = search.w3GetErrorInfo() + " (Error Code : " + search.w3GetError() + " )";
            
            throw new Exception(errorMsg);
        }
	}
	
	@Override
	public void search(SearchForm form) throws Exception{
		// 초기화
		resultList = new ArrayList<HashMap<String,String>>();
		docidList = new ArrayList<String>();
		categoryGroupby = new HashMap<String,String>();
		
		search = new Search();
		
		// property에 지정한 모든 필드 검색
		setSearchCondition(form);
		
		totalResultCount = search.w3GetResultTotalCount(collection);
		resultCount = search.w3GetResultCount(collection);
		
		int count = search.w3GetResultCount(collection);
		String d = "";
		if(form.getDisplayFields()==null || "".equals(form.getDisplayFields())){
			d =  documentFields;
		}else{
			d = form.getDisplayFields();
		}
		String[] arrDocumentFields = d.split(",");
		for(int i=0; i<count; i++){
			HashMap<String,String> map = new HashMap<String, String>();
			
			// DOCID는 항상 세팅
			docidList.add(search.w3GetField(collection, "DOCID", i));
			
			map.put("DOCID", search.w3GetField(collection, "DOCID", i));
			for(String dfield : arrDocumentFields){
				if("DOCID".equals(dfield)) continue; // DOCID가 출력항목으로 들어온 경우엔 건너뜀.
				String df = dfield;
				if(dfield.contains("/")){
					df = dfield.split("/")[0];
				}

				map.put(df, search.w3GetField(collection, df, i).replaceAll("<!HS>", "<strong>").replaceAll("<!HE>", "</strong>"));
			}
			resultList.add(map);
		}
		
		if(!form.isCategorySearch()){
			for(String categoryField : categoryFields.split(",")){
				StringBuffer categoryResult = new StringBuffer();
				int categoryCount = search.w3GetCategoryCount(collection, categoryField, 1);
				for(int cidx=0; cidx<categoryCount; cidx++){				
					String name = search.w3GetCategoryName(collection, categoryField, 1, cidx);
					int documentCountInCategory = search.w3GetDocumentCountInCategory(collection, categoryField, 1, cidx);
					
					categoryResult.append(name+"^"+documentCountInCategory);
					if(cidx+1 != categoryCount){
						categoryResult.append("@");					
					}
				}
				if(categoryResult.length()>0){					
					categoryGroupby.put(categoryField, categoryResult.toString());
				}
			}
		}
		search.w3CloseServer();
	}
	
	@Override
	public HashMap<String,String> getCategoryGroupby() {
		return categoryGroupby;
	}
	
	public ArrayList<String> getDocidList(){
		return docidList;
	}
	
	@Override
	public ArrayList<HashMap<String,String>> getResultList(){
		return resultList;
	}
	
	@Override
	public int getTotalResultCount() {
		return totalResultCount;
	}
	
	public ArrayList<JsonResult> getJsonResultFromBicAnalyzer(String query){
		ArrayList<JsonResult> resultList = null;

		Request request = new Request(analyzerIp, analyzerPort);
		
		APIRequest apiReq = new APIRequest(APIRequestType.request);
		apiReq.setData(query);
		
		RequestRes result = request.getRequest(apiReq);
		
		if(result.getErrCode() == null ){
			resultList = new ArrayList<JsonResult>();
			for (RequestVO vo : result.getRequestVOList()) {
				ObjectMapper mapper = new ObjectMapper();
				
				JsonResult jsonResult;
				try {
					jsonResult = mapper.readValue(vo.getResult(), JsonResult.class);
					resultList.add(jsonResult);
				} catch(JsonMappingException e){
					LOGGER.error(e.getMessage());
				} catch (IOException e) {
					LOGGER.error(StringUtil.getStackTrace(e));
				}
			}
		}
		
		return resultList;
	}
	
	@Override
	public String getTMResultAsQuery(String query) throws JsonParseException, JsonMappingException, IOException {
		ArrayList<JsonResult> tmResults = getJsonResultFromBicAnalyzer(query);
		StringBuffer queryBuffer = new StringBuffer();
		
		/*
		 * {
		 * 	"stauts":{
		 * 		...
		 * 	},
		 * 	"result" : [
		 * 	{	...
		 * 			"variables" : [
		 * 				{
		 * 				"name" : "person",
		 * 				"value" : "박정희"
		 * 				}
		 * 			],
		 * 		...
		 * 	}
		 * 	]
		 * }
		 */
		for(JsonResult result : tmResults){
			if(result.getResult()!=null){
				for(Result rs : result.getResult()){					
					ArrayList<Variable> variables = rs.getVariables();
					
					for(Variable variable : variables){
						queryBuffer.append(variable.getValue());
						queryBuffer.append("|");
					}
				}
			}
		}
		
		return queryBuffer.toString().replaceAll("\\|$", "");
	}
		
	public int getResultCount() {
		return resultCount;
	}

	public void setResultCount(int resultCount) {
		this.resultCount = resultCount;
	}

	public int getRet(){
		return ret;
	}

	public String getErrorMsg() {
		return errorMsg;
	}

	public void setErrorMsg(String errorMsg) {
		this.errorMsg = errorMsg;
	}
	
	public String makeFilterQuery(String dateKind, String startDate, String endDate){
		//
		// filterQuery 형식
    	// <[필드]:gte:[범위]> <[범위]:lte:[범위]>
		//
    	// (ex) <CRT_DTIME:gte:20150101000000> <CRT_DTIME:lte:20151231235959>
		//
    	StringBuffer filterQuery = new StringBuffer();
    	String[] arrDateKind = (dateKind !=null && !"".equals(dateKind) && dateKind.contains(FIELD_DELIMITER))? dateKind.split(FIELD_DELIMITER):new String[]{dateKind};
    	
    	for(String dateField : arrDateKind){
   			filterQuery.append("(");
    		if( null != startDate && !"".equals(startDate) ){
    			if(startDate.length()==8){
    				startDate = startDate + "000000";
    			}
    			filterQuery.append("<").append(dateField).append(GTE_OPERATOR).append(startDate).append(">");
    			filterQuery.append(AND_OPERATOR);
    		}
    		if( null != endDate && !"".equals(endDate) ){
    			if(endDate.length()==8){
    				endDate = endDate + "235959";
    			}
    			filterQuery.append("<").append(dateField).append(LTE_OPERATOR).append(endDate).append(">");
    		}
    		filterQuery.append(")").append(OR_OPERATOR);
    	}
    	
    	// startDate, endDate 없이 날짜만 들어온 경우 filterQuery가 의미가 없으므로 삭제.
    	if(filterQuery.toString().startsWith("()")){
    		filterQuery.delete(0, filterQuery.length());
    	}
    	
    	return filterQuery.toString().replaceAll("\\w$", "").replaceAll("\\"+OR_OPERATOR+"$", "");
	}
	
	public String makePrefixQuery(HashMap<String,String> map){
		//
    	// prefixQuery 형식
    	// [필드]:값1|값2|값3|....|값n^[필드]:값1|값2
    	// 
    	// (ex) ARTCL_KIND_CD:0001,CRTOR_NM:성유경,RPTR_NM:성유경
    	//
    	StringBuffer prefixQuery = new StringBuffer();
    	
    	Iterator<String> iter = map.keySet().iterator();
    	while(iter.hasNext()){
    		String prefixField = iter.next();
    		String value = map.get(prefixField);
    		
    		if(prefixField.indexOf(FIELD_DELIMITER) != -1){
    			String[] fieldArr = prefixField.split(FIELD_DELIMITER);
    			
    			StringBuffer tempBuffer = new StringBuffer();
    			for(String field : fieldArr){
    				tempBuffer.append("<").append(field).append(CONTAINS_OPERATOR).append(value).append(">");
    				tempBuffer.append(OR_OPERATOR);
    			}
    			// 마지막에 붙은 | 기호를 없앰.
    			prefixQuery.append(tempBuffer.toString().replaceAll("\\|$", ""));
    		}else{
    			prefixQuery.append("<").append(prefixField).append(CONTAINS_OPERATOR).append(value).append(">");
    		}
    		
    		prefixQuery.append(AND_OPERATOR);
    	}
    	
    	
    	return prefixQuery.toString().replaceAll("\\w$", "");
	}
	
	@Override
	public String getPageLinks(int startCount, int totalCount, int viewListCount, int bundleCount) {
		StringBuffer sbRet = new StringBuffer();
		WNAnchor wnanchor = getPageAnchor(startCount, totalCount, viewListCount, bundleCount);
		
		if(wnanchor.getFirstPage() != -1) {
			sbRet.append("<a class=\"num\" href=\"#none\" onClick=\"javascript:doPaging('"+wnanchor.getBundleBefore()+"');\" title=\"이전페이지\">&lt;</a>");
		} else {
			sbRet.append("<a class=\"right\" href=\"#none\" title=\"이전페이지\">&lt;</a>");
		} 

		int pageCount = wnanchor.getPageCount();
		String pages[][] = wnanchor.getPages();

		for(int i=0; i<pageCount && i < pages.length; i++) {
			if(pages[i][1].equals("-1")) {
				sbRet.append("<a class=\"num click\" href=\"#none\">" + pages[i][0] + "</a>");
			} else {
				sbRet.append("<a class=\"num\" href=\"#none\" onClick=\"javascript:doPaging('"+pages[i][1]+"');\" title=\"페이징\"> "+pages[i][0]+" </a>");
			}
		}

		if(wnanchor.getBundleNext() != -1) {
			sbRet.append("<a class=\"num\" href=\"#none\" onClick=\"javascript:doPaging('"+wnanchor.getBundleNext()+"')\" title=\"다음페이지\">&gt;</a>");
		} else {
			sbRet.append("<a class=\"num\" href=\"#none\" title=\"다음페이지\">&gt;</a>");
		}

		return sbRet.toString();
	}
	
	public WNAnchor getPageAnchor(int startNum, int totalcount, int resultCnt, int anchorScale) {
		WNAnchor anchor = new WNAnchor();

		if(totalcount == 0) {   //등록된 정보가 없으면 페이지 Anchor를 생성 하지 않는다.
			return anchor;
		}

		int curBunbleNum = startNum / (resultCnt * anchorScale);
		int totalPageCnt = totalcount / resultCnt;
		if(totalcount % resultCnt > 0) {
			totalPageCnt++;
		}

		anchor.setTotalPgCount(totalPageCnt);      // 전체 페이지 세팅

		if ( startNum > 0){        // 이전 페이지
			int beforePg = startNum - resultCnt;
			anchor.setBefore(beforePg);
		}

		if( startNum+resultCnt < totalcount ){        // 다음페이지
			int nextPg = startNum + resultCnt;
			anchor.setNext(nextPg);
		}

		//번들 뒤로 이동
		int bunbleBeforePg = (curBunbleNum-1) * resultCnt * anchorScale;    //이전 번들로 이동하는 번호
		if(curBunbleNum > 0){
			anchor.setBundleBefore(bunbleBeforePg);
		}

		//번들 앞으로 이동
		int bundleNextPg = (1 + curBunbleNum) * anchorScale * resultCnt;
		if( totalPageCnt >= anchorScale && (curBunbleNum+1) * anchorScale <  totalPageCnt ){
			anchor.setBundleNext(bundleNextPg);
		}

		//맨처음..
		if(startNum != 0 && curBunbleNum != 0){
			anchor.setFirstPage(0);
		}
		//맨끝...
		int lastPage = (resultCnt * totalPageCnt) - resultCnt ;
		if( totalPageCnt >= anchorScale && (curBunbleNum+1) * anchorScale <  totalPageCnt ) {
			anchor.setLastPage(lastPage);
		}

		int pageCount = 1;
		String[][] pages = new String[anchorScale][2];
		for(int i = 0; i < anchorScale; i++) {
			int startCnt = ((curBunbleNum * anchorScale) + i) * resultCnt;
			int pageNum = (curBunbleNum * anchorScale) + i + 1;
			if(startCnt < totalcount) {
				if (startCnt != startNum) {
					pages[i][0] = Integer.toString(pageNum);
					pages[i][1] = Integer.toString(startCnt);
				} else {
					pages[i][0] = Integer.toString(pageNum);
					pages[i][1] = "-1";
					anchor.setCurPageNumber(pageNum);
				}
				anchor.setPageCount(pageCount);
				pageCount++;
			}
		}
		anchor.setPages(pages);
		return anchor;
	}
	
	@Override
	public String getArkHtmlResult(String arkQuery, String target){
		String url = "http://" + MANAGER_IP + ":" + MANAGER_PORT + "/manager/WNRun.do";
		
		StringBuffer receiveMsg = new StringBuffer();
		HttpURLConnection uc = null;
		int errorCode = 0;
		try {
			arkQuery = URLEncoder.encode(arkQuery, "UTF-8");
			String param = "query=" + arkQuery + "&convert=" + convert + "&target=" + target + "&charset=" + charset + "&datatype=" + datatype;
						
			URL servletUrl = new URL(url);
			uc = (HttpURLConnection) servletUrl.openConnection();
			uc.setRequestProperty("Content-type", "application/x-www-form-urlencoded");
			uc.setRequestMethod("POST");
			uc.setDoOutput(true);
			uc.setDoInput(true);
			uc.setUseCaches(false);
			uc.setDefaultUseCaches(false);
			DataOutputStream dos = new DataOutputStream (uc.getOutputStream());
			dos.write(param.getBytes());
			dos.flush();
			dos.close();
			
			// -- Network error check
			//System.out.println("[URLConnection Response Code] " + uc.getResponseCode());
			if (uc.getResponseCode() == HttpURLConnection.HTTP_OK) {
				String currLine = "";
                // UTF-8. ..
                BufferedReader in = new BufferedReader(new InputStreamReader(uc.getInputStream(), "UTF-8"));
                while ((currLine = in.readLine()) != null) {
                	receiveMsg.append(currLine).append("\r\n");
                }
                in.close();
            } else {
                  errorCode = uc.getResponseCode();
                  return receiveMsg.toString();
             }
       } catch(Exception ex) {
    	   LOGGER.error("[SearchService][getArkHtmlResult] errorCode : " + errorCode);
    	   LOGGER.error(StringUtil.getStackTrace(ex));
       } finally {
            uc.disconnect();
       }

       //System.out.println(receiveMsg.toString());
       return receiveMsg.toString();
	}
}
