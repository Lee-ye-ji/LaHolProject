package com.kh.lahol.cafe.bus.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kh.lahol.cafe.bus.model.dao.CafeBizDao;
import com.kh.lahol.cafe.bus.model.vo.Cafe;
import com.kh.lahol.cafe.bus.model.vo.Caphoto;
import com.kh.lahol.cafe.user.model.dao.CafeDao;

@Service
public class CafeBizServiceImpl implements CafeBizService{
	@Autowired
	private CafeBizDao caBizDao;

	@Override
	public int insertCafeInfo(Cafe c) {
		return caBizDao.insertCafeInfo(c);
	}

	/*
	 * @Override public int insertCafeInfoPhoto(ArrayList<Caphoto> photoList) {
	 * System.out.println("photoListService : " + photoList); return
	 * caBizDao.insetCafeInfoPhoto(photoList); }
	 */

	
	
	

}
