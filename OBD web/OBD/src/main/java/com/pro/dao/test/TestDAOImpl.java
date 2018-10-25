package com.pro.dao.test;

import java.util.List;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.dto.AccountVO;

@Repository
public class TestDAOImpl implements TestDAO {
    @Inject
    private SqlSession sqlSession;
    
    private static final String Namespace = "com.pro.mappers.mangoMapper";

	@Override
	public List<AccountVO> SelectPushId() throws Exception {
		return sqlSession.selectList(Namespace+".selectPushId");
	}

}
