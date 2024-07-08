package com.itwillbs.oi.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestParam;

import com.itwillbs.oi.mapper.AuctionMapper;
import com.itwillbs.oi.mapper.TradeMapper;

@Service
public class TradeService {
	@Autowired
	private TradeMapper mapper;
	
	public List<Map<String, String>> getProductCondition() {
		return mapper.selectProductCondition();
	}

	public List<Map<String, String>> getTradeMethod() {
		return mapper.selectTradeMethod();
	}
	
	public List<Map<String, String>> getProductPriceOffer() {
		return mapper.selectProductPriceOffer();
	}

	public List<Map<String, String>> getProductSafeTrade() {
		return mapper.selectProductSafeTrade();
	}

	public int insertProduct(Map<String, Object> map) {
		 return mapper.insertProduct(map);
	}

	public List<Map<String, String>> getProduct() {
		
		return mapper.selectProduct();
	}

	public Map<String, String> getProductInfo(Map<String, String> map) {
		return mapper.selectProductInfo(map);
	}

	public List<Map<String, String>> getProductStatus() {
		 
		return mapper.getProductStatus();
	}

	public int updateReadCount(String pd_idx) {
		return mapper.updateReadCount(pd_idx);
	}
	
	public List<Map<String, Object>> getFilteredProducts(Map<String, Object> params) {
        return mapper.selectFilteredProducts(params);
	}
//	public List<Map<String, Object>> getFilteredProducts(Map<String, Object> params) {
//		return mapper.selectFilteredProducts(params);
//	}

	public int selectWishList(Map<String, Object> map) {
		return mapper.selectWishList(map);
	}

	public int addWishList(Map<String, Object> map) {
		return mapper.insertWishList(map);
	}

	public int deleteWishList(Map<String, Object> map) {
		return mapper.deleteWishList(map);
	}

	

	
	
//	public List<Map<String, Object>> getFilteredProducts(String cate1, String cate2, String cate3, int startRow, int listLimit) {
//        return mapper.selectFilteredProducts(cate1, cate2, cate3, startRow, listLimit);
//    }
	
//	public List<Map<String, Object>> getFilteredProducts(String cate1, String cate2, String cate3, int startRow, int listLimit) {
//        return mapper.selectFilteredProducts(cate1, cate2, cate3, startRow, listLimit);
//    }
    

	

}
