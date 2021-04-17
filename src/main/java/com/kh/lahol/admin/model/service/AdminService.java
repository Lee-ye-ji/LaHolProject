package com.kh.lahol.admin.model.service;

import java.sql.Date;
import java.util.List;
import java.util.Map;

import com.kh.lahol.member.model.vo.Coupon;
import com.kh.lahol.member.model.vo.Member;

public interface AdminService {

	List<Member> selectNormalList();
	
	List<Member> selectPartnerList();
	
	List<Coupon> selectCouponByDate(String date);
	
	List<Coupon> selectCouponByTerm(Map<String, Object> dates);
}
