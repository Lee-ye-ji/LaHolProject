package com.kh.lahol.mypage.normal.model.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.lahol.member.model.vo.Member;
import com.kh.lahol.mypage.common.PageInfo;
import com.kh.lahol.mypage.normal.model.dao.nMypageDao;
import com.kh.lahol.mypage.normal.model.vo.CafeDetail;
import com.kh.lahol.mypage.normal.model.vo.CafeReview;
import com.kh.lahol.mypage.normal.model.vo.ClassDetail;
import com.kh.lahol.mypage.normal.model.vo.ClassReview;
import com.kh.lahol.mypage.normal.model.vo.Coupon;
import com.kh.lahol.mypage.normal.model.vo.PayList;
import com.kh.lahol.mypage.normal.model.vo.StoreDetail;
import com.kh.lahol.mypage.normal.model.vo.StoreReview;
import com.kh.lahol.mypage.partner.model.vo.Search;

@Service
public class nMypageServiceImpl implements nMypageService{
	@Autowired
	private nMypageDao nDao;

	@Override
	public int updateMember(Member m) {
		return nDao.updateMember(m);
	}

	@Override
	public Member selectMember(Member m) {
		String query = "";
		
		if(m.getGrade().equals("N")) {
			query = "mypageMapper.selectNormalMember";
		} else if(m.getGrade().equals("P")) {
			query = "mypageMapper.selectPartnerMember";
		} else {
			query = "mypageMapper.selectMemberById";
		}
			
		return nDao.selectMember(m, query);
	}

	@Override
	public int deleteMember(String id) {
		return nDao.deleteMember(id);
	}

	@Override
	public int selectCouponCount(String id) {
		return nDao.selectCouponCount(id);
	}

	@Override
	public List<Coupon> selectCouponList(String id, PageInfo pi) {
		return nDao.selectCouponList(id, pi);
	}

	@Override
	public int selectPayListCount(String id) {
		return nDao.selectPayListCount(id);
	}

	@Override
	public List<PayList> selectPayList(String id, PageInfo pi) {
		return nDao.selectPayList(id, pi);
	}

	@Override
	public int searchPaymentCount(Search search) {
		return nDao.searchPaymentCount(search);
	}

	@Override
	public List<PayList> searchPaymentList(Search search, PageInfo pi) {
		return nDao.searchPaymentList(search, pi);
	}

	@Override
	public ClassDetail selectClass(String pay_no) {
		return nDao.selectClass(pay_no);
	}

	@Override
	public StoreDetail selectStore(String pay_no) {
		return nDao.selectStore(pay_no);
	}

	@Override
	public List<CafeDetail> selectCafe(String pay_no) {
		return nDao.selectCafe(pay_no);
	}

	@Override
	public int insertStoreReview(StoreReview storeReview) {
		return nDao.insertStoreReview(storeReview);
	}

	@Override
	public int insertClassReview(ClassReview classReview) {
		return nDao.insertClassReview(classReview);
	}

	@Override
	public int insertCafeReview(CafeReview cafeReview) {
		return nDao.insertCafeReview(cafeReview);
	}

	@Override
	public int chkStoreReview(StoreReview storeReview) {
		return nDao.chkStoreReview(storeReview);
	}

	@Override
	public int chkClassReview(ClassReview classReview) {
		return nDao.chkClassReview(classReview);
	}

	@Override
	public int chkCafeReview(CafeReview cafeReview) {
		return nDao.chkCafeReview(cafeReview);
	}

}
