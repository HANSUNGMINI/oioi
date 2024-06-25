package com.itwillbs.oi.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface ChattingMapper {

	List<Map<String, String>> selectReportCategory(); // 신고 카테고리 가져오기

}
