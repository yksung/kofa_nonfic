<%@ page contentType="text/html; charset=utf-8"%><%@ page import="java.util.*,RefAPI210.*,java.lang.*,javax.servlet.jsp.*"%><%@include file="./WNCollection.jsp" %><%!
	/**
	 * File : WNSearch.jsp
	 * Subject : Referee의 API 사용 방법을 정의한 메소드 클래스
	 * 
	 * @author yksung
	 * @update 2014.05.07
	 * 
	 */
	public class WNSearch {
		private RefAPI210.Search search;
		private StringBuffer errorMessage;
		private StringBuffer debugMessage;
		private StringBuffer warningMessage;
		private boolean isDebug;
		private String[] collections;
		private WNCollection wncol;
		
		public WNSearch(boolean debug, String[] collections){
			this.isDebug = debug;
			
			this.search = new RefAPI210.Search();
			this.errorMessage = new StringBuffer();
			this.debugMessage = new StringBuffer();
			this.warningMessage = new StringBuffer();
			
			this.collections = collections;
			this.wncol = new WNCollection();
		}
		
		// Browsing query
		public int search(int searchType){
			return search(null, null, searchType);
		}
		
		// 단독 DOCID, UID, TEXT로 표절검색 요청할 때
		public int search(String sourceDoc, int searchType){
			return search(sourceDoc, null, searchType);
		}
		
		public int search(String source, String targets, int searchType){
			int ret = 0;
			
			if(isDebug){
				debugMessage.append("\n[wSubmit] [IP] " + SEARCH_IP + " [PORT] " + SEARCH_PORT + " [TIMEOUT] " + TIME_OUT + " [Source] " + source + " [Targets] " + targets );
			}
			
			if( collections != null){
				for(int i=0; i<collections.length; i++)
				{				
					ret = setCollectionBasicInfo(collections[i]);
					ret = setSessionInfo(collections[i]);
					ret = setSortField(collections[i]);
					ret = setResultField(collections[i]);
					ret = setScoreRange(collections[i]);
					ret = setDateRange(collections[i]);
					ret = setFilterQuery(collections[i]);
					ret = setPrefixQuery(collections[i]);
				}
			}
			
			if( searchType == HIGHLIGHT_TEXT_TO_TEXT){
				ret = search.wHighlightTextToText(source, targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightTextToText] ").append(search.wGetErrorMessage());
				}
			}else if(searchType == HIGHLIGHT_TEXT_TO_UID){
				ret = search.wHighlightTextToUid(source, Integer.parseInt(targets));
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightTextToUid] ").append(search.wGetErrorMessage());
				}
			}else if(searchType == HIGHLIGHT_TEXT_TO_DOCID){
				ret = search.wHighlightTextToDocid(source, targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightTextToDocid] ").append(search.wGetErrorMessage());
				}
			}else if (searchType == HIGHLIGHT_UID_TO_TEXT){
				ret = search.wHighlightUidToText(Integer.parseInt(source), targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightUidToText] ").append(search.wGetErrorMessage());
				}
			}else if(searchType == HIGHLIGHT_UID_TO_UID){
				ret = search.wHighlightUidToUid(Integer.parseInt(source),Integer.parseInt(targets));
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightUidToUid] ").append(search.wGetErrorMessage());
				}
			}else if(searchType == HIGHLIGHT_UID_TO_DOCID){
				ret = search.wHighlightUidToDocid(Integer.parseInt(source), targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightUidToDocid] ").append(search.wGetErrorMessage());
				}
			}else if (searchType == HIGHLIGHT_DOCID_TO_TEXT){
				ret = search.wHighlightDocidToText(source, targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightDocidToText] ").append(search.wGetErrorMessage());
				}
			}else if(searchType == HIGHLIGHT_DOCID_TO_UID){
				ret = search.wHighlightDocidToUid(source, Integer.parseInt(targets));
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightDocidToUid] ").append(search.wGetErrorMessage());
				}
			}else if(searchType == HIGHLIGHT_DOCID_TO_DOCID){
				ret = search.wHighlightDocidToDocid(source, targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightDocidToDocid] ").append(search.wGetErrorMessage());
				}
			}else if (searchType == QUERY_BY_TEXT){
				ret = search.wQueryByText(source);
				if( ret < 0 )
				{
					errorMessage.append("\n[wQueryByText] ").append(search.wGetErrorMessage());
				}
			}else if (searchType == QUERY_BY_UID){
				ret = search.wQueryByUid(Integer.parseInt(source));
				if( ret < 0 )
				{
					errorMessage.append("\n[wQueryByUid] ").append(search.wGetErrorMessage());
				}
			}else if (searchType == QUERY_BY_DOCID){
				ret = search.wQueryByDocid(source);
				if( ret < 0 )
				{
					errorMessage.append("\n[wQueryByDocid] ").append(search.wGetErrorMessage());
				}
			}else if( searchType == SUMMARIZE_TEXT_TO_UIDLIST){
				ret = search.wSummarizeTextToUidList(source, targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wSummarizeTextToUidList] ").append(search.wGetErrorMessage());
				}
			}else if( searchType == SUMMARIZE_TEXT_TO_DOCIDLIST){
				ret = search.wSummarizeTextToDocidList(source, targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wSummarizeTextToDocidList] ").append(search.wGetErrorMessage());
				}
			}else if( searchType == SUMMARIZE_DOCID_TO_UIDLIST){
				ret = search.wSummarizeDocidToUidList(source, targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wSummarizeDocidToUidList] ").append(search.wGetErrorMessage());
				}
			}else if( searchType == SUMMARIZE_DOCID_TO_DOCIDLIST){
				ret = search.wSummarizeDocidToDocidList(source, targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wSummarizeDocidToDocidList] ").append(search.wGetErrorMessage());
				}
			}else if( searchType == SUMMARIZE_UID_TO_UIDLIST){
				ret = search.wSummarizeUidToUidList(Integer.parseInt(source), targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wSummarizeUidToUidList] ").append(search.wGetErrorMessage());
				}
			}else if( searchType == SUMMARIZE_UID_TO_DOCIDLIST){
				ret = search.wSummarizeUidToDocidList(Integer.parseInt(source), targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wSummarizeUidToDocidList] ").append(search.wGetErrorMessage());
				}
			}else if( searchType == HIGHLIGHT_BLOCKS_BY_TEXT){
				ret = search.wHighlightBlocksByText(source, targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightBlocksByText] ").append(search.wGetErrorMessage());
				}
			}else if( searchType == HIGHLIGHT_BLOCKS_BY_DOCID){
				ret = search.wHighlightBlocksByDocid(source, targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightBlocksByDocid] ").append(search.wGetErrorMessage());
				}
			}else if( searchType == HIGHLIGHT_BLOCKS_BY_UID){
				ret = search.wHighlightBlocksByUid(Integer.parseInt(source), targets);
				if( ret < 0 )
				{
					errorMessage.append("\n[wHighlightBlocksByUid] ").append(search.wGetErrorMessage());
				}
			}else if (searchType == BROWSING_QUERY){
				ret = search.wBrowsingQuery();
				if( ret < 0 )
				{
					errorMessage.append("\n[wBrowsingQuery] ").append(search.wGetErrorMessage());
				}
			}
			
			ret = search.wSubmit(SEARCH_IP, SEARCH_PORT, TIME_OUT);
			if( ret < 0 )
			{
				errorMessage.append("\n[wSubmit] ").append(search.wGetErrorMessage());
			}
			
			return ret;
		}

		public int setCollectionBasicInfo(String collection)
		{
			int ret = 0;

			// - charset 지정
			ret = search.wSetCharset( CHARSET );
			if( ret < 0 )
			{
				errorMessage.append("\n[wSetCharset] ").append(search.wGetErrorMessage());
			}

			// - 컬렉션 지정
			ret = search.wSetTargetCollection( collection );
			if( ret < 0 )
			{
				errorMessage.append("\n[wSetTargetCollection] ").append(search.wGetErrorMessage());
			}
			
			if(isDebug){
				debugMessage.append("\n[CHARSET]" + CHARSET );
				debugMessage.append("\n[wSetTargetCollection] " + collection);
			}
			
			
			return ret;
		}
		
		public boolean setCollectionInfoValue(String collName, int target, String value)
		{
			int idx = getCollIdx(collName);
			if (idx == -1){
				warningMessage.append("[setCollectionInfoValue] ["+collName+"] Collection name does not exist.");
				return false;
			}
			wncol.COLLECTION_INFO[idx][target] = value;
			return true;
		}
		
		public int setSessionInfo( String collection )
		{
			int ret = 0;			
			int idx = getCollIdx(collection);
			
			String sessionInfo = wncol.COLLECTION_INFO[idx][SESSION_INFO];
			
			// Store session info
			if( sessionInfo != null && sessionInfo.contains(","))
			{
				String[] sessionInfoArr = sessionInfo.split(",");
				ret = search.wSetSessionInfo(sessionInfoArr[0], sessionInfoArr[1], sessionInfoArr[2]);
				if( ret < 0 )
				{
					errorMessage.append("\n[wSetSessionInfo] ").append(search.wGetErrorMessage());
				}
			}
			
			if(isDebug){
				debugMessage.append("\n[wSetSessionInfo] " + sessionInfo );
			}
			
			return ret;
		}
		
		public int setSortField( String collection )
		{
			int ret = 0;
			int idx = getCollIdx(collection);
			
			// 정렬 필드 지정
			String sortField = wncol.COLLECTION_INFO[idx][SORT_FIELD];
			if( !sortField.equals(""))
			{
				ret = search.wSetSortField( sortField );
				if( ret < 0 )
				{
					errorMessage.append("\n[wSetSortField] ").append(search.wGetErrorMessage());
				}
			}
			
			if(isDebug){
				debugMessage.append("\n[wSetSortField] " + sortField );
			}
			
			return ret;
		}
		
		public int setResultField( String collection )
		{
			int ret = 0;
			int idx = getCollIdx(collection);
			
			// 결과 필드 설정
			String resultField = wncol.COLLECTION_INFO[idx][RESULT_FIELD];
			if( !resultField.equals("") )
			{
				ret = search.wSetResultField( resultField );
				if( ret < 0 )
				{
					errorMessage.append("\n[wSetResultField] ").append(search.wGetErrorMessage());
				}
			}
			
			if(isDebug){
				debugMessage.append("\n[wSetResultField] " + resultField );
			}
			
			return ret;
		}
		
		public int setScoreRange( String collection )
		{
			int ret = 0;
			int idx = getCollIdx(collection);
			
			// 표절 점수 범위 설정
			String scoreRange = wncol.COLLECTION_INFO[idx][SCORE_RANGE];
			if( !scoreRange.equals("") && scoreRange.contains(",") )
			{
				String[] scores = scoreRange.split(",");
				ret = search.wSetScoreRange(Float.parseFloat(scores[0]), Float.parseFloat(scores[1]));
				if( ret < 0 )
				{
					errorMessage.append("\n[wSetScoreRange] ").append(search.wGetErrorMessage());
				}
			}
			
			if(isDebug){
				debugMessage.append("\n[wSetScoreRange] " + scoreRange );
			}
			
			return ret;
		}
		
		public int setDateRange( String collection )
		{
			int ret = 0;
			int idx = getCollIdx(collection);
			
			// 표절 점수 범위 설정
			String dateRange = wncol.COLLECTION_INFO[idx][DATE_RANGE];
			if( !dateRange.equals("") && dateRange.contains(",") )
			{
				String[] scores = dateRange.split(",");
				ret = search.wSetDateRange(scores[0], scores[1]);
				if( ret < 0 )
				{
					errorMessage.append("\n[wSetDateRange] ").append(search.wGetErrorMessage());
				}
			}
			
			if(isDebug){
				debugMessage.append("\n[wSetDateRange] " + dateRange );
			}
			
			return ret;
		}
		
		public int setFilterQuery( String collection )
		{
			int ret = 0;
			int idx = getCollIdx(collection);
			
			// 표절 점수 범위 설정
			String filterQuery = wncol.COLLECTION_INFO[idx][FILTER_QUERY];
			if( !filterQuery.equals("") )
			{
				ret = search.wSetFilterQuery(filterQuery);
				if( ret < 0 )
				{
					errorMessage.append("\n[wSetFilterQuery] ").append(search.wGetErrorMessage());
				}
			}
			
			if(isDebug){
				debugMessage.append("\n[wSetFilterQuery] " + filterQuery );
			}
			
			return ret;
		}
		
		public int setPrefixQuery( String collection )
		{
			int ret = 0;
			int idx = getCollIdx(collection);
			
			// 표절 점수 범위 설정
			String prefixQuery = wncol.COLLECTION_INFO[idx][PREFIX_QUERY];
			if( !prefixQuery.equals("") )
			{
				ret = search.wSetPrefixQuery(prefixQuery);
				if( ret < 0 )
				{
					errorMessage.append("\n[wSetPrefixQuery] ").append(search.wGetErrorMessage());
				}
			}
			
			if(isDebug){
				debugMessage.append("\n[wSetPrefixQuery] " + prefixQuery );
			}
			
			return ret;
		}
		
		public int browsingQuery(){
			return search.wBrowsingQuery();
		}
		
		public int getResultCount(){
			int count = search.wGetResultCount();
			if( count < 0 ){
				errorMessage.append("\n[wGetResultCount] ").append(search.wGetErrorMessage());
			}
			
			return count;
		}
		
		public float getScore(int idx)
		{
			float score = search.wGetScore(idx);
			if( score < 0 ){
				errorMessage.append("\n[wGetScore] ").append(search.wGetErrorMessage());
			}
			
			return score;
		}
		
		public String getField(int idx, String field)
		{		
			String resultField = "";
			if( "UID".equalsIgnoreCase(field)){
				return String.valueOf( search.wGetUid(idx) );
			}
			else
			{
				resultField = search.wGetField(idx, field);
				if( resultField == null ){
					errorMessage.append("\n[wGetField] ").append(search.wGetErrorMessage());
				}
			}
			
			return resultField;
		}
		
		public String getHighlight(){
			String highlight = search.wGetHighlight();
			if( highlight == null ){
				errorMessage.append("\n[wGetHighlight] ").append(search.wGetErrorMessage());
			}
			
			return highlight;
		}
		
		public String getSourceHighlight(){
			String sourceHighlight = search.wGetSourceHighlight();
			if( sourceHighlight == null ){
				errorMessage.append("\n[wGetSourceHighlight] ").append(search.wGetErrorMessage());
			}
			
			return sourceHighlight;
		}
		
		public String getTargetHighlight(){
			String targetHighlight = search.wGetTargetHighlight();
			if( targetHighlight == null ){
				errorMessage.append("\n[wGetTargetHighlight] ").append(search.wGetErrorMessage());
			}
			
			return targetHighlight;
		}
		
		public float getOneToNScore(){
			float score = search.wGetOneToNScore();
			if( score < 0 ){
				errorMessage.append("\n[wGetOneToNScore] ").append(search.wGetErrorMessage());
			}
			
			return score;
		}
		
		public float getOneToOneScore(){
			float score = search.wGetOneToOneScore();
			if( score < 0 ){
				errorMessage.append("\n[wGetOneToOneScore] ").append(search.wGetErrorMessage());
			}
			
			return score;
		}
		
		public String getSourceField( String field ){
			String sourceField = search.wGetSourceField(field);
			if( sourceField == null ){
				errorMessage.append("\n[wGetSourceField] ").append(search.wGetErrorMessage());
			}
			
			return sourceField;
		}
		
		public String getTargetFieldInHighlight( String field ){
			String targetField = search.wGetTargetFieldInHighlight(field);
			if( targetField == null ){
				errorMessage.append("\n[wGetTargetFieldInHighlight] ").append(search.wGetErrorMessage());
			}
			
			return targetField;
		}
		
		public int getSourceBlockCount(){
			int blockCount = search.wGetSourceBlockCount();
			if( blockCount < 0 ){
				errorMessage.append("\n[wGetSourceBlockCount] ").append(search.wGetErrorMessage());
			}
			
			return blockCount;
		}
		
		public String getSourceBlock( int index ){
			String block = search.wGetSourceBlock(index);
			if( block == null ){
				errorMessage.append("\n[wGetSourceBlock] ").append(search.wGetErrorMessage());
			}
			
			return block;
		}
		
		public String getSourceBlockInfo( int index ){
			String blockInfo = search.wGetSourceBlockInfo(index);
			if( blockInfo == null ){
				errorMessage.append("\n[wGetSourceBlockInfo] ").append(search.wGetErrorMessage());
			}
			
			return blockInfo;
		}
		
		public int getTargetBlockCount( int targetIdx ){
			int blockCount = search.wGetTargetBlockCount(targetIdx);
			if( blockCount < 0 ){
				errorMessage.append("\n[wGetTargetBlockCount] ").append(search.wGetErrorMessage());
			}
			
			return blockCount;
		}
		
		public String getTargetBlock( int sourceIdx, int targetIdx ){
			String block = search.wGetTargetBlock(sourceIdx, targetIdx);
			if( block == null ){
				errorMessage.append("\n[wGetTargetBlock] ").append(search.wGetErrorMessage());
			}
			
			return block;
		}
		
		public String getTargetBlockInfo( int sourceIdx, int targetIdx ){
			String blockInfo = search.wGetTargetBlockInfo(sourceIdx, targetIdx);
			if( blockInfo == null ){
				errorMessage.append("\n[wGetTargetBlock] ").append(search.wGetErrorMessage());
			}
			
			return blockInfo;
		}
		
		public String getTargetBlockFieldInSummary( int sourceIdx, int targetIdx, String fieldName){
			String field = search.wGetTargetFieldInSummary(sourceIdx, targetIdx, fieldName);
			if( field == null){
				errorMessage.append("\n[wGetTargetBlock] ").append(search.wGetErrorMessage());
			}
			
			return field;
		}
		
		public boolean isComposite( float threashold ){
			if ( search.wIsComposite(threashold)==1 ){
				return true;
			}else{
				return false;
			}
		}
		
		public String printDebug(){
			String errorSep = errorMessage.toString().equals("")? "":"\n>>>>>ERROR>>>>>";
				
			debugMessage.append(errorSep + errorMessage.toString());
			return debugMessage.toString();
		}
		
		public int closeServer(){
			int ret = search.closeServer();
			if( ret < 0 ){
				errorMessage.append("\n[closeServer] ").append(search.wGetErrorMessage());
			}
			return ret;
		}
		
		public int getCollIdx(String collName) {
			for(int i=0; i < COLLECTIONS.length; i++) {
				if (COLLECTIONS[i].equals(collName)) return i;
			}
			return -1;
		}
	}
%>