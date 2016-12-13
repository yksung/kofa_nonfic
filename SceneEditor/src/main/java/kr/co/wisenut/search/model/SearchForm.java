package kr.co.wisenut.search.model;

public class SearchForm {
	boolean categorySearch;
	String query;
	String sort;
	int page;
	int pageSize;
	String searchField;
	String displayFields;
	String prefixQuery;
	String filterQuery;
	String categoryField;
	String categoryQuery;
	String categoryGroupby;
	
	public boolean isCategorySearch() {
		return categorySearch;
	}
	public void setCategorySearch(boolean categorySearch) {
		this.categorySearch = categorySearch;
	}
	public String getQuery() {
		return query;
	}
	public void setQuery(String query) {
		this.query = query;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
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
	public String getSearchField() {
		return searchField;
	}
	public void setSearchField(String searchField) {
		this.searchField = searchField;
	}
	public String getDisplayFields() {
		return displayFields;
	}
	public void setDisplayFields(String displayFields) {
		this.displayFields = displayFields;
	}
	public String getPrefixQuery() {
		return prefixQuery;
	}
	public void setPrefixQuery(String prefixQuery) {
		this.prefixQuery = prefixQuery;
	}
	public String getFilterQuery() {
		return filterQuery;
	}
	public void setFilterQuery(String filterQuery) {
		this.filterQuery = filterQuery;
	}
	public String getCategoryField() {
		return categoryField;
	}
	public void setCategoryField(String categoryField) {
		this.categoryField = categoryField;
	}
	public String getCategoryQuery() {
		return categoryQuery;
	}
	public void setCategoryQuery(String categoryQuery) {
		this.categoryQuery = categoryQuery;
	}
	public String getCategoryGroupby() {
		return categoryGroupby;
	}
	public void setCategoryGroupby(String categoryGroupby) {
		this.categoryGroupby = categoryGroupby;
	}
	
}
