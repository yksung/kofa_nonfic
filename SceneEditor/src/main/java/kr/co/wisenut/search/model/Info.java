package kr.co.wisenut.search.model;

import java.util.ArrayList;

public class Info {
	int lspid;
	String conceptid;
	String conceptcodes;
	String conceptlabel;
	ArrayList<LSPAttribute> lspattributes;
	int lspweight;
	
	public int getLspid() {
		return lspid;
	}
	public void setLspid(int lspid) {
		this.lspid = lspid;
	}
	public String getConceptid() {
		return conceptid;
	}
	public void setConceptid(String conceptid) {
		this.conceptid = conceptid;
	}
	public String getConceptcodes() {
		return conceptcodes;
	}
	public void setConceptcodes(String conceptcodes) {
		this.conceptcodes = conceptcodes;
	}
	public String getConceptlabel() {
		return conceptlabel;
	}
	public void setConceptlabel(String conceptlabel) {
		this.conceptlabel = conceptlabel;
	}
	public ArrayList<LSPAttribute> getLspattributes() {
		return lspattributes;
	}
	public void setLspattributes(ArrayList<LSPAttribute> lspattributes) {
		this.lspattributes = lspattributes;
	}
	public int getLspweight() {
		return lspweight;
	}
	public void setLspweight(int lspweight) {
		this.lspweight = lspweight;
	}
}
