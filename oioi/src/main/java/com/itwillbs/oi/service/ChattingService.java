package com.itwillbs.oi.service;

import java.util.ArrayList;
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
		return mapper.registDelivery(map);
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

	// 채팅 저장하기
	public int saveChatting(ProductChatVO chatMessage) {
		return mapper.saveChatting(chatMessage);
	}

	// 채팅 리스트 가져오기
	public List<Map<String, Object>> getMyChatInfo(Map map) {
		return mapper.getMyChatInfo(map);
	}

	// 마지막 채팅 및 시간 가져오기
	public Map<String, Object> getMyChatList(String crId) {
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
		
		// 필터링된 결과를 저장할 리스트를 초기화한다
	    List<Map<String, Object>> filteredList = new ArrayList<>();

	    // readCountInfo 리스트를 순회한다
	    for (Map<String, Object> entry : readCountInfo) {
	    	
	        if ((int) entry.get("CM_READCOUNT") == 1 && !entry.get("CM_READBY").equals(map.get("US_ID"))) {
	            filteredList.add(entry);
	        }
	    }

	    // 필터링 리스트가 비어 있으면 null을 반환하고, 그렇지 않으면 필터링된 리스트를 반환한다
	    return filteredList.isEmpty() ? null : filteredList;
		
	}

	
	// 안 읽은 회수 차감
	public int updateUnreadCnt(Map<String, Object> map) {
		
		List<Map<String, Object>> unread = mapper.getUnreadCnt(map);
		int cnt = 0;
		for (Map<String, Object> un : unread) {
			int readCount = (int) un.get("CM_READCOUNT");
	    	cnt = mapper.updateUnreadZero(map);
		}
		return cnt;
	}

	// 채팅방이 있는지
	public int checkChat(ProductChatVO chat) {
		return mapper.checkChat(chat);
	}

	// 채팅방 있는지
	public Map<String, Object> getChatRoom(String TO_ID, String FROM_ID, int PD_IDX) {
		return mapper.getChatRoom(TO_ID, FROM_ID, PD_IDX);
	}

	// 판매자 및 구매자 정보
	public Map<String, String> getUserRole(Map<String, Object> map) {
		return mapper.getUserRole(map);
	}

	// 거래 내역 정보
	public int getMyTradeInfo(Map<String, Object> map) {
		return mapper.getMyTradeInfo(map);
	}

	// 3일 지나면 자동 이체
	public int eventDelivery(Map<String, Object> map) {
		return mapper.eventDelivery(map);
	}

	// 택배 status 바꾸기
	public void updateDelivery(Map<String, String> pdInfo) {
		mapper.updateDelivery(pdInfo);
	}

	// 대화방 나가기
	public void removeRoom(ProductChatVO chatMessage) {
		
		// status 가져오기
		int status = mapper.getRemoveRoomStatus(chatMessage);
		
		if(status == 0 ) {
			mapper.removerRoom(chatMessage);
		} else if (status == 1) {
			mapper.statusTwoRemove(chatMessage);
		}
	}

	// 누가 채팅방을 나갔는지
	public Map<String, Object> getUserExitRoom(Map<String, Object> map) {
		return mapper.getUserExitRoom(map);
	}

	public int deliveryInfo(Map map) {
		return mapper.deliveryinfo(map);
	}



	
}
