package kr.co.wisenut.search.service;

import java.util.ArrayList;
import java.util.HashMap;

import kr.co.wisenut.search.model.SearchForm;

public interface SearchService {
	public void search(SearchForm form) throws Exception;
	public ArrayList<HashMap<String,String>> getResultList();
	public int getTotalResultCount();
	public int getResultCount();
	public HashMap<String,String> getCategoryGroupby();
	public String getPageLinks(int startCount, int totalCount, int viewListCount, int bundleCount);
	public String getArkHtmlResult(String arkQuery, String target);
}
