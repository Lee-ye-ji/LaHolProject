package com.kh.lahol.cafe.bus.model.service;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.lahol.cafe.bus.model.dao.CafeBizDao;
import com.kh.lahol.cafe.bus.model.vo.Cafe;
import com.kh.lahol.cafe.bus.model.vo.Caphoto;
import com.kh.lahol.cafe.bus.model.vo.Coffee;
import com.kh.lahol.cafe.bus.model.vo.Order;
import com.kh.lahol.cafe.bus.model.vo.PageInfo;
import com.kh.lahol.cafe.bus.model.vo.bevOrder;
import com.kh.lahol.cafe.user.model.dao.CafeDao;
import com.kh.lahol.cafe.user.model.vo.CafeQnA;
import com.kh.lahol.cafe.user.model.vo.CafeRes;
import com.kh.lahol.cafe.user.model.vo.CoffeeRes;

@Service
public class CafeBizServiceImpl implements CafeBizService{
	@Autowired
	private CafeBizDao caBizDao;

	@Override
	public int insertCafeInfo(Cafe c) {
		return caBizDao.insertCafeInfo(c);
	}

	@Override
	public List<Cafe> selectCafeList(String Id) {
		return caBizDao.selectCafeList(Id);
	}

	@Override
	public int updateCafeInfo(Cafe c) {
		return caBizDao.updateCafeInfo(c);
	}

	@Override
	public Cafe selectCafeInfo(String caCode) {
		
		return caBizDao.selectCafeInfo(caCode);
	}

	@Override
	public List<Coffee> selectCoffeeList(PageInfo pi, String caCode) {
		return caBizDao.selectCoffeeList(pi, caCode);
	}

	@Override
	public Cafe caWriteSelect(String Id) {
		return caBizDao.caWriteSelect(Id);
	}

	@Override
	public int insertCoffee(Coffee co) {
		return caBizDao.insertCoffee(co);
	}

	@Override
	public Coffee selectCoffeeInfo(String cfNo) {
		return caBizDao.selectCoffeeInfo(cfNo);
	}

	@Override
	public int updateCoffeeInfo(Coffee co) {
		return caBizDao.updateCoffeInfo(co);
	}

	@Override
	public int coffeeDelete(String cfNo) {
		return caBizDao.coffeeDelete(cfNo);
	}

	@Override
	public int cafeDelete(String caCode) {
		return caBizDao.cafeDelete(caCode);
	}

	@Override
	public int selectCoffeeCount(String caCode) {
		return caBizDao.selectCoffeeCount(caCode);
	}

	@Override
	public List<CafeRes> selectCafeResList(String id) {
		return caBizDao.selectCafeResList(id);
	}

	@Override
	public int deleteCafeInfo(String caCode) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int coffeeStatus(CafeRes cr) {
		return caBizDao.coffeeStatus(cr);
	}

	@Override
	public List<CafeRes> OrderDate(Order ord, PageInfo pi) {
		return caBizDao.orderDate(ord, pi);
	}

	@Override
	public int selectOrderCount(Order ord) {
		return caBizDao.selectOrderCount(ord);
	}

	@Override
	public List<bevOrder> beverageOrder(String caResNo) {
		System.out.println("service : "+ caResNo);
		return caBizDao.beverageOrder(caResNo);
	}

	@Override
	public List<CafeRes> selectOrderList(String id, PageInfo pi) {
		return caBizDao.selectOrderList(id, pi);
	}

	@Override
	public Cafe cafeHome(String id) {
		return caBizDao.cafeHome(id);
	}

	@Override
	public int countBefore(String id) {
		return caBizDao.countBefore(id);
	}

	@Override
	public int countMiddle(String id) {
		return caBizDao.countMiddle(id);
	}

	@Override
	public int countAfter(String id) {
		return caBizDao.countAfter(id);
	}

	@Override
	public List<CafeQnA> answerQnAList(String id) {
		return caBizDao.answerQnAList(id);
	}

	@Override
	public int updateQAanswer(CafeQnA ans) {
		return caBizDao.updateQAanswer(ans);
	}




	
	
	

}
