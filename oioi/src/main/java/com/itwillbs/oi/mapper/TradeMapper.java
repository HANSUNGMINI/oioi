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

	List<Map<String, Object>> selectFilteredProducts(
			@RequestParam Map<String, String> map);

	List<Map<String, String>> selectProductPriceOffer();

	List<Map<String, String>> selectProductSafeTrade();
}
		



	


