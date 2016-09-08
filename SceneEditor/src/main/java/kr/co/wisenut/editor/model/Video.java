package kr.co.wisenut.editor.model;

public class Video {
	private int recid;
	private int vdoId;
	private String vdoTitle;
	private String vdoType;
	private String language;
	private String productionDate;
	/*private String filePath;
	private String vdoExt;*/
	private int runtime;
	/*private String vdoLClasCd1;
	private String vdoSClasCd1;
	private String vdoLClasCd2;
	private String vdoSClasCd2;
	private String vdoLClasCd3;
	private String vdoSClasCd3;*/
	private int scnCnt;
	
	public int getRecid() {
		return recid;
	}
	public void setRecid(int recid) {
		this.recid = recid;
	}
	public int getVdoId() {
		return vdoId;
	}
	public void setVdoId(int vdoId) {
		this.vdoId = vdoId;
	}
	public String getVdoTitle() {
		return vdoTitle;
	}
	public void setVdoTitle(String vdoTitle) {
		this.vdoTitle = vdoTitle;
	}
	public String getVdoType() {
		return vdoType;
	}
	public void setVdoType(String vdoType) {
		this.vdoType = vdoType;
	}
	public String getLanguage() {
		return language;
	}
	public void setLanguage(String language) {
		this.language = language;
	}
	public String getProductionDate() {
		return productionDate;
	}
	public void setProductionDate(String productionDate) {
		this.productionDate = productionDate;
	}
	public int getRuntime() {
		return runtime;
	}
	public void setRuntime(int runtime) {
		this.runtime = runtime;
	}
	public int getScnCnt() {
		return scnCnt;
	}
	public void setScnCnt(int scnCnt) {
		this.scnCnt = scnCnt;
	}
	
	
}
