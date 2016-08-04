package kr.co.wisenut.monitor.model;

public class Task {
	private int task_code;
	private String pgm_status;
	private float pgm_status_psnt;
	private int pgm_tcnt;
	private int pgm_cnt;
	private String pgm_start_dt;
	private String pgm_expect_dt;
	private int pgm_progs_sec;
	
	public int getTask_code() {
		return task_code;
	}
	public void setTask_code(int task_code) {
		this.task_code = task_code;
	}
	public String getPgm_status() {
		return pgm_status;
	}
	public void setPgm_status(String pgm_status) {
		this.pgm_status = pgm_status;
	}
	public float getPgm_status_psnt() {
		return pgm_status_psnt;
	}
	public void setPgm_status_psnt(float pgm_status_psnt) {
		this.pgm_status_psnt = pgm_status_psnt;
	}
	public int getPgm_tcnt() {
		return pgm_tcnt;
	}
	public void setPgm_tcnt(int pgm_tcnt) {
		this.pgm_tcnt = pgm_tcnt;
	}
	public int getPgm_cnt() {
		return pgm_cnt;
	}
	public void setPgm_cnt(int pgm_cnt) {
		this.pgm_cnt = pgm_cnt;
	}
	public String getPgm_start_dt() {
		return pgm_start_dt;
	}
	public void setPgm_start_dt(String pgm_start_dt) {
		this.pgm_start_dt = pgm_start_dt;
	}
	public String getPgm_expect_dt() {
		return pgm_expect_dt;
	}
	public void setPgm_expect_dt(String pgm_expect_dt) {
		this.pgm_expect_dt = pgm_expect_dt;
	}
	public int getPgm_progs_sec() {
		return pgm_progs_sec;
	}
	public void setPgm_progs_sec(int pgm_progs_sec) {
		this.pgm_progs_sec = pgm_progs_sec;
	}
	
	
}
