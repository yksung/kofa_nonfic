package kr.co.wisenut.editor.model;

import java.util.ArrayList;
import java.util.HashMap;

public class FormVO {
	private int scnId;
	private int vdoId;
	private String vdoNm;
	private String scnStartCd;
	private String scnEndCd;
	private String updDtime;
	private String editor;
	private String eventLClasCd;
	private String eventSClasCd;
	private String eventNm;
	private String eventPrd;
	private String domAbr;
	private String cntryCd;
	private String eventPlace;
	private String realPlace;
	private double latitude;
	private double longitude;
	private String celebrity1;
	private String celebrity2;
	private String celebrity3;
	private String description;
	private String narration;
	private String subtitles;
	private String summary;
	private String keyword;
	private String note;
	private String personId;
	private String personKorNm;
	private String personEngNm;
	private int page;
	private int pageSize;
	private int offset;
	private int limit;
	private int direction;
	private String viewOnlyHavingScene;
	private ArrayList<HashMap<String,String>> sort;
	private ArrayList<HashMap<String,String>> search;
	private String searchLogic;
	
	public int getScnId() {
		return scnId;
	}
	public void setScnId(int scnId) {
		this.scnId = scnId;
	}
	public int getVdoId() {
		return vdoId;
	}
	public void setVdoId(int vdoId) {
		this.vdoId = vdoId;
	}
	public String getVdoNm() {
		return vdoNm;
	}
	public void setVdoNm(String vdoNm) {
		this.vdoNm = vdoNm;
	}
	public String getScnStartCd() {
		return scnStartCd;
	}
	public void setScnStartCd(String scnStartCd) {
		this.scnStartCd = scnStartCd;
	}
	public String getScnEndCd() {
		return scnEndCd;
	}
	public void setScnEndCd(String scnEndCd) {
		this.scnEndCd = scnEndCd;
	}
	public String getUpdDtime() {
		return updDtime;
	}
	public void setUpdDtime(String updDtime) {
		this.updDtime = updDtime;
	}
	public String getEditor() {
		return editor;
	}
	public void setEditor(String editor) {
		this.editor = editor;
	}
	public String getEventLClasCd() {
		return eventLClasCd;
	}
	public void setEventLClasCd(String eventLClasCd) {
		this.eventLClasCd = eventLClasCd;
	}
	public String getEventSClasCd() {
		return eventSClasCd;
	}
	public void setEventSClasCd(String eventSClasCd) {
		this.eventSClasCd = eventSClasCd;
	}
	public String getEventNm() {
		return eventNm;
	}
	public void setEventNm(String eventNm) {
		this.eventNm = eventNm;
	}
	public String getEventPrd() {
		return eventPrd;
	}
	public void setEventPrd(String eventPrd) {
		this.eventPrd = eventPrd;
	}
	public String getDomAbr() {
		return domAbr;
	}
	public void setDomAbr(String domAbr) {
		this.domAbr = domAbr;
	}
	public String getCntryCd() {
		return cntryCd;
	}
	public void setCntryCd(String cntryCd) {
		this.cntryCd = cntryCd;
	}
	public String getEventPlace() {
		return eventPlace;
	}
	public void setEventPlace(String eventPlace) {
		this.eventPlace = eventPlace;
	}
	public String getRealPlace() {
		return realPlace;
	}
	public void setRealPlace(String realPlace) {
		this.realPlace = realPlace;
	}
	public double getLatitude() {
		return latitude;
	}
	public void setLatitude(double latitude) {
		this.latitude = latitude;
	}
	public double getLongitude() {
		return longitude;
	}
	public void setLongitude(double longitude) {
		this.longitude = longitude;
	}
	public String getCelebrity1() {
		return celebrity1;
	}
	public void setCelebrity1(String celebrity1) {
		this.celebrity1 = celebrity1;
	}
	public String getCelebrity2() {
		return celebrity2;
	}
	public void setCelebrity2(String celebrity2) {
		this.celebrity2 = celebrity2;
	}
	public String getCelebrity3() {
		return celebrity3;
	}
	public void setCelebrity3(String celebrity3) {
		this.celebrity3 = celebrity3;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public String getNarration() {
		return narration;
	}
	public void setNarration(String narration) {
		this.narration = narration;
	}
	public String getSubtitles() {
		return subtitles;
	}
	public void setSubtitles(String subtitles) {
		this.subtitles = subtitles;
	}
	public String getSummary() {
		return summary;
	}
	public void setSummary(String summary) {
		this.summary = summary;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getNote() {
		return note;
	}
	public void setNote(String note) {
		this.note = note;
	}
	public String getPersonId() {
		return personId;
	}
	public void setPersonId(String personId) {
		this.personId = personId;
	}
	public String getPersonKorNm() {
		return personKorNm;
	}
	public void setPersonKorNm(String personKorNm) {
		this.personKorNm = personKorNm;
	}
	public String getPersonEngNm() {
		return personEngNm;
	}
	public void setPersonEngNm(String personEngNm) {
		this.personEngNm = personEngNm;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getOffset() {
		return offset;
	}
	public void setOffset(int offset) {
		this.offset = offset;
	}
	public int getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
	}
	public int getDirection() {
		return direction;
	}
	public void setDirection(int direction) {
		this.direction = direction;
	}
	public String getViewOnlyHavingScene() {
		return viewOnlyHavingScene;
	}
	public void setViewOnlyHavingScene(String viewOnlyHavingScene) {
		this.viewOnlyHavingScene = viewOnlyHavingScene;
	}
	public ArrayList<HashMap<String, String>> getSort(){
		return sort;
	}
	public void setSort(ArrayList<HashMap<String, String>> sort) {
		this.sort = sort;
	}
	public ArrayList<HashMap<String, String>> getSearch() {
		return search;
	}
	public void setSearch(ArrayList<HashMap<String, String>> search) {
		this.search = search;
	}
	public String getSearchLogic() {
		return searchLogic;
	}
	public void setSearchLogic(String searchLogic) {
		this.searchLogic = searchLogic;
	}
	
	
}
