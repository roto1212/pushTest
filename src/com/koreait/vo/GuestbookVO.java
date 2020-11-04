package com.koreait.vo;

import java.util.Date;

// VO(Value Object)는 데이터 1건을 기억하는 게스트 => 게시글 1건 => DTO(Data Transfer Object)
public class GuestbookVO {
	
//	멤버변수이름은 데이터베이스 테이블의 필드명, html form의 name 속성값과 반드시 같게 만든다.
	private int idx;
	private String name;
	private String pw;
	private String memo;
	private Date writeDate;
	private String ip;
	@Override
	public String toString() {
		return "GuestbookVO [idx=" + idx + ", name=" + name + ", pw=" + pw + ", memo=" + memo + ", writeDate="
				+ writeDate + ", ip=" + ip + "]";
	}
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getMemo() {
		return memo;
	}
	public void setMemo(String memo) {
		this.memo = memo;
	}
	public Date getWriteDate() {
		return writeDate;
	}
	public void setWriteDate(Date writeDate) {
		this.writeDate = writeDate;
	}
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	
	
	
	
}
