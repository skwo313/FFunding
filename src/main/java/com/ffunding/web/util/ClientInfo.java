package com.ffunding.web.util;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.TimeZone;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

@Component
public class ClientInfo {
	/**
	 * 클라이언트의 ip 주소를 가져옴
	 * @return ip 주소
	 */
	public String getIpAddr() {
		String ip_addr = null;
		ServletRequestAttributes sra = (ServletRequestAttributes) RequestContextHolder.currentRequestAttributes();
		HttpServletRequest request = sra.getRequest();
		
		ip_addr = request.getHeader("X-Forwarded-For");
		if (ip_addr == null) {
			ip_addr = request.getHeader("Proxy-Client-IP");
		}
		if (ip_addr == null) {
			ip_addr = request.getHeader("WL-Proxy-Client-IP"); 
	    }
		if (ip_addr == null) {
			ip_addr = request.getHeader("HTTP_CLIENT_IP");
	    }
		if (ip_addr == null) {
			ip_addr = request.getHeader("HTTP_X_FORWARDED_FOR");
	    }
		if (ip_addr == null) {
			ip_addr = request.getRemoteAddr();
	    }
		return ip_addr;
	}
	
	/**
	 * 클라이언트의 현재 시간을 가져옴
	 * @return 현재 시간
	 */
	public String getTime() {
		TimeZone zone = TimeZone.getTimeZone("Asia/Seoul");
		DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		format.setTimeZone(zone);
		String currentTime = format.format(System.currentTimeMillis());
		return currentTime;
	}
	
}