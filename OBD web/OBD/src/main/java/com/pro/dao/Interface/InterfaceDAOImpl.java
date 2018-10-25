package com.pro.dao.Interface;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pro.dto.AccountVO;
import com.pro.dto.OBD_VO;

@Repository
public class InterfaceDAOImpl implements InterfaceDAO{

	@Inject
    private SqlSession sqlSession;

	private static final String Namespace = "com.pro.mappers.interfaceMapper";
	
	@Override
	public AccountVO GetAccountInfo(Map params) throws Exception {
		return sqlSession.selectOne(Namespace+".getAccountInfo", params);
	}

	@Override
	public int UpdateAccountInfo(Map params) throws Exception {
		return sqlSession.update(Namespace+".updateAccountInfo", params);
	}

	@Override
	public int InsertObdData(OBD_VO vo) throws Exception {
		return sqlSession.update(Namespace+".insertObdData", vo);
	}

	@Override
	public List<OBD_VO> SelectObdData(Map params) throws Exception {
		return sqlSession.selectList(Namespace+".selectObdData");
	}

}
