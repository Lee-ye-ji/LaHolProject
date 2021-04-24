package com.kh.lahol.common.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.servlet.ModelAndView;

import com.kh.lahol.common.model.vo.Cart;
import com.google.gson.Gson;
import com.kh.lahol.common.model.exception.CartException;
import com.kh.lahol.common.model.service.CartService;
import com.kh.lahol.common.model.vo.Coupon;
import com.kh.lahol.common.model.vo.Payment;
import com.kh.lahol.member.model.vo.Member;
import com.kh.lahol.store.model.service.StoreService;
import com.kh.lahol.store.model.vo.Pr_pay_w;



@Controller
@RequestMapping("/cart")
@SessionAttributes({"loginUser"})
public class CartController{
	
	@Autowired 
	private CartService cartService;
	
	@Autowired
	private StoreService sService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(BusMainController.class);

	
	// 장바구니 들어갔을 시 정보들 select
	@GetMapping("/main")
	public ModelAndView cartSelectList(@SessionAttribute("loginUser") Member m,
			ModelAndView mv) {
		
		String id = m.getId();
		System.out.println(id);
		List<Cart> cartlist = cartService.cartSelectList(id);
		System.out.println(cartlist);
		
		mv.addObject("cartlist", cartlist);
		mv.setViewName("cart/cart");
		
		
		return mv;
	}
	
	@PostMapping("/cafe/insert")
	public String cafeCartInsert(@ModelAttribute Cart bc, String total) throws CartException {
		
		int price =  Integer.parseInt(total);
		bc.setCartPrice(price);
		System.out.println("controller : "+ bc);
		
		int result = cartService.cafeCartInsert(bc);
		
		if(result > 0) {
			return "cart/cart";
		}else {
			throw new CartException("장바구니에 값 넣는 것을 실패하였습니다.");
		}
		
	}
	
	@PostMapping("/storecart")
	public String storeCartInsert(@ModelAttribute Cart ct,@ModelAttribute Pr_pay_w py,String price,
			String p_num1  ,String pr_code,String name, HttpSession session) throws CartException {
		
		
	

		Member loginUser = (Member)session.getAttribute("loginUser");
		 
		String id = loginUser.getId();
		
		int pr =  Integer.parseInt(price);
		int su = Integer.parseInt(p_num1);
	 
		 
		System.out.println("제품가격"+pr);
		 
		py.setPr_code(pr_code);
		py.setPr_count(su);
		
		int result = sService.storepayInsert(py);
		 
	 
		 
		int de = 2500;
		
		ct.setCartName(name);
		ct.setShipFee(de);
		ct.setCartCount(su);
		ct.setCartPrice(pr);
		ct.setUserId(id);
		int result2 = cartService.storeCartInsert(ct);
		
		
		 if(result2 > 0) {
			 return "redirect:/store/storedetail?&k=0&PR_CODE="+pr_code;
		 
		 }else { throw new
			 CartException("장바구니에 값 넣는 것을 실패하였습니다."); }
	
		
	}
	
	
	
	@GetMapping("/coupon")
	public ModelAndView couponSelectList(@SessionAttribute("loginUser") Member m,
			ModelAndView mv) {
		
		String id = m.getId();
		// System.out.println("쿠폰 아이디" + id);

		List<Coupon> couponlist = cartService.couponSelectList(id);
		System.out.println(couponlist);
		
		mv.addObject("couponlist", couponlist);
		mv.setViewName("cart/coupon");
		
		
		return mv;
	}
	
	@PostMapping("/couponResult")
	public String coponResult(String couponValue, HttpServletResponse response) {
		response.setContentType("application/json; charset=utf-8");
		
		PrintWriter out;
		try {
			out = response.getWriter();
			out.print(new Gson().toJson(couponValue));
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		
		return "cart/couponTotal";
	}
	
	
	@PostMapping("/cafe/payment")
	public String cafeCartPayment(@ModelAttribute Payment pay, 
				@SessionAttribute("loginUser") Member m) throws CartException{
		
		/*
		 * String id = m.getId(); pay.setBuyId(id);
		 * 
		 * int result = cartService.cafeCartPayment(pay);
		 * 
		 * if(result > 0) { return "cart/cart"; }else { throw new
		 * CartException("결제 테이블에 값 넣는 것을 실패하였습니다."); }
		 */
		
		System.out.println(pay);
		return null;
		
		
		
	}
}
