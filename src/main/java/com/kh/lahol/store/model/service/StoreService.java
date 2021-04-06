package com.kh.lahol.store.model.service;

import java.util.List;

import com.kh.lahol.store.model.vo.PageInfo;
import com.kh.lahol.store.model.vo.Store;

public interface StoreService {
	//.1 게시글 수 카운드
	public int selectListCount();
	
	//2. 페이징 처리 된 게시글 목록 조회
	public List<Store> selectList(PageInfo pi);
	
	//3.게시글 작성
	public int insertStore(Store s);
	//4. 디테일 뷰
	public Store selectStore(int PR_CODE, boolean falg);
	
	//5. 게시글 수정
	public int updateStore(Store s);
	
	//6. 게시글 삭제
	
	public int deleteStore(int PR_CODE);
	
	
	
}
