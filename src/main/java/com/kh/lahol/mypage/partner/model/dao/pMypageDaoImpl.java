package com.kh.lahol.mypage.partner.model.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.lahol.member.model.vo.Member;
import com.kh.lahol.mypage.common.PageInfo;
import com.kh.lahol.mypage.partner.model.vo.Ad;
import com.kh.lahol.mypage.partner.model.vo.CoffeeClass;
import com.kh.lahol.mypage.partner.model.vo.Payment;
import com.kh.lahol.mypage.partner.model.vo.Search;
import com.kh.lahol.mypage.partner.model.vo.Shipping;
import com.kh.lahol.mypage.partner.model.vo.StoreStats;

@Repository
public class pMypageDaoImpl implements pMypageDao{
	@Autowired
	private SqlSessionTemplate sqlSession;

	@Override
	public Member selectMember(Member m, String query) {
		return sqlSession.selectOne(query, m);
	}

	@Override
	public int deleteMember(String id) {
		return sqlSession.update("mypageMapper.deleteMember", id);
	}

	@Override
	public int updateMember(Member m) {
		return sqlSession.update("mypageMapper.updateMember", m);
	}

	@Override
	public int insertAd(Ad ad) {
		return sqlSession.insert("mypageMapper.insertAd", ad);
	}

	@Override
	public int insertPayment(Payment pay) {
		return sqlSession.insert("mypageMapper.insertPayment", pay);
	}

	@Override
	public int adListCount(String id) {
		return sqlSession.selectOne("mypageMapper.adListCount", id);
	}

	@Override
	public List<Ad> selectAdList(String id, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("mypageMapper.selectAdList", id, rowBounds);
	}

	@Override
	public Ad selectAdByCode(String ad_code) {
		return sqlSession.selectOne("mypageMapper.selectAdByCode", ad_code);
	}

	@Override
	public int updateAd(Ad ad) {
		return sqlSession.update("mypageMapper.updateAd", ad);
	}

	@Override
	public int classListCount(String id) {
		return sqlSession.selectOne("mypageMapper.classListCount", id);
	}

	@Override
	public List<CoffeeClass> selectClassList(String id, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("mypageMapper.selectClassList", id, rowBounds);
	}

	@Override
	public int selectClassMemberCount(List<String> list) {
		return sqlSession.selectOne("mypageMapper.selectClassMemberCount", list);
	}

	@Override
	public List<Member> selectClassMember(List<String> list, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("mypageMapper.selectClassMember", list, rowBounds);
	}

	@Override
	public CoffeeClass selectClassByNo(String class_no) {
		return sqlSession.selectOne("mypageMapper.selectClassByNo", class_no);
	}

	@Override
	public int payStoreListCount(String id) {
		return sqlSession.selectOne("mypageMapper.payStoreListCount", id);
	}

	@Override
	public List<StoreStats> selectPayStoreList(String id, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("mypageMapper.selectPayStoreList", id, rowBounds);
	}

	@Override
	public int selectSumPayStore(List<String> list) {
		return sqlSession.selectOne("mypageMapper.selectSumPayStore", list);
	}

	@Override
	public int searchPayStoreCount(Search search) {
		return sqlSession.selectOne("mypageMapper.searchPayStoreCount", search);
	}

	@Override
	public List<StoreStats> searchPayStoreList(Search search, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("mypageMapper.searchPayStoreList", search, rowBounds);
	}

	@Override
	public int searchSumPayStore(List<Object> list) {
		return sqlSession.selectOne("mypageMapper.searchSumPayStore", list);
	}

	@Override
	public int orderListCount(String id) {
		return sqlSession.selectOne("mypageMapper.orderListCount", id);
	}

	@Override
	public List<Shipping> selectOrderList(String id, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return sqlSession.selectList("mypageMapper.selectOrderList", id, rowBounds);
	}

	@Override
	public int updateShipping(List<String> list) {
		return sqlSession.update("mypageMapper.updateShipping", list);
	}

	@Override
	public Shipping selectShip(Shipping ship) {
		return sqlSession.selectOne("mypageMapper.selectShip", ship);
	}

	@Override
	public int updateDelivery(String subCode) {
		return sqlSession.update("mypageMapper.updateDelivery", subCode);
	}

	@Override
	public List<Ad> selectAdAll() {
		return sqlSession.selectList("mypageMapper.selectAdAll");
	}

}
