package com.ffunding.web.auth;

import java.io.IOException;
import java.util.Iterator;
import java.util.concurrent.ExecutionException;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ffunding.web.vo.MemberVO;
import com.github.scribejava.core.builder.ServiceBuilder;
import com.github.scribejava.core.model.OAuth2AccessToken;
import com.github.scribejava.core.model.OAuthRequest;
import com.github.scribejava.core.model.Response;
import com.github.scribejava.core.model.Verb;
import com.github.scribejava.core.oauth.AccessTokenRequestParams;
import com.github.scribejava.core.oauth.OAuth20Service;


public class SNSLogin {
	private OAuth20Service oauthService;
	private SnsValue sns;
	
	public SNSLogin (SnsValue sns) {
		this.sns = sns;
		
		String scope = "";
		if (this.sns.isKakao()) {
			scope = "account_email profile_nickname";
		} else {
			scope = "openid profile email";
		}
		
		this.oauthService = new ServiceBuilder(sns.getClientId())
				.apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl())
				.defaultScope(scope) // OAuth2Service가 사용자 정보를 가져옴
				.build(sns.getApi20Instance());
	}
	
	public String getAuthURL() {
		return this.oauthService.getAuthorizationUrl();
	}

	public MemberVO getUserProfile(String code) throws Exception {
		// 접근 토큰
		OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
		// 사용자 정보 응답 반환
		OAuthRequest request = new OAuthRequest(Verb.GET, this.sns.getProfileUrl());
		oauthService.signRequest(accessToken, request);
		
		Response response = oauthService.execute(request);
		
		return parseJson(response.getBody());
	}
	
	public MemberVO getKakaoUserProfile(String code) throws Exception {
		AccessTokenRequestParams params = new AccessTokenRequestParams(code);
		params.addExtraParameter("client_id", sns.getClientId());
		params.addExtraParameter("client_secret", sns.getClientSecret());
		OAuth2AccessToken accessToken = getAccessToken(params);
		
		OAuthRequest request = new OAuthRequest(Verb.GET, this.sns.getProfileUrl());
		oauthService.signRequest(accessToken, request);
		
		Response response = oauthService.execute(request);
		
		return parseJson(response.getBody());
	}
	
	/* 접근 토큰 반환 메서드 */
	private OAuth2AccessToken getAccessToken(AccessTokenRequestParams params) throws Exception {
		return oauthService.getAccessToken(params);
	}

	/* body로 받은 사용자 profile을 json 형식에서 MemberVO 객체로 파싱 */
	private MemberVO parseJson(String body) throws Exception {
		System.out.println("========================\n"+ body + "\n=======================");
		MemberVO memberVO = new MemberVO();
		boolean isNaver = this.sns.isNaver(); 
		boolean isGoogle = this.sns.isGoogle(); 
		
		ObjectMapper mapper = new ObjectMapper();
		JsonNode rootNode = mapper.readTree(body);
		
		if(isNaver) {
			JsonNode resNode = rootNode.get("response");
			memberVO.setNaverid(resNode.get("id").asText());
			memberVO.setMemail(resNode.get("email").asText());
			memberVO.setMname(resNode.get("name").asText());
		} else if(isGoogle) { 
			JsonNode nameNode = rootNode.path("names");
			memberVO.setGoogleid(nameNode.path(0).path("metadata").path("source").get("id").asText());
			memberVO.setMname(nameNode.path(0).get("displayName").asText()); 
			
			Iterator<JsonNode> iterEmails = rootNode.path("emailAddresses").elements();
			while(iterEmails.hasNext()) {
				JsonNode emailNode = iterEmails.next();
				boolean isPrimary = emailNode.path("metadata").get("primary").isValueNode();
				if(isPrimary) {
					memberVO.setMemail(emailNode.get("value").asText());
					break;
				};
			}
		} else {
			memberVO.setKakaoid(rootNode.get("id").asText()); 
			memberVO.setMname(rootNode.get("properties").get("nickname").asText()); 
			memberVO.setMemail(rootNode.path("kakao_account").get("email").asText());
		}
		
		return memberVO;
	}
	
	
	// 회원 탈퇴
//	public boolean deleteInfo(String access) throws Exception
//	{
//	    OAuthRequest oAuthRequest = new OAuthRequest(Verb.GET, sns.getApi20Instance().getAccessTokenEndpoint());
//	    oAuthRequest.addQuerystringParameter("client_id", "tEi_UJR4cKKf3EHyTNeN");
//	    oAuthRequest.addQuerystringParameter("client_secret", "UrwWRHVt1h");
//	    oAuthRequest.addQuerystringParameter("access_token", access);
//	    oAuthRequest.addQuerystringParameter("grant_type", "delete");
//	    oAuthRequest.addQuerystringParameter("service_provider", "NAVER");
//	    
//	    oauthService.signRequest(access, oAuthRequest);
//	    
//	    Response response = oauthService.execute(oAuthRequest);
//	    
//	    return response.isSuccessful();
//	}
}
