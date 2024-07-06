package com.itwillbs.oi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.ChattingMapper;
import com.itwillbs.oi.vo.ProductChatVO;

@Service
public class ChattingService {

	
	@Autowired
	private ChattingMapper mapper;

	// [정보 가져오기] 
	// 채팅 시 필요한 상품 정보 가져오기
	public Map<String, String> getProductInfo(Map<String, Object> map) {
		return mapper.getProductInfo(map);
	}

	// 상대방 정보 가져오기 
	public Map<String, String> getOtherInfo(Map<String, Object> map) {
		return mapper.getOtherInfo(map);
	}
	
	// 내 정보
	public Map<String, String> getMyInfo(Map<String, Object> map) {
		return mapper.getMyInfo(map);
	}
	
	// 신고 카테고리 가져오기
	public List<Map<String, String>> getReportCategory() {
		return mapper.selectReportCategory();
	}
	
	// 리뷰 카테고리 가져오기
	public List<Map<String, String>> getReviewCategory() {
		return mapper.selectReviewCategory();
	}

	// ---------------------------------------------------------------------------
	
	// [정보 처리하기]
	// 신고하기
	public int insertReport(Map<String, String> map) {
		return mapper.insertReport(map);
	}

	// 리뷰 작성
	public int insertReview(Map<String, String> map) {
		return mapper.insertReview(map);
	}

	// 리뷰 존재하는지 확인
	public int selectReview(Map<String, Object> map) {
		return mapper.selectReview(map);
	}
	
	// 운송장 번호 등록하기
	public int registDelivery(Map<String, Object> map) {
		return mapper.registDelivey(map);
	}

	// ----------------------------------------------------------------------------
	
	// 채팅방 만들기
	public int createRoom(ProductChatVO chat) {
		return mapper.createRoom(chat);
	}

	// 채팅방 있는지 체크 및 채팅방 아이디 가져오기
	public Map<String, Object> checkChatRoom(Map<String, Object> map) {
		return mapper.checkChatRoom(map);
	}

	// 채팅 저장하기
	public int saveChatting(Map<String, Object> map) {
		return mapper.saveChatting(map);
	}

	// 채팅 리스트 가져오기
	public List<Map<String, Object>> getMyChatInfo(Map map) {
		return mapper.getMyChatInfo(map);
	}

	// 마지막 채팅 및 시간 가져오기
	public Map<String, Object> getMyChatList(int crId) {
		return mapper.getMyChatList(crId);
	}

	// 채팅 메세지 가져오기
	public List<Map<String, String>> getChatMsg(Map<String, Object> map) {
		return mapper.getChatMsg(map);
	}

	// 채팅 메세지 존재하는지 확인
	public Map<String, Object> existMsg(Map<String, Object> map) {
		return mapper.existmsg(map);
	}

	


	
}
