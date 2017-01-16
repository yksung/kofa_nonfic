package kr.co.wisenut.search.model;

import java.util.ArrayList;

public class Result {
	int reqid;
	String kma;
	String lsp;
	String ner;
	FilterSF filterSF;
	Info info;
	Sentence sentence;
	MatchedText matched_text;
	ArrayList<Variable> variables;
	ArrayList<Category> categories;
	ArrayList<String> discoveredInfo;
	
	public int getReqid() {
		return reqid;
	}
	public void setReqid(int reqid) {
		this.reqid = reqid;
	}
	public String getKma() {
		return kma;
	}
	public void setKma(String kma) {
		this.kma = kma;
	}
	public String getLsp() {
		return lsp;
	}
	public void setLsp(String lsp) {
		this.lsp = lsp;
	}
	public String getNer() {
		return ner;
	}
	public void setNer(String ner) {
		this.ner = ner;
	}
	public FilterSF getFilterSF() {
		return filterSF;
	}
	public void setFilterSF(FilterSF filterSF) {
		this.filterSF = filterSF;
	}
	public Info getInfo() {
		return info;
	}
	public void setInfo(Info info) {
		this.info = info;
	}
	public Sentence getSentence() {
		return sentence;
	}
	public void setSentence(Sentence sentence) {
		this.sentence = sentence;
	}
	public MatchedText getMatched_text() {
		return matched_text;
	}
	public void setMatched_text(MatchedText matched_text) {
		this.matched_text = matched_text;
	}
	public ArrayList<Variable> getVariables() {
		return variables;
	}
	public void setVariables(ArrayList<Variable> variables) {
		this.variables = variables;
	}
	public ArrayList<Category> getCategories() {
		return categories;
	}
	public void setCategories(ArrayList<Category> categories) {
		this.categories = categories;
	}
	public ArrayList<String> getDiscoveredInfo() {
		return discoveredInfo;
	}
	public void setDiscoveredInfo(ArrayList<String> discoveredInfo) {
		this.discoveredInfo = discoveredInfo;
	}
}
