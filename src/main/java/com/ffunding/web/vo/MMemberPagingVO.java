package com.ffunding.web.vo;

public class MMemberPagingVO {
	//기본 페이지 처리
	private int count; //총건수(DB)
	private int pageSize; //한번에 보여줄 데이터 건수
	private int pageCount; //총 페이지 수
	private int curPage; //클릭한 현재 페이지 번호
	private int start; //DB에 넘길 페이지의 시작 번호
	private int end; //DB에 넘길 페이지의 마지막 번호
	//block 처리
	private int blockSize; //한번에 보여줄 하단의 페이지 블럭
	private int startBlock; //블럭의 시작 번호
	private int endBlock; //블럭의 마지막 번호
	//검색
	private String type; //검색 구분
	private String searchtext; //검색 내용
	
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	public int getPageCount() {
		return pageCount;
	}
	public void setPageCount(int pageCount) {
		this.pageCount = pageCount;
	}
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
	public int getBlockSize() {
		return blockSize;
	}
	public void setBlockSize(int blockSize) {
		this.blockSize = blockSize;
	}
	public int getStartBlock() {
		return startBlock;
	}
	public void setStartBlock(int startBlock) {
		this.startBlock = startBlock;
	}
	public int getEndBlock() {
		return endBlock;
	}
	public void setEndBlock(int endBlock) {
		this.endBlock = endBlock;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getSearchtext() {
		return searchtext;
	}
	public void setSearchtext(String searchtext) {
		this.searchtext = searchtext;
	}
}
	