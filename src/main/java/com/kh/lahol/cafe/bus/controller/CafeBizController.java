package com.kh.lahol.cafe.bus.controller;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.google.gson.Gson;
import com.kh.lahol.cafe.bus.model.page.Pagination;
import com.kh.lahol.cafe.bus.model.page.PaginationOrder;
import com.kh.lahol.cafe.bus.model.service.CafeBizService;
import com.kh.lahol.cafe.bus.model.vo.Cafe;
import com.kh.lahol.cafe.bus.model.vo.Caphoto;
import com.kh.lahol.cafe.bus.model.vo.Coffee;
import com.kh.lahol.cafe.bus.model.vo.Order;
import com.kh.lahol.cafe.bus.model.vo.PageInfo;
import com.kh.lahol.cafe.bus.model.vo.bevOrder;
import com.kh.lahol.cafe.bus.model.vo.Order;
import com.kh.lahol.cafe.user.model.exception.CafeException;
import com.kh.lahol.cafe.user.model.service.CafeService;
import com.kh.lahol.cafe.user.model.vo.CafeQnA;
import com.kh.lahol.cafe.user.model.vo.CafeRes;
import com.kh.lahol.cafe.user.model.vo.CoffeeRes;
import com.kh.lahol.common.model.exception.CartException;
import com.kh.lahol.common.model.vo.Coupon;
import com.kh.lahol.member.model.vo.Member;

@Controller
@RequestMapping("/cafe/biz")
/* @SessionAttributes({"loginUser"}) */
public class CafeBizController {
	
	@Autowired private CafeBizService caBizService;
	
	private static final Logger logger = LoggerFactory.getLogger(CafeBizController.class);
	
	@GetMapping("/home")
	public ModelAndView homeList(Model model, ModelAndView mv, @SessionAttribute("loginUser") Member m) {
		String id = m.getId();
		
		Cafe ca = caBizService.cafeHome(id);
		int countBefore = caBizService.countBefore(id);
		int countMiddle = caBizService.countMiddle(id);
		int countAfter = caBizService.countAfter(id);
		List<CafeQnA> caAnswer = caBizService.answerQnAList(id);
		
		if(ca != null) {
			mv.addObject("ca", ca);
			mv.addObject("countBefore", countBefore);
			mv.addObject("countMiddle", countMiddle);
			mv.addObject("countAfter", countAfter);
			mv.addObject("caAnswer", caAnswer);
			mv.setViewName("cafe/bus/busHome");
		}else {
			mv.addObject("msg", "???????????? ?????? ????????? ?????????????????????.");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	@GetMapping("/write")
	public String caWriteSelect(Model model, @SessionAttribute("loginUser") Member m) {
		
		String Id = m.getId();
		System.out.println("Id : "+ Id);
		  Cafe ca = caBizService.caWriteSelect(Id);
		  
		  System.out.println(ca);
		  
		  if(ca != null) { 
			  model.addAttribute("Cafe", ca); 
			  return "cafe/bus/write";
		  }else { 
			  model.addAttribute("msg", "?????? ????????? ?????????????????????."); 
			  return "common/error";
		  }
		 
	}
	
	
	@PostMapping("/insert")
	public String insertCafeInfo(@ModelAttribute Cafe c,
								@RequestParam(name="imgfile1") MultipartFile mainfile,
								@RequestParam(name="imgfile2") MultipartFile file1,
								@RequestParam(name="imgfile3") MultipartFile file2,
								@RequestParam(name="imgfile4") MultipartFile file3,
								@RequestParam(name="cafeAddress1") String cafeAddress1,
								@RequestParam(name="cafeAddress2") String cafeAddress2,
								HttpServletRequest request) throws CafeException {
		
		c.setCaAddress("????????????"+ "," + cafeAddress1 + "," + cafeAddress2);
		
		 
		 if(!mainfile.getOriginalFilename().equals("")) {
				// ?????? ?????? ????????? ????????? ?????? - ???????????? ??????
				String renameFileName = saveFile(mainfile, request);
				
				// DB??? ???????????? ?????? ????????? ??????
				if(renameFileName != null) {
					c.setMainPhoto(renameFileName);
				}

			}
		 if(!file1.getOriginalFilename().equals("")) {
				String renameFileName = saveFile(file1, request);				
				
				// DB??? ???????????? ?????? ????????? ??????
				if(renameFileName != null) {
					c.setPhoto1(renameFileName);
				}
			}
		 if(!file2.getOriginalFilename().equals("")) {
				String renameFileName = saveFile(file2, request);
				
				// DB??? ???????????? ?????? ????????? ??????
				if(renameFileName != null) {
					c.setPhoto2(renameFileName);
				}
			}
		 if(!file3.getOriginalFilename().equals("")) {
				String renameFileName = saveFile(file3, request);
				
				// DB??? ???????????? ?????? ????????? ??????
				if(renameFileName != null) {
					c.setPhoto3(renameFileName);
				}
			}
		 	
		
		System.out.println("?????? : "+ c);
		
		int result = caBizService.insertCafeInfo(c);
		
		if(result > 0) {
			return "cafe/bus/confirm";
		}else {
			throw new CafeException("?????? ?????? ????????? ?????????????????????.");
		}
		
		
	}
	
	public String saveFile(MultipartFile file, HttpServletRequest request) {
	      String root = request.getSession().getServletContext().getRealPath("resources");
	      String savePath = root + "/nuploadFiles/cafeImg";
	      File folder = new File(savePath); // ?????????????????? ?????? ?????? ????????? 
	      if(!folder.exists()) {
	    	  folder.mkdir(); // -> ?????? ????????? ???????????? ???????????? ???????????? ??????
	      }
	      
	      // ????????? ????????? ?????? "??????????????????_?????????.?????????"
	      SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
	      String originalFileName = file.getOriginalFilename();
	      String renameFileName = sdf.format(new Date()) + "_"
	                     + (int)(Math.random() * 100000)
	                     + originalFileName.substring(originalFileName.lastIndexOf("."));
	      
	      String renamePath = folder + "/" + renameFileName; // ????????????????????? ?????? + ?????????
	      
	      try {
	         file.transferTo(new File(renamePath));
	         // => ????????? ??? ?????? (MultipartFile) ??? rename????????? ????????? ??????
	      } catch (IllegalStateException | IOException e) {
	         System.out.println("?????? ????????? ?????? : " + e.getMessage());
	      }
	      
	      return renameFileName;
	   }
	
	
	@GetMapping("/confirm")
	public ModelAndView cafeList(ModelAndView mv, @SessionAttribute("loginUser") Member m) {
		
		String Id = m.getId();
		List<Cafe> Cafelist = caBizService.selectCafeList(Id);
		
		if(Cafelist != null) {
			mv.addObject("Cafelist", Cafelist);
			mv.setViewName("cafe/bus/confirm");
		}else {
			mv.addObject("msg", "???????????? ?????? ????????? ?????????????????????.");
			mv.setViewName("common/error");
		}
		
		return mv;
	}
	
	@GetMapping("/caDetail")
	public String caDetail(@RequestParam String caCode,
							Model model) {
		
		Cafe ca = caBizService.selectCafeInfo(caCode);
		
		if(ca != null) {
			model.addAttribute("Cafe", ca);
			return "cafe/bus/upCafe";
		}else {
			model.addAttribute("msg", "????????? ?????? ????????? ?????????????????????.");
			return "common/error";
		}
		
	}
	
	private void deleteFile(String fileName, HttpServletRequest request) {
	      String root = request.getSession().getServletContext().getRealPath("resources");
	      String savePath = root + "/buploadFiles/cafeImg";
	      
	      File deleteFile = new File(savePath + "/" + fileName);
	      
	      if(deleteFile.exists())
	         deleteFile.delete();
	   }
	
	
	@PostMapping("/update")
	public String updateCafeInfo(@ModelAttribute Cafe c,
								@RequestParam(name="imgfile1") MultipartFile mainfile,
								@RequestParam(name="imgfile2") MultipartFile file1,
								@RequestParam(name="imgfile3") MultipartFile file2,
								@RequestParam(name="imgfile4") MultipartFile file3,
								@RequestParam(name="cafeAddress1") String cafeAddress1,
								@RequestParam(name="cafeAddress2") String cafeAddress2,
								HttpServletRequest request) throws CafeException {
		c.setCaAddress("????????????" + "," + cafeAddress1 + "," + cafeAddress2);
		 
		
		 if(!mainfile.getOriginalFilename().equals("")) {
				// ?????? ?????? ????????? ????????? ?????? - ???????????? ??????
			if(c.getMainPhoto() != null) {
				deleteFile(c.getMainPhoto(), request);
			}
			
			String renameFileName = saveFile(mainfile, request);
			
			if(renameFileName != null) {
				c.setMainPhoto(renameFileName);
			}	
		 }
		 
		 if(!file1.getOriginalFilename().equals("")) {
				// ?????? ?????? ????????? ????????? ?????? - ???????????? ??????
			if(c.getPhoto1() != null) {
				deleteFile(c.getPhoto1(), request);
			}
			
			String renameFileName = saveFile(file1, request);
			
			if(renameFileName != null) {
				c.setPhoto1(renameFileName);
			}	
		 }
		 
		 if(!file2.getOriginalFilename().equals("")) {
				// ?????? ?????? ????????? ????????? ?????? - ???????????? ??????
			if(c.getPhoto2() != null) {
				deleteFile(c.getPhoto2(), request);
			}
			
			String renameFileName = saveFile(file2, request);
			
			if(renameFileName != null) {
				c.setPhoto2(renameFileName);
			}	
		 }
		 
		 if(!file3.getOriginalFilename().equals("")) {
				// ?????? ?????? ????????? ????????? ?????? - ???????????? ??????
			if(c.getPhoto3() != null) {
				deleteFile(c.getPhoto3(), request);
			}
			
			String renameFileName = saveFile(file3, request);
			
			if(renameFileName != null) {
				c.setPhoto3(renameFileName);
			}	
		 }
		 	
		
		System.out.println("?????? : "+ c);
		
		int result = caBizService.updateCafeInfo(c);
		
		if(result > 0) {
			return "redirect:/cafe/biz/confirm";
		}else {
			throw new CafeException("?????? ?????? ????????? ?????????????????????.");
		}
	}
	
	@GetMapping("/Coffee")
	public ModelAndView coffeeSelect(ModelAndView mv, @RequestParam String caCode,
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage) {
		
		// System.out.println(caCode + "caCode");
		int listCount = caBizService.selectCoffeeCount(caCode);
		System.out.println(listCount);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		System.out.println(pi);
		List<Coffee> Coffeelist = caBizService.selectCoffeeList(pi, caCode);
		System.out.println(Coffeelist);
		
		
		mv.addObject("Coffeelist", Coffeelist);
		mv.addObject("pi", pi);
		mv.setViewName("cafe/bus/coffee");
		
		return mv;
		
	}
	
	@PostMapping("/coffee/insert")
	public String insertCoffee(@ModelAttribute Coffee co,
								@RequestParam(name="imgBev") MultipartFile cfIname,
								@RequestParam(name="caNo") String caNo,
								HttpServletRequest request) throws CafeException {
		
		 
		 if(!cfIname.getOriginalFilename().equals("")) {
				// ?????? ?????? ????????? ????????? ?????? - ???????????? ??????
				String renameFileName = saveFile(cfIname, request);
				
				// DB??? ???????????? ?????? ????????? ??????
				if(renameFileName != null) {
					co.setCfIchname(renameFileName);
					co.setCfIname(cfIname.getOriginalFilename());
					co.setChIpath("/nuploadFiles/cafeImg");
				}

			}
		 
		 	
		System.out.println("????????? ??? ?????? ??????" + caNo);
		System.out.println("?????? ?????? : "+ co);
		
		
		
		 int result = caBizService.insertCoffee(co);
		  
		if(result > 0) { 
			return "redirect:/cafe/biz/Coffee?caCode="+ caNo;
			/* return "cafe/bus/coffee"; */
		}
		else { 
			throw new CafeException("?????? ?????? ????????? ?????????????????????."); 
			}
		
		
		
	}
	
	
	// ?????? ????????? ?????? ?????? ??????
	@GetMapping("/cfDetail")
	public String cfDetail(@RequestParam String cfNo,
							Model model) {
		
		// System.out.println("cfNo : "+ cfNo);
		
		 Coffee co = caBizService.selectCoffeeInfo(cfNo);
		 
		  if(co != null) { 
			  model.addAttribute("Coffee", co); 
			  return "cafe/bus/upCoffee";
		  }else { 
			  model.addAttribute("msg", "????????? ?????? ????????? ?????????????????????."); 
			  return "common/error"; 
		}
			
	}
	
	
	@PostMapping("/coffee/update")
	public String updateCoffeeInfo(@ModelAttribute Coffee co,
								@RequestParam(name="imgBev") MultipartFile photofile,
								HttpServletRequest request) throws CafeException {
		
		String caNo = co.getCaNo();
		
		 if(!photofile.getOriginalFilename().equals("")) {
				// ?????? ?????? ????????? ????????? ?????? - ???????????? ??????
			if(co.getCfIchname() != null) {
				deleteFile(co.getCfIchname(), request);
			}
			
			String renameFileName = saveFile(photofile, request);
			
			if(renameFileName != null) {
				co.setCfIchname(renameFileName);
				co.setCfIname(photofile.getOriginalFilename());
				co.setChIpath("/nuploadFiles/cafeImg");
			}	
		 }
		 
		System.out.println("?????? ?????? ?????? : "+ co);
		 
		int result = caBizService.updateCoffeeInfo(co);
		
		if(result > 0) {
			return "redirect:/cafe/biz/Coffee?caCode="+ caNo;
		}else {
			throw new CafeException("?????? ?????? ????????? ?????????????????????.");
		}

	}
	
	@GetMapping("/delete")
	public String cafeDelete(String caCode, HttpServletRequest request) throws CafeException {
		System.out.println("?????? ?????? ??????: "+ caCode);
		
		int result = caBizService.cafeDelete(caCode);
		
		
		if (result > 0) {
			return "redirect:/cafe/biz/write";
		} else {
			throw new CafeException("?????? ????????? ?????????????????????.");
		}
		
		
	}
	
	@GetMapping("/coffee/delete")
	public String coffeeDelete(String cfNo, HttpServletRequest request) throws CafeException {
		System.out.println("?????? ?????? ?????? : "+ cfNo);
		
		Coffee co = caBizService.selectCoffeeInfo(cfNo);
		
		String caNo = co.getCaNo();
		System.out.println("?????? ??????" + caNo);
		int result = caBizService.coffeeDelete(cfNo);
		
		// ?????? ??????????????? ?????? ????????? ?????? ?????? ??????
		if(co.getCfIchname() != null) {
			deleteFile(co.getCfIchname(), request);
		}
		
		if (result > 0) {
			return "redirect:/cafe/biz/Coffee?caCode="+ caNo;
		} else {
			throw new CafeException("?????? ????????? ?????????????????????.");
		}
		
		
	}

	
	@GetMapping("/res")
	public ModelAndView cafeResList(ModelAndView mv, @SessionAttribute("loginUser") Member m) {

		String Id = m.getId();
		List<CafeRes> cafeReslist = caBizService.selectCafeResList(Id);
//		System.out.println(cafeReslist);
		
		if(cafeReslist != null) {
			mv.addObject("cafeReslist", cafeReslist);
			mv.setViewName("cafe/bus/res");
		}else {
			mv.addObject("msg", "???????????? ?????? ????????? ?????????????????????.");
			mv.setViewName("common/error");
		}
		
		
		
		return mv;
		

	}
	
	
	@GetMapping("/order")
	public ModelAndView cafeOrderList(ModelAndView mv, @SessionAttribute("loginUser") Member m,
									@ModelAttribute Order ord,
			@RequestParam(value="page", required=false, defaultValue="1") int currentPage) {

		String id = m.getId();
        //System.out.println(cafeOrderlist);
		int listCount = caBizService.selectOrderCount(ord);
		PageInfo pi = PaginationOrder.getPageInfo(currentPage, listCount);
		List<CafeRes> cafeOrderlist = caBizService.selectOrderList(id, pi);
		//System.out.println("?????? ?????? : "+ cafeOrderlist);
		
		if(cafeOrderlist != null) {
			mv.addObject("cafeOrderlist", cafeOrderlist);
			mv.addObject("pi", pi);
			mv.setViewName("cafe/bus/order");
		}else {
			mv.addObject("msg", "???????????? ?????? ????????? ?????????????????????.");
			mv.setViewName("common/error");
		}
			
		return mv;

	}
	
	@PostMapping("/ing")
	public String coffeeStatus(@ModelAttribute CafeRes cr, 
						String caResing, String caResNo) throws CafeException{
		 // System.out.println(caResing);
		  cr.setCaResNo(caResNo);
		  cr.setCaResIng(caResing);
		 // System.out.println(cr);
		  int result = caBizService.coffeeStatus(cr);
		  
		  if(result > 0) { 
			  return "redirect:/cafe/biz/order"; 
		  }else { 
			  throw new CafeException("?????? ????????? ??????????????? ?????????????????????."); 
		  }
		
	}
	
	
	@GetMapping("/orderDate")
	public ModelAndView cafeOrderDateList(ModelAndView mv, @SessionAttribute("loginUser") Member m,
											@RequestParam(name="checkDate") String checkDate,
											@ModelAttribute Order ord,
											@RequestParam(value="page", required=false, defaultValue="1") int currentPage) {

		String id = m.getId();
		ord.setId(id);
		ord.setCheckDate(checkDate);	
		int listCount = caBizService.selectOrderCount(ord);
		PageInfo pi = PaginationOrder.getPageInfo(currentPage, listCount);
		List<CafeRes> OrderDate = caBizService.OrderDate(ord, pi);

		if(OrderDate != null) {
			mv.addObject("cafeOrderlist", OrderDate);
			mv.addObject("check", ord);
			mv.addObject("pi", pi);
			mv.setViewName("cafe/bus/order");
		}else {
			mv.addObject("msg", "???????????? ?????? ?????? ????????? ?????????????????????.");
			mv.setViewName("common/error");
		}
			
		return mv;

	}
	

	@PostMapping("/order/beverage")
	public void beverageOrderList(ModelAndView mv, String caResNo, HttpServletResponse response) {
		
		response.setContentType("application/json; charset=utf-8");
		
		System.out.println("?????? ?????? : "+ caResNo);
		List<bevOrder> beverageOrder = caBizService.beverageOrder(caResNo);
		
		
		if(beverageOrder != null) {
			PrintWriter out;
			try {
				out = response.getWriter();
				out.print(new Gson().toJson(beverageOrder));
			} catch (IOException e) {
				e.printStackTrace();
			}
			
		}

	}
	
	@PostMapping("/answer")
	public String updateQAanswer(@ModelAttribute CafeQnA ans, @SessionAttribute("loginUser") Member m) throws CafeException {
		
		String id = m.getId();
		ans.setBizId(id);
		
		int result = caBizService.updateQAanswer(ans);
		
		if(result > 0) {
			return "redirect:/cafe/biz/home";
		}else {
			throw new CafeException("?????? ?????? ????????? ?????????????????????.");
		}
	}
	

}
