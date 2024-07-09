package com.itwillbs.oi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.ChattingMapper;
import com.itwillbs.oi.vo.ProductChatRoomVO;
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
	
	// 운송장 등록 여부 가져오기
	public Map<String, Object> getDeliveryinfo(Map<String, Object> map) {
		return mapper.getDeliveryinfo(map);
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
	
	// 오이 신선도
	public void updateFreshness(Map<String, String> map) {
		mapper.updateFreshness(map);
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

	// 안 읽은 메세지 개수 가져오기
	public List<Map<String, Object>> getReadCount(Map<String, Object> map) {
		
		List<Map<String, Object>> readCountInfo = mapper.getReadCount(map);
		
		if(readCountInfo.isEmpty()) {
			return null;
		}
		
		Map<String, Object> firstEntry = readCountInfo.get(0);

		// 읽은 메시지 개수를 가져옵니다.
		int readCount = (int) firstEntry.get("CM_READCOUNT");

		// 아무도 안 읽었거나 내가 안 읽었을 때 전달 아니면 null 전달
		if (readCount == 2) {
		    return readCountInfo;
		} else if (readCount == 1 && !firstEntry.get("CM_READBY").equals(map.get("US_ID"))) {
		    return readCountInfo;
		} else {
		    return null;
		}
		
	}

	
	// 안 읽은 회수 차감
	public int updateUnreadCnt(Map<String, Object> map) {
		
		List<Map<String, Object>> unread = mapper.getUnreadCnt(map);
		int cnt = 0;
		for (Map<String, Object> un : unread) {
			int readCount = (int) un.get("CM_READCOUNT");
			
		    if(readCount == 2) {
		    	cnt = mapper.updateUnreadCnt(map);
		    } else  {
		    	cnt = mapper.updateUnreadZero(map);
		    } 
		}
		return cnt;
	}

	// 채팅방이 있는지
	public int checkChat(ProductChatVO chat) {
		return mapper.checkChat(chat);
	}

	

	
	// ------------------------------------------------------------------------------
	// 채팅방 있는지
	public Map<String, Object> getChatRoom(String TO_ID, String FROM_ID, int PD_IDX) {
		return mapper.getChatRoom(TO_ID, FROM_ID, PD_IDX);
	}



	
}
