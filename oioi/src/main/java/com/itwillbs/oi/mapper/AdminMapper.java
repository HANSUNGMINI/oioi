package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {
	Map<String, Object> selectAdmin(Map<String, String> admin);
	List<Map<String, Object>> selectUserList(Map<String, Object> select);
	List<Map<String, Object>> selectAdminList(Map<String, Object> select);
	int changeActive(Map<String, Object> select);
}
