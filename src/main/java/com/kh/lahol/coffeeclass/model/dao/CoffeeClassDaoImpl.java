package com.kh.lahol.coffeeclass.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.lahol.cafe.bus.model.vo.Cafe;
import com.kh.lahol.coffeeclass.model.vo.ClassQnA;
import com.kh.lahol.coffeeclass.model.vo.ClassRegister;
import com.kh.lahol.coffeeclass.model.vo.ClassSearch;
import com.kh.lahol.coffeeclass.model.vo.CoffeeClass;
import com.kh.lahol.coffeeclass.model.vo.PageInfo;
import com.kh.lahol.coffeeclass.model.vo.Paging;
import com.kh.lahol.common.model.vo.Payment;
import com.kh.lahol.mypage.normal.model.vo.ClassReview;

@Repository
public class CoffeeClassDaoImpl implements CoffeeClassDao{
	@Autowired
	private SqlSessionTemplate sqlSession;

	// 페이징
	@Override
	public int selectListCount() {
		return sqlSession.selectOne("clMapper.selectListCount");
	}

	// 클래스 메인화면 불러오기 
	@Override
	public List<CoffeeClass> selectList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1)* pi.getClassLimit(); // ClassLimit : 한페이지에서 보여질 게시글 갯수
		// RowBounds는 myBatis가 제공하는 메소드 
		// offset : 몇개를 건너 뛸 것인가?
		// 총 몇개를 출력할 것인가? currentPage가 몇 번째냐에 따라 건너뛴 갯수가 정해짐
		RowBounds rowBounds = new RowBounds(offset, pi.getClassLimit());
		
		return sqlSession.selectList("clMapper.selectList", null, rowBounds);
	}

	// 클래스 상세 페이지 접근
	@Override
	public CoffeeClass selectCoffeeClass(String classNo) {
		return sqlSession.selectOne("clMapper.selectClass", classNo);
	}
	
	// 클래스 수정 페이지 불러오기
	@Override
	public int insertClass(CoffeeClass cl) {
		System.out.println("dao : " + cl);
		return sqlSession.insert("clMapper.insertClass", cl);
	}

	// 수정 페이지 접근
	@Override
	public CoffeeClass bringClassInfo(String classNo) {
		return sqlSession.selectOne("clMapper.bringClass", classNo);
	}
	
	// 수정
	@Override
	public int updateClass(CoffeeClass cl) {
		return sqlSession.update("clMapper.updateClass", cl);
	}

	// 삭제
	@Override
	public int deleteClass(CoffeeClass cl) {
		return sqlSession.delete("clMapper.deleteClass", cl);
	}

	// 클래스 신고
	@Override
	public int reportClass(CoffeeClass cl) {
		return sqlSession.insert("clMapper.reportClass", cl);
	}

	// 클래스 댓글 신고
	@Override
	public int reportClComment(CoffeeClass cl) {
		return sqlSession.insert("clMapper.reportClComment", cl);
	}

	// 클래스 수강신청
	@Override
	public int registerClass(List<Object> list) {
		return sqlSession.insert("clMapper.registerClass", list);
	}

	// 검색
	@Override
	public List<ClassSearch> selectClassSearch(ClassSearch search) {
		return sqlSession.selectList("clMapper.searchClass", search);
	}

	// 필터
	@Override
	public List<ClassSearch> selectClassFilter(ClassSearch search) {
		return sqlSession.selectList("clMapper.filterClass", search);
	}

	// 세션 정보 불러오기 
	@Override
	public Cafe selectCafeInfoById(String id) {
		return sqlSession.selectOne("clMapper.selectCafeInfoById", id);
	}

	// 클래스 QnA 불러오기
	@Override
	public List<ClassQnA> selectQnA(ClassQnA classqna) {
		return sqlSession.selectList("clMapper.selectQnA", classqna);
	}
	
	// 클래스 QnA 질문
	@Override
	public int askClass(ClassQnA qna) {
		return sqlSession.insert("clMapper.askClass", qna);
	}

	// 클래스 QnA 답변
	@Override
	public int answerClass(ClassQnA qna) {
		return sqlSession.insert("clMapper.answerClass", qna);
	}

	// 클래스 후기 불러오기
	@Override
	public List<ClassReview> selectReviews(String classNo) {
		return sqlSession.selectList("clMapper.selectReviews", classNo);
	}

	@Override
	public int registerClOrder(String clPayNo) {
		return sqlSession.insert("clMapper.registerClOrder", clPayNo);
	}

	@Override
	public int registerClPay() {
		return sqlSession.insert("clMapper.registerClPay");
	}
	
	// 검색 리스트 카운트
	


}
