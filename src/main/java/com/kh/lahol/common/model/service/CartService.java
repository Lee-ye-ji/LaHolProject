package com.kh.lahol.common.model.service;

import java.util.List;

import com.kh.lahol.common.model.vo.Cart;
import com.kh.lahol.common.model.vo.Coupon;
import com.kh.lahol.common.model.vo.Payment;

public interface CartService {

	// 장바구니에 카페 정보 insert
	int cafeCartInsert(Cart cart);

	List<Cart> cartSelectList(String id);

	List<Coupon> couponSelectList(String id);

	int cafeCartPayment(Payment pay);

	int couponUse(Coupon cop);

	int CartPayment(Payment pay);

	int successCart(String id);

}
