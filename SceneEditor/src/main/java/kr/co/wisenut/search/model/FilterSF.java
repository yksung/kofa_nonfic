package kr.co.wisenut.search.model;

import com.fasterxml.jackson.annotation.JsonProperty;

public class FilterSF {
	String SFName;
	String SFEntry;
	
	@JsonProperty("SFName")
	public String getSFName() {
		return SFName;
	}
	public void setSFName(String sFName) {
		SFName = sFName;
	}
	
	@JsonProperty("SFEntry")
	public String getSFEntry() {
		return SFEntry;
	}
	public void setSFEntry(String sFEntry) {
		SFEntry = sFEntry;
	}
	
	
}
