package com.kh.lahol.cafe.bus.model.dao;

import java.util.ArrayList;
import java.util.List;

import org.apache.ibatis.session.RowBounds;

import com.kh.lahol.cafe.bus.model.vo.Cafe;
import com.kh.lahol.cafe.bus.model.vo.Caphoto;
import com.kh.lahol.cafe.bus.model.vo.Coffee;
import com.kh.lahol.cafe.bus.model.vo.Order;
import com.kh.lahol.cafe.bus.model.vo.PageInfo;
import com.kh.lahol.cafe.bus.model.vo.bevOrder;
import com.kh.lahol.cafe.user.model.vo.CafeQnA;
import com.kh.lahol.cafe.user.model.vo.CafeRes;
import com.kh.lahol.cafe.user.model.vo.CoffeeRes;

public interface CafeBizDao {
	// 카페 정보 insert
	public int insertCafeInfo(Cafe c);
	
	public List<Cafe> selectCafeList(String Id);

	public Cafe selectCafeInfo(String caCode);

	public int updateCafeInfo(Cafe c);

	public List<Coffee> selectCoffeeList(PageInfo pi, String caCode);

	public Cafe caWriteSelect(String Id);

	public int insertCoffee(Coffee co);

	public Coffee selectCoffeeInfo(String cfNo);

	public int updateCoffeInfo(Coffee co);

	public int coffeeDelete(String cfNo);

	public int cafeDelete(String caCode);

	public int selectCoffeeCount(String Cacode);

	public List<CafeRes> selectCafeResList(String id);

	public List<CafeRes> selectOrderList(String id, PageInfo pi);

	public int coffeeStatus(CafeRes cr);

	public int selectOrderCount(Order ord);

	List<CafeRes> orderDate(Order ord, PageInfo pi);

	public List<bevOrder> beverageOrder(String caResNo);

	public Cafe cafeHome(String id);

	public int countBefore(String id);

	public int countMiddle(String id);

	public int countAfter(String id);

	public List<CafeQnA> answerQnAList(String id);

	public int updateQAanswer(CafeQnA ans);


	
	

}
