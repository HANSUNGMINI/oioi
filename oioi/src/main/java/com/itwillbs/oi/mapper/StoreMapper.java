package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

@Mapper
public interface StoreMapper {

	// 상품 정보 가져오기
	List<Map<String, Object>> selectMyPd(String id);

	// 상품 상태 변경
	int updatePDStatus(@Param("pdId") String pdId,@Param("status") String status);

	// 공통코드에서 상품 판매 코드 가져오기
	List<Map<String, String>> getCommonCode(@Param("codeName") String codeName);

	void VisitCount(@Param("userId") String userId);

	int getVisitCount(@Param("userId") String userId);

	int getSalesCount(@Param("userId") String userId);

	Map<String, Object> getProductById(@Param("idx") int idx);

	int updateImages(@Param("productInfo") Map<String, Object> productInfo,@Param("fileMap") Map<String, String> fileMap);

	int updateProduct(Map<String, Object> productInfo);

	List<Map<String, Object>> selectReviewsByStoreId(String userId);

	int deleteProductById(String pdId);

	void updatePDtime(String pdId);

	List<Map<String, Object>> selectWishList(String userId);


}
