package com.kh.lahol.mypage.partner.controller;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.kh.lahol.member.model.vo.Member;
import com.kh.lahol.mypage.partner.model.service.pMypageService;
import com.kh.lahol.mypage.partner.model.vo.Ad;

@Controller
@RequestMapping("/pMypage")
@SessionAttributes({"loginUser"})
public class pMypageController {
	@Autowired
	private pMypageService pService;
	
	@Autowired
	private BCryptPasswordEncoder bcryptPasswordEncoder;
	
	@GetMapping("/homeView")
	public String homeView() {
		return "mypage/partner/p-mypage";
	}
	
	@GetMapping("/updateView")
	public String updateView() {
		return "mypage/partner/updateMember";
	}
	
	@GetMapping("/classView")
	public String classView() {
		return "mypage/partner/classList";
	}
	
	@GetMapping("/deleteView")
	public String deleteView() {
		return "mypage/partner/deleteMember";
	}
	
	@GetMapping("/storeView")
	public String storeView() {
		return "mypage/partner/manageStore";
	}
	
	@GetMapping("/orderView")
	public String orderView() {
		return "mypage/partner/orderList";
	}
	
	@GetMapping("/adView")
	public String adView() {
		return "mypage/partner/adMain";
	}
	
	@GetMapping("/adListView")
	public String adListView() {
		return "mypage/partner/adList";
	}
	
	@PostMapping("/checkDelete")
	public String checkDelete(@ModelAttribute Member m,
			                  Model model) {
		Member member = pService.selectMember(m);
		
		if(member != null && bcryptPasswordEncoder.matches(m.getPwd(), member.getPwd())) {
			return "mypage/partner/confirmDeleteMember";
		} else {
			model.addAttribute("msg", "비밀번호가 일치 하지 않습니다.");
			return "mypage/partner/deleteMember";
		}
	}
	
	@PostMapping("/delete")
	public String deleteMember(@RequestParam("id") String id,
			                   Model model,
			                   SessionStatus status,
			                   RedirectAttributes rd) {
		int result = pService.deleteMember(id);
		
		if(result > 0) {
			status.setComplete();
			rd.addFlashAttribute("msg", "정상적으로 탈퇴 되었습니다.");
			return "redirect:/";
		} else {
			model.addAttribute("msg", "회원 탈퇴에 실패하였습니다.");
			return "mypage/partner/deleteMember";
		}
	}
	
	@PostMapping("/update")
	public String updateMember(@ModelAttribute Member m,
			                   @RequestParam("address1") String address1,
			                   @RequestParam("address2") String address2,
			                   @RequestParam("address3") String address3,
			                   Model model,
			                   RedirectAttributes rd) {
		m.setAddr(address1 + "," + address2 + "," + address3);
		
		String encPwd = bcryptPasswordEncoder.encode(m.getPwd());
		m.setPwd(encPwd);
		m.setGrade("P");
		int result = pService.updateMember(m);
		if(result > 0) {
			Member loginUser = pService.selectMember(m);
			System.out.println(loginUser);
			if(loginUser != null) {
				model.addAttribute("loginUser", loginUser);
				rd.addFlashAttribute("msg", "회원 정보가 수정 되었습니다.");
				return "redirect:/";
			} else {
				model.addAttribute("msg", "로그인 정보를 불러오지 못했습니다.");
				return "mypage/partner/updateMember";
			}
		} else {
			model.addAttribute("msg", "회원정보 수정에 실패하였습니다.");
			return "mypage/partner/updateMember";
		}
	}
	
	@PostMapping("/adDate")
	public String adDate(@RequestParam("day") String day, Model model) {
		model.addAttribute("day", day);
		return "mypage/partner/adImageUpload";
	}
	
	@PostMapping("/adImage")
	public String adImage(Ad ad,
			              @RequestParam(value="banner-img") MultipartFile file,
			              HttpServletRequest request) {
		
		return "";
	}
}