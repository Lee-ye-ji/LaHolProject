package com.kh.lahol.mypage.normal.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.lahol.member.model.vo.Member;
import com.kh.lahol.mypage.common.PageInfo;
import com.kh.lahol.mypage.normal.model.vo.CafeDetail;
import com.kh.lahol.mypage.normal.model.vo.CafeReview;
import com.kh.lahol.mypage.normal.model.vo.ClassDetail;
import com.kh.lahol.mypage.normal.model.vo.ClassReview;
import com.kh.lahol.mypage.normal.model.vo.Coupon;
import com.kh.lahol.mypage.normal.model.vo.PayList;
import com.kh.lahol.mypage.normal.model.vo.StoreDetail;
import com.kh.lahol.mypage.normal.model.vo.StoreReview;
import com.kh.lahol.mypage.partner.model.vo.Search;

@Repository
public class nMypageDaoImpl implements nMypageDao{
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public int updateMember(Member m) {
		return sqlSession.update("mypageMapper.updateMember", m);
	}

	@Override
	public Member selectMember(Member m, String query) {
		return sqlSession.selectOne(query, m);
	}

	@Override
	public int deleteMember(String id) {
		return sqlSession.update("mypageMapper.deleteMember", id);
	}

	@Override
	public int selectCouponCount(String id) {
		return sqlSession.selectOne("mypageMapper.selectCouponCount", id);
	}

	@Override
	public List<Coupon> selectCouponList(String id, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("mypageMapper.selectCouponList", id, rowBounds);
	}

	@Override
	public int selectPayListCount(String id) {
		return sqlSession.selectOne("mypageMapper.selectPayListCount", id);
	}

	@Override
	public List<PayList> selectPayList(String id, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("mypageMapper.selectPayList", id, rowBounds);
	}

	@Override
	public int searchPaymentCount(Search search) {
		return sqlSession.selectOne("mypageMapper.searchPaymentCount", search);
	}

	@Override
	public List<PayList> searchPaymentList(Search search, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("mypageMapper.searchPaymentList", search, rowBounds);
	}

	@Override
	public ClassDetail selectClass(String pay_no) {
		return sqlSession.selectOne("mypageMapper.selectClass", pay_no);
	}

	@Override
	public StoreDetail selectStore(String pay_no) {
		return sqlSession.selectOne("mypageMapper.selectStore", pay_no);
	}

	@Override
	public List<CafeDetail> selectCafe(String pay_no) {
		return sqlSession.selectList("mypageMapper.selectCafe", pay_no);
	}

	@Override
	public int insertStoreReview(StoreReview storeReview) {
		return sqlSession.insert("mypageMapper.insertStoreReview", storeReview);
	}

	@Override
	public int insertClassReview(ClassReview classReview) {
		return sqlSession.insert("mypageMapper.insertClassReview", classReview);
	}

	@Override
	public int insertCafeReview(CafeReview cafeReview) {
		return sqlSession.insert("mypageMapper.insertCafeReview", cafeReview);
	}

	@Override
	public int chkStoreReview(StoreReview storeReview) {
		return sqlSession.selectOne("mypageMapper.chkStoreReview", storeReview);
	}

	@Override
	public int chkClassReview(ClassReview classReview) {
		return sqlSession.selectOne("mypageMapper.chkClassReview", classReview);
	}

	@Override
	public int chkCafeReview(CafeReview cafeReview) {
		return sqlSession.selectOne("mypageMapper.chkCafeReview", cafeReview);
	}

}
