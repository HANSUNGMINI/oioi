package com.itwillbs.oi.service;

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
		System.out.println("트레이드 서비스 옴(상품 상태)");
		return mapper.getProductCondition();
	}

	public List<Map<String, String>> getTradeMethod() {
		System.out.println("트레이드 서비스 옴(상품 거래방법)");
		return mapper.getTradeMethod();
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
	
	public List<Map<String, Object>> getFilteredProducts(@RequestParam Map<String, String> map) {
        return mapper.selectFilteredProducts(map);
    }

}
