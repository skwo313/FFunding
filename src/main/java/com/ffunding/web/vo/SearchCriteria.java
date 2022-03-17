package com.ffunding.web.vo;

public class SearchCriteria extends Criteria {

	private String searchType = "";
	private String keyword = "";
	private String mid = "";

	public String getMid() {
		return mid;
	}

	public void setMid(String mid) {
		this.mid = mid;
	}

	public String getSearchType() {
		return searchType;
	}

	public void setSearchType(String searchType) {
		this.searchType = searchType;
	}

	public String getKeyword() {
		return keyword;
	}

	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}

	@Override
	public String toString() {
		return "SearchCriteria [searchType=" + searchType + ", keyword=" + keyword + "]";
	}

}