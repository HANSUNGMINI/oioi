package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

import com.itwillbs.oi.vo.ProductChatVO;

@Mapper
public interface ChattingMapper {

	// -------- 공통코드 가져오기 --------------
	List<Map<String, String>> selectReportCategory(); // 신고 카테고리 가져오기
	List<Map<String, String>> selectReviewCategory(); // 리뷰 카테고리 가져오기
	// ------------------------------------------
	
	// ----------- 정보 가져오기 ----------------
	Map<String, String> getProductInfo(Map<String, String> map); // 채팅 시 필요한 상품 정보
	Map<String, String> getMyInfo(Map<String, String> map); // 채팅 시 내 정보 가져오기
	Map<String, String> getOtherInfo(Map<String, String> map); // 채팅 시 필요한 상대방 정보 가져오기
	// -------------------------------------------
	
	// ----------- 정보 처리하기 ----------------
	int insertReport(Map<String, String> map); // 신고 처리
	int insertReview(Map<String, String> map); // 리뷰 처리
	int selectReview(Map<String, String> map); // 리뷰 쓴 물건인지 확인
	// -------------------------------------------

	// ----------- 채팅 ----------------
	int createRoom(ProductChatVO chat); // 채팅룸 만들기
	Map<String, String> checkChatRoom(Map<String, String> map); // 채팅룸이 있는지 확인
	int saveChatting(Map<String, Object> map); // 채팅 대화 저장
	List<Map<String, Object>> getMyChatInfo(Map map); // 채팅 목록 가져오기
	Map<String, Object> getMyChatList(int crId); // 마지막 채팅 가져오기


}
