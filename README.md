# :pushpin: FFunding
>사용자가 관심이 있는 펀딩 상품에 자금을 지원 가능하며,  
>누구든지 자신의 아이디어를 펀딩 상품으로 실현 가능한 사이트  
>- [프로젝트 Demo 링크](https://bit.ly/3wIOmAp)
>- [ppt 포트폴리오](https://docs.google.com/presentation/d/1FXMe7KqAtcSigQceI-gJQxoXkFi9fSh_/edit?usp=sharing&ouid=117164930328240871021&rtpof=true&sd=true)

</br>

## 1. 제작 기간 & 참여 인원
- 2022년 3월 7일 ~ 4월 8일
- 팀 프로젝트 (5인)

</br>

## 2. 사용 기술
#### `Back-end`
  - Java 15
  - Spring Framework 5.0.8 RELLEASE
  - Maven 3.8.4
  - Oracle 11g
  - Mybatis 3.4.6
  - OAuth 2.0 API
#### `Front-end`
  - Javascript
  - jQuery
  - Ajax
  - Bootstrap

</br>

## 3. ERD 설계
#### `논리 테이블`
<img src="https://user-images.githubusercontent.com/84454039/168826339-a9eca3b7-142c-4612-aba0-41e4e28f4004.png" width="900" height="500"><br>
#### `물리 테이블`
<img src="https://user-images.githubusercontent.com/84454039/168826411-558d7edb-50dc-4597-9200-f012134ab193.png" width="900" height="500">
  
</br>
  
## 4. 핵심 기능
이 서비스에서 제가 맡아서 구현한 기능은 로그인, 회원가입, 마이페이지입니다.  
사이트에 비밀번호를 제공하지 않고 로그인 하고싶은 사용자를 위해 SNS회원 로그인 기능을 지원했고,  
보안을 위해 비밀번호를 암호화하여 외부해킹 및 내부에 의한 데이터 유출을 방지했습니다.  
마이페이지에서는 iamport 결제 API를 연동하여 사이트 내에서 사용할 수 있는 포인트 충전 기능을 구현했습니다.  
아래의 설명을 보면, 서비스가 어떻게 동작하는지 알 수 있습니다.  

<details>
<summary><b>핵심 기능 설명 펼치기</b></summary>
<div markdown="1">

### 4.1. 유스케이스 다이어그램
![유스케이스 다이어그램](https://user-images.githubusercontent.com/84454039/168969035-c9675c50-17ee-4cd2-ba61-62c2f516a5b2.png)

### 4.2. 데이터 플로우
![data flow](https://user-images.githubusercontent.com/84454039/168969245-395c641e-1f57-4ebe-868b-9f2963345852.png)
  
### 4.3. 사이트 맵
![sitemap](https://user-images.githubusercontent.com/84454039/168969255-8ff60e1a-1fc0-4a6b-826e-61cd29759d0d.png)

### 4.4. 로그인

![로그인](https://user-images.githubusercontent.com/84454039/168988149-a3bf98e5-cb19-417d-a0f7-1b775637f386.png)

- **페이지 요청** :pushpin: [코드 확인](https://bit.ly/3Pwqasa)
  - 사용자의 요청으로 로그인 페이지 렌더링 합니다. 이떄 OAuth API를 통해 각각의 소셜 로그인 링크를 받아옵니다.

- **로그인 결과 응답** :pushpin: [코드 확인](https://bit.ly/3MNPA2w)
  - Service 계층에서 넘어온 로직 처리 결과(메세지)를 화면단에 응답해줍니다.
  - DB에 저장된 비밀번호를 복호화하여 사용자가 입력한 비밀번호와 일치했을 시에 로그인이 완료됩니다.
  - 소셜 로그인 흐름: 사용자의 요청 > 해당 서비스에서 authorization code 발급 > access token 발급 > 받은 token과 함께 받아 올 프로필 정보 요청 > 첫 로그인 시 DB에 저장 후 로그인, 기존에 아이디가 있을 시 바로 로그인. [코드 확인](https://bit.ly/3Nu4bAo)
  
- **front단** :pushpin: [코드 확인](https://bit.ly/3MDQ2QX)
  - Ajax 통신으로 controller와 통신합니다.
  - 웹에 정보를 저장하는 localStorage를 이용하여 아이디 저장 기능을 지원합니다
  - 아이디/비밀번호 찾기는 6자리의 랜덤 난수를 SMTP 라이브러리를 이용하여 이메일로 전송하여 본인인증하는 방식으로 지원합니다.

### 4.5. 마이페이지

<img src="https://user-images.githubusercontent.com/84454039/169483599-0f098a18-7a31-4cf4-b73d-21214bd0e859.png" width="800" height="500">

- **회원정보수정** :pushpin: [코드 확인](https://bit.ly/3G9fpaN)
  - 현재 비밀번호와 입력된 비밀번호를 복호화 및 암호화를 진행하여 서로 일치하는지 확인합니다.
  - 이 때, 페이지 전환없이 확인하기 위해 ajax 방식을 사용했습니다.  
  - 정부 도로명주소 검색 API를 이용하여 간편한 주소 검색 및 수정 기능을 지원합니다.

- **주문내역** :pushpin: [코드 확인](https://bit.ly/3G9fqLT)
  - 구매한 펀딩, 후원 횟수를 보여주고 클릭 시, 상세내용 확인이 가능합니다.
  - 펀딩 내역을 최신순으로 나열하고 클릭 시 해당 프로젝트 페이지에서 확인이 가능하지만 펀딩이 끝난 프로젝트는 클릭이 안 되게 하였습니다.

</div>
</details>

</br>

## 5. 핵심 트러블 슈팅
### 5.1. OAuth scribeJava 라이브러리로 소셜로그인 구현 중 카카오에서 오류
- 저는 scribeJava 라이브러리를 이용하여 네이버,구글 로그인 구현 완료했고,
네이버,구글 로그인 구현 시 만든 인터페이스를 카카오로그인에 적용했습니다.

- 하지만, 접근 토큰(access token)을 반환하여 사용자 정보를 가져오는 메서드에서 scribeJava가 카카오에 대한 처리를 잘 못 하는건지,  
기존에 구현한 인터페이스를 사용하면 오류가 떠 당황했습니다.

- 때문에, 직접 Query에 정보를 직접 입력하여 날려야했습니다.

<details>
<summary><b>기존 코드</b></summary>
<div markdown="1">

~~~java
public SNSLogin (SnsValue sns) {
		this.oauthService = new ServiceBuilder(sns.getClientId())
				.apiSecret(sns.getClientSecret())
				.callback(sns.getRedirectUrl())
				.defaultScope(scope) // OAuth2Service가 사용자 정보를 가져옴
				.build(sns.getApi20Instance());
}  
  
/**
 * 접근 토큰 반환 메서드
 */
public MemberVO getUserProfile(String code) throws Exception {
	// 접근 토큰
	OAuth2AccessToken accessToken = oauthService.getAccessToken(code);
	// 사용자 정보 응답 반환
	OAuthRequest request = new OAuthRequest(Verb.GET, this.sns.getProfileUrl());
	oauthService.signRequest(accessToken, request);
		
	Response response = oauthService.execute(request);
		
	return parseJson(response.getBody());
}
~~~

</div>
</details>

- 이 때, **기존 코드**에서 처럼 scribeJava가 정보를 담아 요청하였지만,  
- 아래 **개선된 코드**와 같이 직접 요청을 생성하여 프로필 정보를 받아 올 수 있었습니다.  
- 직접 요청하는 메서드를 구현 중 오류: parameter에 정보를 담는 AccessTokenRequestParams class가 제가 사용중인 API 버전에서 찾지 못했습니다.  
최신 버전인 8.3.1 버전으로 업그레이드하여 해결했고, 언어 및 API 버전에 따른 차이에 대한 공부의 중요성을 다시금 깨달았습니다.
<details>
<summary><b>개선된 코드</b></summary>
<div markdown="1">

~~~java
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
/**
 * 카카오 접근 토큰 반환 메서드
 */
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
~~~

</div>
</details>
    
</br>

## 6. 회고 / 느낀점
> 프로젝트를 진행하면서 직접 모르는 부분을 찾으면서 오류를 해결했을 때 실력이 가장 성장한 것 같습니다.  
> 무엇보다 모르는 부분을 팀원들에게 도움을 요청하고, 팀원들이 해결한 방법을 저에게 적용시키며 좋은 피드백이 되어  
> 커뮤니케이션의 중요성을 직접 피부로 느꼈습니다.
