package com.ffunding.web.auth;

import com.github.scribejava.core.builder.api.DefaultApi20;

//싱글톤 패턴
public class NaverAPI20 extends DefaultApi20 implements SnsUrls{
	private NaverAPI20() {
	}
	
	private static class InstanceHolder {
		private static final NaverAPI20 INSTANCE = new NaverAPI20();
		// 처음에 들어온 인스턴스를 마지막 인스턴스로 저장
	}
	
	public static NaverAPI20 instance() {
		return InstanceHolder.INSTANCE;
	}

	@Override
	public String getAccessTokenEndpoint() {
		return NAVER_ACCESS_TOKEN;
	}

	@Override
	protected String getAuthorizationBaseUrl() {
		return NAVER_AUTH;
	}
}
