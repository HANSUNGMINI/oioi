package com.itwillbs.oi.mapper;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface AdminMapper {
	Map<String, Object> selectAdmin(Map<String, String> admin);
}
