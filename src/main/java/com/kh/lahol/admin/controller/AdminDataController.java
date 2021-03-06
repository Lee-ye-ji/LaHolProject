package com.kh.lahol.admin.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.kh.lahol.admin.model.service.AdminService;
import com.kh.lahol.admin.model.vo.CafeList;
import com.kh.lahol.admin.model.vo.Profit;
import com.kh.lahol.admin.model.vo.Promotion;
import com.kh.lahol.admin.model.vo.Report_N;
import com.kh.lahol.admin.model.vo.Report_P;
import com.kh.lahol.member.model.vo.Coupon;
import com.kh.lahol.member.model.vo.Member;

@RestController
public class AdminDataController {
	@Autowired
	private AdminService adminService;
	
	// 일반회원 리스트 조회
	@GetMapping("/admin/user/test") 
	public List<Member> selectNormalList(){
		return adminService.selectNormalList();
	}
	
	// 사업자회원 리스트 조회
	@GetMapping("/admin/partner/test")
	public List<Member> selectPartnerList(){
		return adminService.selectPartnerList(); 
	}
	
	// 쿠폰 날짜 별 조회
	@GetMapping("/admin/coupon/{date}")
	public List<Coupon> selectCouponByDate(@PathVariable String date) {
		return adminService.selectCouponByDate(date);
	}
	
	// 광고 승인대기 리스트 조회
	@GetMapping("/admin/promo/waiting")
	public List<Promotion> selectAdWaitingList(){
		return adminService.selectAdWaitingList();
	}
	
	// 광고 승인완료 리스트 조회
	@GetMapping("/admin/promo/confirmed")
	public List<Promotion> selectAdConfirmedList(){
		return adminService.selectAdConfirmedList();
	}
		
	// 카페리스트 날짜 별 조회
	@GetMapping("/admin/cafe/cafeList/{date}")
	public List<CafeList> selectCafeList(@PathVariable String date) {
		return adminService.selectCafeList(date);
	}
	
	// 파트너회원 신고처리 대기리스트 조회
	@GetMapping("/admin/report/partnerList/waiting")
	public List<Report_P> selectReportedPartnerList(){
		return adminService.selectReportedPartnerList();
	}
	
	// 파트너회원 신고처리 완료리스트 조회
	@GetMapping("/admin/report/partnerList/completed")
	public List<Report_P> selectCompletedPartnerList(){
		return adminService.selectCompletedPartnerList();
	}
	
	// 일반회원 신고처리 대기리스트 조회
	@GetMapping("/admin/report/normalList/waiting")
	public List<Report_N> selectReportedUserList(){
		return adminService.selectReportedUserList(); 
	}
	
	// 일반회원 신고처리 완료리스트 조회
	@GetMapping("/admin/report/normalList/completed")
	public List<Report_N> selectCompletedUserList() {
		return adminService.selectCompletedUserList();
	}
	
	// 수익 날짜 별 조회
	@GetMapping("/admin/profit/{date}")
	public Map<String, Object> selectProfitByDate(@PathVariable String date) {
		Map<String, Object> map = new HashMap<>();
		List<Profit> list = adminService.selectProfitByDate(date);
		map.put("list", list);
		
		switch(date) {
		  case "day":
		    break;
		  case "week":
			  String mon = adminService.selectWeeklySales(2);
			  String wed = adminService.selectWeeklySales(4);
			  String fri = adminService.selectWeeklySales(6);
			  String sun = adminService.selectWeeklySales(1);
			  map.put("mon", mon);
			  map.put("wed", wed);
			  map.put("fri", fri);
			  map.put("sun", sun);
		    break;
		  case "month":
			  String firstDay = adminService.selectMonthlySales("1");
			  String midDay = adminService.selectMonthlySales("3");
			  String lastDay = adminService.selectMonthlySales("5");  
			  //System.out.println(firstDay + " " + midDay +" " + lastDay);
			  map.put("firstDay", firstDay);
			  map.put("midDay", midDay);
			  map.put("lastDay", lastDay);
			  break;
		  case "year":
			  String jan = adminService.selectYearlySales("");
			  String apr = adminService.selectYearlySales("3");
			  String jul = adminService.selectYearlySales("6");
			  String oct = adminService.selectYearlySales("9");
			  String dec = adminService.selectYearlySales("11");
			  //System.out.println(jan + " " + mar + " " + jun + " " + sep + " " + dec);
			  map.put("jan", jan);
			  map.put("apr", apr);
			  map.put("jul", jul);
			  map.put("oct", oct);
			  map.put("dec", dec);
			break;
		}
		
		return map;
		
	}
}
