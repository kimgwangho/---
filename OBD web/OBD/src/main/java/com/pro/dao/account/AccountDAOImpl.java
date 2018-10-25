package com.pro.dao.account;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.dto.AccountVO;

@Repository
public class AccountDAOImpl implements AccountDAO {
	
	@Inject
    private SqlSession sqlSession;
	    
	private static final String Namespace = "com.pro.mappers.accountMapper";
	
	@Override
	public int InsertAccountInfo(AccountVO vo) throws Exception {
		return sqlSession.insert(Namespace+".insertAccountInfo", vo);
	}

	@Override
	public AccountVO SelectAccountInfoOne(AccountVO vo) throws Exception {
		return sqlSession.selectOne(Namespace+".selectAccountInfo", vo);
	}

}
