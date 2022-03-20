package com.ffunding.web.auth;

import org.apache.commons.lang.StringUtils;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ffunding.web.vo.MemberVO;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.OAuth20Service;

public class SNSLogin {
	private OAuth20Service oauthService;
	private SnsValue sns;
	
	public SNSLogin (SnsValue sns) {
		this.oauthService = new ServiceBuilder(sns.getClientId())
				.apiSecret(sns.getClienSecret())
				.callback(sns.getRedirectUrl())
				.defaultScope("profile") // OAuth2Service가 사용자 정보를 가져옴
				.build(sns.getApi20Instance());
		
		this.sns = sns;
	}
	
	public String getNaverAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}

	public MemberVO getUserProfile(String code) throws Exception {
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		
		OAuthRequest request = new OAuthRequest(Verb.GET, this.sns.getProfileUrl());
		oauthService.signRequest(accessToken, request); // token과 url을 담는다.
		
		Response response = oauthService.execute(request);
		return parseJson(response.getBody());
	}

	// body로 받은 사용자 profile을 MemberVO 객체로 파싱
	private MemberVO parseJson(String body) throws Exception {
		System.out.println("========================\n"+ body + "\n=======================");
		MemberVO memberVO = new MemberVO();
		boolean isNaver = this.sns.isNaver(); 
//		boolean isGoogle = this.sns.isGoogle(); 
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);
		
		if(isNaver) {
			JsonNode resNode = rootNode.get("response");
			memberVO.setNaverid(resNode.get("id").asText());
			memberVO.setMemail(resNode.get("email").asText());
			memberVO.setMname(resNode.get("name").asText());
		}
		
		/*
		 * else if(isGoogle) { String id = rootNode.get("id").asText(); if
		 * (sns.isGoogle()) memverVO.setGoogleid(id); JsonNode displayName =
		 * rootNode.get("displayName"); }
		 */
		
		
		
		return memberVO;
	}
}
