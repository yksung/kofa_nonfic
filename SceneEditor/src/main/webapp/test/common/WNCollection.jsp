<%@ page pageEncoding = "UTF-8" %><%@ page import="java.util.*"%><%!

	/**
	 * File : WNCollection.jsp
	 * Subject : Referee 서버와의 연결 정보 등 설정 정보를 정의한 클래스
	 * 
	 * @author yksung
	 * @update 2014.05.07
	 * 
	 */

	public static String CHARSET = "UTF-8";
	public static int PAGE_SIZE = 10; //view page list count
	public static float COMPOSITE_THRESHOLD = (float)0.8;

    public static String SEARCH_IP="127.0.0.1";
    public static int SEARCH_PORT=9000;
    public static int TIME_OUT=20000;
    
    public final static int COLLECTION_NAME = 0;
    public final static int SORT_FIELD = 1;
    public final static int RESULT_FIELD = 2;
    public final static int SESSION_INFO = 3;
    public final static int DATE_RANGE = 4;
    public final static int SCORE_RANGE = 5;
    public final static int PREFIX_QUERY = 6;
    public final static int FILTER_QUERY = 7;    
    
    public final static int HIGHLIGHT_TEXT_TO_TEXT = 8;
    public final static int HIGHLIGHT_TEXT_TO_UID = 9;
    public final static int HIGHLIGHT_TEXT_TO_DOCID = 10;
    public final static int HIGHLIGHT_UID_TO_TEXT = 11;
    public final static int HIGHLIGHT_UID_TO_UID = 12;
    public final static int HIGHLIGHT_UID_TO_DOCID = 13;
    public final static int HIGHLIGHT_DOCID_TO_TEXT = 14;
    public final static int HIGHLIGHT_DOCID_TO_UID = 15;
    public final static int HIGHLIGHT_DOCID_TO_DOCID = 16;
    public final static int QUERY_BY_TEXT = 17;
    public final static int QUERY_BY_UID = 18;
    public final static int QUERY_BY_DOCID = 19;
    public final static int SUMMARIZE_TEXT_TO_UIDLIST = 20;
    public final static int SUMMARIZE_TEXT_TO_DOCIDLIST = 21;
    public final static int SUMMARIZE_DOCID_TO_UIDLIST = 22;
    public final static int SUMMARIZE_DOCID_TO_DOCIDLIST = 23;
    public final static int SUMMARIZE_UID_TO_UIDLIST = 24;
    public final static int SUMMARIZE_UID_TO_DOCIDLIST = 25;
    public final static int HIGHLIGHT_BLOCKS_BY_TEXT = 26;
    public final static int HIGHLIGHT_BLOCKS_BY_DOCID = 27;
    public final static int HIGHLIGHT_BLOCKS_BY_UID = 28;
    public final static int BROWSING_QUERY = 29;
    
	public static String[] COLLECTIONS = new String[]{"plagcol"};
	public static String[] COLLECTIONS_NAME = new String[]{"표절검색대상컬렉션"};
	
	public class WNCollection {
		
		public String[][] COLLECTION_INFO = null;
		
		public WNCollection(){
			COLLECTION_INFO = new String[][]
				{
					{
						"plagcol", // COLLECTION_NAME
						"SCORE DESC", // SORT_FIELD : [FIELD] [ASC/DESC]
						"DOCID,Date,REPORT_SUBMIT_NUMBER,LECTURE_NUMBER,TASK_CODE,REPORT_NAME,KIND_CODE,SUBMIT_START_DATE,SUBMIT_END_DATE,SUBMIT_FORM_CODE,REPORT_CONTENT,APPRAISAL_RATE,SUPPLEMENT_APPRAISAL_RATE,GRADE_OPEN_YN,USER_ID,USER_NAME,DELETE_YN,REG_USER_ID,REG_DATE,REG_IP,UPDATE_USER_ID,UPDATE_DATE,UPDATE_IP,READ_COUNT,LMS_UPLOAD_KEY,LCMS_UPLOAD_KEY", // RESULT_FIELD
						"", // SESSION_INFO
						"", // DATE_RANGE
						"", // SCORE_RANGE
						"", // PREFIX_QUERY
						""  // FILTER_QUERY
					}
				};
		}
	}
	
	public static String getQueryName(int type){
		switch(type){
		case HIGHLIGHT_TEXT_TO_TEXT :
			return "HIGHLIGHT_TEXT_TO_TEXT";
		case HIGHLIGHT_TEXT_TO_UID :
			return "HIGHLIGHT_TEXT_TO_UID";
		case HIGHLIGHT_TEXT_TO_DOCID :
			return "HIGHLIGHT_TEXT_TO_DOCID";
		case HIGHLIGHT_UID_TO_TEXT :
			return "HIGHLIGHT_UID_TO_TEXT";
		case HIGHLIGHT_UID_TO_UID :
			return "HIGHLIGHT_UID_TO_UID";
		case HIGHLIGHT_UID_TO_DOCID :
			return "HIGHLIGHT_UID_TO_DOCID";
		case HIGHLIGHT_DOCID_TO_TEXT :
			return "HIGHLIGHT_DOCID_TO_TEXT";
		case HIGHLIGHT_DOCID_TO_UID :
			return "HIGHLIGHT_DOCID_TO_UID";
		case HIGHLIGHT_DOCID_TO_DOCID :
			return "HIGHLIGHT_DOCID_TO_DOCID";
		case QUERY_BY_TEXT :
			return "QUERY_BY_TEXT";
		case QUERY_BY_UID :
			return "QUERY_BY_UID";
		case QUERY_BY_DOCID :
			return "QUERY_BY_DOCID";
		case SUMMARIZE_TEXT_TO_UIDLIST :
			return "SUMMARIZE_TEXT_TO_UIDLIST";
		case SUMMARIZE_TEXT_TO_DOCIDLIST :
			return "SUMMARIZE_TEXT_TO_DOCIDLIST";
		case SUMMARIZE_DOCID_TO_UIDLIST :
			return "SUMMARIZE_DOCID_TO_UIDLIST";
		case SUMMARIZE_DOCID_TO_DOCIDLIST :
			return "SUMMARIZE_DOCID_TO_DOCIDLIST";
		case SUMMARIZE_UID_TO_UIDLIST :
			return "SUMMARIZE_UID_TO_UIDLIST";
		case SUMMARIZE_UID_TO_DOCIDLIST :
			return "SUMMARIZE_UID_TO_DOCIDLIST";
		case HIGHLIGHT_BLOCKS_BY_TEXT :
			return "HIGHLIGHT_BLOCKS_BY_TEXT";
		case HIGHLIGHT_BLOCKS_BY_DOCID :
			return "HIGHLIGHT_BLOCKS_BY_DOCID";
		case HIGHLIGHT_BLOCKS_BY_UID :
			return "HIGHLIGHT_BLOCKS_BY_UID";
		case BROWSING_QUERY :
			return "BROWSING_QUERY";
		default :
			return "-";
		}
	}
%>