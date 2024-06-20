package com.itwillbs.oi.handler;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import lombok.Data;


@Component
@Data
public class PageInfo {
	private int pageNum;
	private int startRow;
	private int listLimit;
	
	public PageInfo() {}
	
	/**
	 * PageInfo 생성자 
	 * @param pageNum : 페이지넘버 , startRow 값 만들기에 사용 (LIMIT #{startRow}, #{listLimit})
	 */
	public static Map<String, Integer> limitPagination(int pageNum) {
		// 한 페이지당 보여질 목록의 갯수
		int listLimit = 10;
		int startRow = (pageNum - 1) * listLimit;
		
		Map<String, Integer> page = new HashMap<String, Integer>();
		page.put("listLimit", listLimit);
		page.put("startRow", startRow);
		page.put("pageNum", pageNum);
		return page;
	};
	
	public static Map<String, Object> makePagination(Map<String, Integer> pagination , int listCount) {
		int pageNum = pagination.get("pageNum");
		int listLimit = pagination.get("listLimit");
		
		// 한 사이클 당 보여질 페이지버튼의 갯수
		int pageListLimit = 10;
		
		int maxPage = listCount/listLimit + (listCount%listLimit > 0 ? 1 : 0);
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		int endPage = startPage + pageListLimit - 1;
				
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		
		Map<String, Object> page = new HashMap<String, Object>();
		page.put("startPage", startPage);
		page.put("endPage", endPage);
		page.put("pageNum", pageNum);
		return page;
	};
}

