package com.koreait.vo;
//startNo, endNo와 item은 자료형이 다르기 때문에 HashMap객체를 사용할 수 없고 별도의 클래스(Param)를 만들어 처리한다.
public class Param {
	private int startNo, endNo;
	private String item;
	private String category;
	@Override
	public String toString() {
		return "Param [startNo=" + startNo + ", endNo=" + endNo + ", item=" + item + ", category=" + category + "]";
	}
	public int getStartNo() {
		return startNo;
	}
	public void setStartNo(int startNo) {
		this.startNo = startNo;
	}
	public int getEndNo() {
		return endNo;
	}
	public void setEndNo(int endNo) {
		this.endNo = endNo;
	}
	public String getItem() {
		return item;
	}
	public void setItem(String item) {
		this.item = item;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	
	
	
}
