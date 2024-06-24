package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.bind.annotation.RequestParam;

@Mapper
public interface StoreMapper {

	List<Map<String, Object>> selectMyPd(String id);

	void updatePdStatus(int pdId, String newStatus);

}
