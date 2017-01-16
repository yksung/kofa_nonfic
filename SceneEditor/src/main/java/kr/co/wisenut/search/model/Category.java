package kr.co.wisenut.search.model;

import java.util.ArrayList;

public class Category {
	String label;
	ArrayList<String> entries;
	
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public ArrayList<String> getEntries() {
		return entries;
	}
	public void setEntries(ArrayList<String> entries) {
		this.entries = entries;
	}
	
}
