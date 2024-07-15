package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.oi.vo.ProductChatRoomVO;
import com.itwillbs.oi.vo.ProductChatVO;

@Mapper
public interface ChattingMapper {

	// -------- 공통코드 가져오기 --------------
	List<Map<String, String>> selectReportCategory(); // 신고 카테고리 가져오기
	List<Map<String, String>> selectReviewCategory(); // 리뷰 카테고리 가져오기
	// ------------------------------------------
	
	// ----------- 정보 가져오기 ----------------
	Map<String, String> getProductInfo(Map<String, Object> map); // 채팅 시 필요한 상품 정보
	Map<String, String> getMyInfo(Map<String, Object> map); // 채팅 시 내 정보 가져오기
	Map<String, String> getOtherInfo(Map<String, Object> map); // 채팅 시 필요한 상대방 정보 가져오기
	Map<String, Object> getDeliveryinfo(Map<String, Object> map); // 운송장 번호 가져오기
	List<Map<String, Object>> getMyChatInfo(Map map); // 채팅 목록 가져오기
	Map<String, Object> getMyChatList(String crId); // 마지막 채팅 가져오기
	List<Map<String, String>> getChatMsg(Map<String, Object> map); // 채팅 내역 가져오기
	List<Map<String, Object>> getReadCount(Map<String, Object> map); // 안 읽은 메세지 개수 가져오기
	List<Map<String, Object>> getUnreadCnt(Map<String, Object> map); // 해당 채팅방의 안 읽은 메세지 개수만 가져오기
	// -------------------------------------------
	
	// ----------- 정보 처리하기 ----------------
	int insertReport(Map<String, String> map); // 신고 처리
	int insertReview(Map<String, String> map); // 리뷰 처리
	int selectReview(Map<String, Object> map); // 리뷰 쓴 물건인지 확인
	int registDelivery(Map<String, Object> map); // 운송장 등록
	void updateFreshness(Map<String, String> map); // 신선도 업데이트
	int eventDelivery(Map<String, Object> map); // 자동 이체
	void updateDelivery(Map<String, String> pdInfo); // 택배 status 바꾸기
	// -------------------------------------------

	// ----------- 채팅 ----------------
	int createRoom(ProductChatVO chat); // 채팅룸 만들기
	int saveChatting(ProductChatVO chatMessage); // 채팅 대화 저장
	Map<String, Object> existmsg(Map<String, Object> map); // 메세지 존재하는지 확인
	int updateUnreadCnt(Map<String, Object> map); // 안 읽은 메세지 수가 2일 때 실행
	int updateUnreadZero(Map<String, Object> map); // 1일 경우 실행
	int checkChat(ProductChatVO chat); // 채팅방 있는지 확인
	Map<String, Object> getChatRoom(@Param(value = "TO_ID")String TO_ID, @Param(value = "FROM_ID")String FROM_ID, @Param(value = "PD_IDX")int PD_IDX); // 채팅방 번호 가져오기
	Map<String, String> getUserRole(Map<String, Object> map); // 판매자 구매자 확인
	int getMyTradeInfo(Map<String, Object> map); // 거래내역 정보 가져오기
	int getRemoveRoomStatus(ProductChatVO chatMessage); // 채팅방 상태 가져오기
	void removerRoom(ProductChatVO chatMessage); // 대화방 나가기
	void statusTwoRemove(ProductChatVO chatMessage); // 대화방 나가기 status 2로 바꾸기
	Map<String, Object> getUserExitRoom(Map<String, Object> map); // 누가 채팅방을 나갔느지
	
	


}
