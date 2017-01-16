package kr.co.wisenut.search.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;

import com.fasterxml.jackson.core.JsonParseException;
import com.fasterxml.jackson.databind.JsonMappingException;

import kr.co.wisenut.search.model.JsonResult;
import kr.co.wisenut.search.model.SearchForm;

public interface SearchService {
	public void search(SearchForm form) throws Exception;
	public ArrayList<HashMap<String,String>> getResultList();
	public int getTotalResultCount();
	public int getResultCount();
	public HashMap<String,String> getCategoryGroupby();
	public String getPageLinks(int startCount, int totalCount, int viewListCount, int bundleCount);
	public String getTMResultAsQuery(String query) throws JsonParseException, JsonMappingException, IOException;
	public String getArkHtmlResult(String arkQuery, String target);
}
