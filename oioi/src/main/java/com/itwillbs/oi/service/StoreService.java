package com.itwillbs.oi.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.itwillbs.oi.mapper.StoreMapper;

@Service
public class StoreService {
	@Autowired
	private StoreMapper mapper;

	public List<Map<String, Object>> selectMyPd(String id) {
		return mapper.selectMyPd(id);
	}
	
    public PageInfo<Map<String, Object>> pageMyPd(String id, int pageNum, int pageSize) {
        PageHelper.startPage(pageNum, pageSize);
        List<Map<String, Object>> myPD = mapper.pageMyPd(id);
        return new PageInfo<>(myPD);
    }

	public void updatePdStatus(int pdId, String newStatus) {
		mapper.updatePdStatus(pdId, newStatus);
	}
}
