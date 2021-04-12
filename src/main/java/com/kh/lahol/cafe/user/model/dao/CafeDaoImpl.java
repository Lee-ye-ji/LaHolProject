package com.kh.lahol.cafe.user.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.kh.lahol.cafe.user.model.vo.CafeRes;

@Repository
public class CafeDaoImpl implements CafeDao {
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	@Override
	public int hereInsertRes(CafeRes r) {
		return sqlSession.insert("cafeMapper.insertHereRes", r);
	}

	@Override
	public int togoInsertRes(CafeRes r) {
		return sqlSession.insert("cafeMapper.insertTogoRes", r);
	}

}
