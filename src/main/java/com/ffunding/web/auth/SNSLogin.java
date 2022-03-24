package com.ffunding.web.auth;

import java.util.Iterator;

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
				.defaultScope("openid profile email") // OAuth2Service가 사용자 정보를 가져옴
				.build(sns.getApi20Instance());
		
		this.sns = sns;
	}
	
	public String getAuthURL() {
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
		}
		
		return memberVO;
	}
	
	// 회원 탈퇴
	public boolean deleteInfo(String access) throws Exception
	{
	    OAuthRequest oAuthRequest = new OAuthRequest(Verb.GET, sns.getApi20Instance().getAccessTokenEndpoint());
	    oAuthRequest.addQuerystringParameter("client_id", "tEi_UJR4cKKf3EHyTNeN");
	    oAuthRequest.addQuerystringParameter("client_secret", "UrwWRHVt1h");
	    oAuthRequest.addQuerystringParameter("access_token", access);
	    oAuthRequest.addQuerystringParameter("grant_type", "delete");
	    oAuthRequest.addQuerystringParameter("service_provider", "NAVER");
	    
	    oauthService.signRequest(access, oAuthRequest);
	    
	    Response response = oauthService.execute(oAuthRequest);
	    
	    return response.isSuccessful();
	}
}
