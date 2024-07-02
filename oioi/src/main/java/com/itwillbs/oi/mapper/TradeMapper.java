package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.springframework.web.bind.annotation.RequestParam;

@Mapper
public interface TradeMapper {

	List<Map<String, String>> selectProductCondition();

	List<Map<String, String>> selectTradeMethod();

	int insertProduct(Map<String, Object> map);

	List<Map<String, String>> selectProduct();

	Map<String, String> selectProductInfo(Map<String, String> map);

	List<Map<String, String>> getProductStatus();

	int updateReadCount(String pd_idx);

	List<Map<String, String>> selectProductPriceOffer();

	List<Map<String, String>> selectProductSafeTrade();
	
	 List<Map<String, Object>> selectFilteredProducts(@Param("params") Map<String, Object> params);

	Map<String, Object> selectTradePDInfo(int PD_IDX);
	 
//	 List<Map<String, Object>> selectFilteredProducts(@Param("params") Map<String, Object> params);
	
//	List<Map<String, Object>> selectFilteredProducts(
//	        @Param("cate1") String cate1,
//	        @Param("cate2") String cate2,
//	        @Param("cate3") String cate3,
//	        @Param("startRow") int startRow,
//	        @Param("listLimit") int listLimit);
	
//	List<Map<String, Object>> selectFilteredProducts(@Param("cate1") String cate1, @Param("cate2") String cate2, @Param("cate3") String cate3, @Param("startRow") int startRow, @Param("listLimit") int listLimit);
	  
}
		



	


