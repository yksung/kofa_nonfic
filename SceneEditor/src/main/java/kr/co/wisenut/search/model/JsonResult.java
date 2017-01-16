package kr.co.wisenut.search.model;

import java.util.ArrayList;

public class JsonResult {
	Status stauts;
	ArrayList<Result> result;
	
	public Status getStauts() {
		return stauts;
	}
	public void setStauts(Status stauts) {
		this.stauts = stauts;
	}
	public ArrayList<Result> getResult() {
		return result;
	}
	public void setResult(ArrayList<Result> result) {
		this.result = result;
	}
}
