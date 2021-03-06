package com.kh.lahol.common.model.dao;

import java.util.List;

import com.kh.lahol.common.model.vo.Cart;
import com.kh.lahol.common.model.vo.Coupon;
import com.kh.lahol.common.model.vo.Payment;

public interface CartDao {

	int cafeCartInsert(Cart cart);

	List<Cart> cartSelectList(String id);

	List<Coupon> couponSelectList(String id);


	int storeCartInsert(Cart ct);

	int cafeCartPayment(Payment pay);

	int couponUse(Coupon cop);

	int CartPayment(Payment pay);
	
	int CartPayment2(Payment pay);

	

	int cartNum(String id);

	// 클래스 장바구니
	int classcartInsert(Cart ct);

	int deleteCart(String sT);

	int insertClOrder(String classNo);

	
	int CartPayment3(Payment pay);

	

	int successCart(String id);

	
	int deleteCart1(String purchaseNo);

	int deleteCart2(String cres);

	int deleteCart3(String classNo);


}
