package com.itwillbs.oi.handler;

import java.util.HashMap;
import java.util.Map;

import org.springframework.stereotype.Component;

import lombok.Data;

@Component
@Data
public class PageInfo {
	
	private static int startRow; // 시작 번호
	private static int pageNum; // 페이지 번호
	private static int listLimit;
	
	private static int listCount; // 총 게시물 수
	private static int pageListLimit; // 페이지 당 표시할 페이지 번호 개수 
	private static int maxPage; 
	private static int startPage;
	private static int endPage;
	
	// 기본생성자
	public PageInfo() {}
	
	public PageInfo(int pageNum, int listLimit) {
		this.pageNum = pageNum;
		this.listLimit = listLimit;
		this.startRow = (pageNum - 1) * listLimit;
	}
	
	public static void makePageInfo(PageInfo pageinfo , int listCount, int pageListLimit) {
		Map<String, Integer> paging = new HashMap<String, Integer>();
		
		paging.put("pageNum", pageinfo.pageNum);
		paging.put("pageNum", pageinfo.listLimit);
		
		
		int maxPage = listCount/pageinfo.listLimit + (listCount%pageinfo.listLimit > 0 ? 1 : 0);
		paging.put("maxPage", maxPage);
		//----------------------------------------------------------------
		//시작페이지 설정
		int startPage = (pageinfo.pageNum - 1) / pageListLimit * pageListLimit + 1;
		paging.put("startPage", startPage);
		//끝페이지 설정
		int endPage = startPage + pageListLimit - 1;
		
		if(endPage > maxPage) {
			endPage = maxPage;
		}
		paging.put("endPage", endPage);
		
		System.out.println(paging);
	}
	
}


