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
	private int pageListLimit;
	private int startPage;
	private int endPage;
	
	
	
	public PageInfo() {}
	
	/**
	 * PageInfo 생성자 
	 * @param pageNum : 페이지넘버 , startRow 값 만들기에 사용 (LIMIT #{startRow}, #{listLimit})
	 * @param listLimit : 한 페이지당 보여질 목록의 갯수
	 * @param pageListLimit : 뷰에서 보여질 페이지버튼의 갯수 eX) < 1 2 3 > || < 4 5 6 >
	 */
	public PageInfo(int pageNum, int listLimit, int pageListLimit) {
		this.listLimit = listLimit;
		this.startRow = (pageNum - 1) * listLimit;
		this.pageListLimit = pageListLimit;
	}
	 
	public static Map<String, Object> makePageBtn() {
		System.out.println("흠");
		Map<String, Object> page = new HashMap<String, Object>();
		return page;
	}
}

/*		int listLimit = 3;
		int startRow = (pageNum - 1) * listLimit;
		int pageListLimit = 3;
		
		int maxPage = listCount/listLimit + (listCount%listLimit > 0 ? 1 : 0);
		//시작페이지 설정
		int startPage = (pageNum - 1) / pageListLimit * pageListLimit + 1;
		//끝페이지 설정
		int endPage = startPage + pageListLimit - 1;
				
		if(endPage > maxPage) {
			endPage = maxPage;
		}
 */
