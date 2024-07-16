package com.itwillbs.oi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.itwillbs.oi.mapper.StoreMapper;

@Service
public class StoreService {
	@Autowired
	private StoreMapper mapper;

	public List<Map<String, Object>> selectMyPd(String id) {
		return mapper.selectMyPd(id);
	}

	// 상품상태 업데이트
	public boolean updatePDStatus(String pdId, String status) {
//		System.out.println("IDX : " + pdId + "status : " + status);
        int result = mapper.updatePDStatus(pdId, status);
        return result > 0;  // 업데이트 성공 시 true 반환
	}

	public List<Map<String, String>> getCommonCode(String codeName) {
		
		return mapper.getCommonCode(codeName);
	}

	// 방문자수 늘리기
	public void VisitCount(String userId) {
		mapper.VisitCount(userId);
	}

	// 방문자수 가져오기
	public int getVisitCount(String userId) {
		return mapper.getVisitCount(userId);
	}

	public int getSalesCount(String userId) {
		return mapper.getSalesCount(userId);
	}

	public Map<String, Object> getProductById(int idx) {
		
		return mapper.getProductById(idx);
	}

    public int updateProduct(Map<String, Object> productInfo, Map<String, String> fileMap) {
        // 이미지를 업데이트하고 그 결과로 IMG_IDX를 반환
    	System.out.println("라ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ " + productInfo );
    	System.out.println("라ㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏㅏ " + fileMap );
    	
        mapper.updateImages(productInfo ,fileMap);
        return mapper.updateProduct(productInfo);
    }

   public List<Map<String, Object>> getReviewsByStoreId(String userId) {
	   
		return mapper.selectReviewsByStoreId(userId);
	}

   public void deleteProductById(String pdId) {
	    int result = mapper.deleteProductById(pdId);
	    if (result == 0) {
	        throw new RuntimeException("Product deletion failed");
	    }
   }

	public void updatePDtime(String pdId) {
		mapper.updatePDtime(pdId);
	}

	public List<Map<String, Object>> getWishListByUserId(String userId) {
		
		return mapper.selectWishList(userId);
	}



}
