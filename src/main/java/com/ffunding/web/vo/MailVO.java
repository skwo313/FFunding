package com.ffunding.web.vo;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

public class MailVO {
	private String title;
	private String recipient;
	private int recipientck;
	private String[] recipients;
	private String content;
	private String sender;
	private List<MultipartFile> attach;
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getRecipient() {
		return recipient;
	}
	public void setRecipient(String recipient) {
		this.recipient = recipient;
	}
	public int getRecipientck() {
		return recipientck;
	}
	public void setRecipientck(int recipientck) {
		this.recipientck = recipientck;
	}
	public String[] getRecipients() {
		return recipients;
	}
	public void setRecipients(String[] recipients) {
		this.recipients = recipients;
	}
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getSender() {
		return sender;
	}
	public void setSender(String sender) {
		this.sender = sender;
	}
	public List<MultipartFile> getAttach() {
		return attach;
	}
	public void setAttach(List<MultipartFile> attach) {
		this.attach = attach;
	}
}
