package com.kh.lahol.common.controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.lahol.common.model.vo.Cart;
import com.google.gson.Gson;
import com.kh.lahol.coffeeclass.model.service.CoffeeClassSerivce;
import com.kh.lahol.common.model.exception.CartException;
import com.kh.lahol.common.model.service.CartService;
import com.kh.lahol.common.model.vo.Coupon;
import com.kh.lahol.common.model.vo.Payment;
import com.kh.lahol.member.model.vo.Member;
import com.kh.lahol.store.model.service.StoreService;
import com.kh.lahol.store.model.vo.Pr_pay_w;
import com.kh.lahol.store.model.vo.Prpay;
import com.kh.lahol.store.model.vo.Sh_status;



@Controller
@RequestMapping("/cart")
@SessionAttributes({"loginUser"})
public class CartController{
	
	@Autowired 
	private CartService cartService;
	
	@Autowired
	private StoreService sService;
	
	@Autowired
	private CoffeeClassSerivce clService;
	
	
	private static final Logger logger = LoggerFactory.getLogger(BusMainController.class);

	
	// ???????????? ???????????? ??? ????????? select
	@GetMapping("/main")
	public ModelAndView cartSelectList(@SessionAttribute("loginUser") Member m,
			ModelAndView mv,
		    @RequestParam(value="page" , required=false, defaultValue="1")int currentPage) {
		
		String id = m.getId();
		// System.out.println(id);
		List<Cart> cartlist = cartService.cartSelectList(id);
		// System.out.println(cartlist);
		int cartNum = cartService.cartNum(id);
		
		
		
		mv.addObject("cartlist", cartlist);
		mv.addObject("cartNum", cartNum);
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
			throw new CartException("??????????????? ??? ?????? ?????? ?????????????????????.");
		}
		
	}


	@PostMapping("/storecart")
	public String storeCartInsert(@ModelAttribute Cart ct,@ModelAttribute Pr_pay_w py,String price,
			String p_num1  ,String pr_code,String name, HttpSession session) throws CartException {
		
		System.out.println(price);
		System.out.println(name);
		System.out.println(pr_code);
		System.out.println("??????");
		System.out.println(p_num1);
		Member loginUser = (Member)session.getAttribute("loginUser");
		 
		String id = loginUser.getId();
		
		int pr =  Integer.parseInt(price);
		int su = Integer.parseInt(p_num1);
	 
		 
		System.out.println("????????????"+pr);
		 
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
			 return "redirect:/cart/main";
		 
		 }else { throw new
			 CartException("??????????????? ??? ?????? ?????? ?????????????????????."); }
	
		
	}
	
	
	
	@GetMapping("/coupon")
	public ModelAndView couponSelectList(@SessionAttribute("loginUser") Member m,
			ModelAndView mv) {
		
		String id = m.getId();
		// System.out.println("?????? ?????????" + id);

		List<Coupon> couponlist = cartService.couponSelectList(id);
		//System.out.println(couponlist);
		
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
	
	// ?????? ?????? ?????? payment
	@PostMapping("/cafe/payment")
	public String cafeCartPayment(@ModelAttribute Payment pay,
				@SessionAttribute("loginUser") Member m) throws CartException{
		
		
		   String id = m.getId(); 
		   pay.setBuyId(id);
		   System.out.println(pay);
		   
		 
		   
		   
		   
		   int result = cartService.cafeCartPayment(pay);
		  
		  if(result > 0) { 
			  return "cart/cart"; 
		  }else { 
			  throw new CartException("?????? ???????????? ??? ?????? ?????? ?????????????????????."); 
		  }
		
	}
	
	// ???????????? ??????
	@PostMapping("/payment")
	public String CartPayment(@ModelAttribute Payment pay,  String purchaseNo, String cres, String classNo,@ModelAttribute Prpay pa  ,  @ModelAttribute Sh_status st,String psu,String ptotal,
				@SessionAttribute("loginUser") Member m) throws CartException{
		
		 
			/*
			 * String id = m.getId(); pay.setBuyId(id);
			 */
		  
		  System.out.println("?????? ??????????????????");
		  
		  
		   if(purchaseNo != null) {
			 int su = Integer.parseInt(psu);
			 int tot = Integer.parseInt(ptotal);
			 
			System.out.println("??????"+psu);
			int total = su*tot;   
			String to = Integer.toString(total);
			
		   System.out.println("?????????"+to);
		   
		   System.out.println("???????????? " +purchaseNo);
		   pay.setPayItem(purchaseNo);
		   pay.setPayPrice(purchaseNo);
		   pay.setPayTotal(ptotal);
		   pay.setBuyId(purchaseNo); 
		
		   pay.setPurchaseNumber(purchaseNo);
		   
		   int result = cartService.CartPayment(pay);  
		   //????????????
		   int result2 = sService.prpay2(pa); 
		   //????????????
		   int result3 = sService.sh(st); 	
		   
		   int result4 = cartService.deleteCart1(purchaseNo); 
		    
		  	}
		  	
			if(cres != null) {
				   pay.setPayPrice(cres);
				   pay.setPayTotal(cres);
				   pay.setBuyId(cres);
				   pay.setPayItem(cres);
				   pay.setCafeRes(cres);  
				   int result2 = cartService.CartPayment2(pay);
				   int result3 = cartService.deleteCart2(cres); 
				   
			}
			
			if(classNo != null) {
				System.out.println("???????????????"+classNo);
				int clOrder = cartService.insertClOrder(classNo);
				if(clOrder > 0) {
					pay.setPayPrice(classNo);
					pay.setPayTotal(classNo);
					pay.setBuyId(classNo);
					pay.setPayItem(classNo);
					pay.setClPayNo(classNo);
					int result3 = cartService.CartPayment3(pay);
					 int result = cartService.deleteCart3(classNo); 
				} 
				   
			}
			
			  return ""; 
			
		   
	}
	
	//?????? ?????? update
	@PostMapping("/coupon/use")
	public String couponUse(@ModelAttribute Coupon cop, 
				@SessionAttribute("loginUser") Member m, String couponCode) throws CartException{
		
		   String id = m.getId();
		   if(!couponCode.equals("")) {
			   cop.setId(id);
			   cop.setCouponCode(couponCode);
			   
			   System.out.println("?????? ?????? "+ cop);
			   System.out.println(couponCode);
			   int result = cartService.couponUse(cop);
			   
			   if(result > 0) { 
				   return "cart/cart"; 
			   }else { 
				   throw new CartException("?????? ????????? ?????????????????????."); 
			   }
		   }
		   
		   return "cart/cart";
		
	}
	 
	@GetMapping("/cart/delete")
	public String cartdelete(  @ModelAttribute Cart bc, String sT,
				@SessionAttribute("loginUser") Member m, String couponCode) throws CartException{
		
		 
		
		    //System.out.println("????????????"+sT);
		    
		    
		     int result = cartService.deleteCart(sT); 
		     //System.out.println(result);
		     
		     
		   
				
		     return "redirect:/cart/main?page=1";
		   
		   
	}
	
	// ???????????? ?????? ?????????
	@PostMapping("/cafe/cartPayment")
	public String cartPayment(@ModelAttribute Payment p, double discountTwo, double payPrice){

	
		System.out.println(payPrice);
		double discount = (double)discountTwo;
		System.out.println(discount);

		double dc = (double)payPrice*(discount/100);
		System.out.println(dc);
		
		
		
		System.out.println("?????? ???????????? : "+ p);
		System.out.println("???????????? ????????? ?????? : "+ discountTwo);
		
		
		return null;	
	}
	

	
	// ????????? ???????????? insert
	@PostMapping("/cartclass")
	public String classCart(@ModelAttribute Cart ct, @ModelAttribute Member member, HttpSession session,
							RedirectAttributes rttr, HttpServletRequest request) throws CartException {
		
		
		Member loginUser = (Member)request.getSession().getAttribute("loginUser");
		  
		 if(loginUser == null) {
			 rttr.addFlashAttribute("msg", "??????????????? ?????????????????? ?????????????????????");
			 return "redirect:/member/loginView";
		 }
		
		
		int result = cartService.classcartInsert(ct);
		
		if(result > 0) {
			return  "redirect:/cart/main";
		} else {
			return "alert('???????????? ????????? ??????????????????.')";
		}

	}
	
	
	
	
	// ?????? ?????? ??? ???????????? ?????????
	@GetMapping("/success")
	public String successCart(@SessionAttribute("loginUser") Member m) throws CartException{
		
		   System.out.println("??????????????????");
		String id = m.getId(); 
		   int result = cartService.successCart(id);
		  
		  if(result > 0) { 
			  return "redirect:/"; 
		  }else { 
			  throw new CartException("???????????? ???????????? ?????????????????????."); 
		  }
		
	}
	
	
}
