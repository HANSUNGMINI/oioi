package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TradeMapper {

	List<Map<String, String>> getProductCondition();

	List<Map<String, String>> getTradeMethod();

	int insertProduct(Map<String, Object> map);

	List<Map<String, String>> selectProduct();

	



	

}
