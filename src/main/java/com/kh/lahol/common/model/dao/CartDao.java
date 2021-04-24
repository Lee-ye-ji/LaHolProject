package com.kh.lahol.common.model.dao;

import java.util.List;

import com.kh.lahol.common.model.vo.Cart;
import com.kh.lahol.common.model.vo.Coupon;
import com.kh.lahol.common.model.vo.Payment;

public interface CartDao {

	int cafeCartInsert(Cart cart);

	List<Cart> cartSelectList(String id);

	List<Coupon> couponSelectList(String id);

	int cafeCartPayment(Payment pay);

	int couponUse(Coupon cop);

}
