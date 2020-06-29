package com.ubi.erp.comm.domain;

import java.io.Serializable;

import org.apache.ibatis.type.Alias;

@Alias("MenuVO")
public class MenuVO implements Serializable {

	private static final long serialVersionUID = 1L;

	private String menucd;

	private String kind;

	private String menugbn;

	private String pmenucd;

	private String menuname;

	private int seq;

	private String exegbn;

	private String scrnParm;

	private String uri;

	private String id;

	private int auth;

	public String getMenucd() {
		return menucd;
	}

	public void setMenucd(String menucd) {
		this.menucd = menucd;
	}

	public String getKind() {
		return kind;
	}

	public void setKind(String kind) {
		this.kind = kind;
	}

	public String getMenugbn() {
		return menugbn;
	}

	public void setMenugbn(String menugbn) {
		this.menugbn = menugbn;
	}

	public String getPmenucd() {
		return pmenucd;
	}

	public void setPmenucd(String pmenucd) {
		this.pmenucd = pmenucd;
	}

	public String getMenuname() {
		return menuname;
	}

	public void setMenuname(String menuname) {
		this.menuname = menuname;
	}

	public int getSeq() {
		return seq;
	}

	public void setSeq(int seq) {
		this.seq = seq;
	}

	public String getExegbn() {
		return exegbn;
	}

	public void setExegbn(String exegbn) {
		this.exegbn = exegbn;
	}

	public String getScrnParm() {
		return scrnParm;
	}

	public void setScrnParm(String scrnParm) {
		this.scrnParm = scrnParm;
	}

	public String getUri() {
		return uri;
	}

	public void setUri(String uri) {
		this.uri = uri;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getAuth() {
		return auth;
	}

	public void setAuth(int auth) {
		this.auth = auth;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

}
