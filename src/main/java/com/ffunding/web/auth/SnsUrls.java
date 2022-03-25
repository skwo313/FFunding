package com.ffunding.web.auth;

public interface SnsUrls {
	static final String NAVER_ACCESS_TOKEN = "https://nid.naver.com/oauth2.0/token";
	static final String NAVER_AUTH = "https://nid.naver.com/oauth2.0/authorize";
	static final String KAKAO_ACCESS_TOKEN = "https://kauth.kakao.com/oauth/token?client_secret=rEI5JQxh8q7g3pLlH4hQHAoBZT9L3Jyu";
	static final String KAKAO_AUTH = "https://kauth.kakao.com/oauth/authorize";
	
	static final String NAVER_PROFILE_URL = "https://openapi.naver.com/v1/nid/me";
	static final String GOOGLE_PROFILE_URL = "https://people.googleapis.com/v1/people/me?personFields=emailAddresses%2Cnames&key=AIzaSyDaVSpUJEDs0uU_D9gqtVGVFkZOh5d0DBo";
	static final String KAKAO_PROFILE_URL = "https://kapi.kakao.com/v2/user/me";
}
