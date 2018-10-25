package com.pro.dto;

public class AccountVO {
	private String user_id;
	private String pwd;
	private String name;
	private String hp_num;

	// send message 内容
	private String title;
	private String msg;
	
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getUser_id() {
		return user_id;
	}
	public void setUser_id(String user_id) {
		this.user_id = user_id;
	}
	public String getPwd() {
		return pwd;
	}
	public void setPwd(String pwd) {
		this.pwd = pwd;
	}
//	public String getAuth() {
//		return auth;
//	}
//	public void setAuth(String auth) {
//		this.auth = auth;
//	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getHp_num() {
		return hp_num;
	}
	public void setHp_num(String hp_num) {
		this.hp_num = hp_num;
	}
}
