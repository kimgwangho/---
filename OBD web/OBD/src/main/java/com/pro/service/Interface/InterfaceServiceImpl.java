package com.pro.service.Interface;

import java.util.List;
import java.util.Map;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.pro.dao.Interface.InterfaceDAO;
import com.pro.dto.AccountVO;
import com.pro.dto.OBD_VO;

@Service
public class InterfaceServiceImpl implements InterfaceService{
	@Inject
    private InterfaceDAO dao;
	
	@Override
	public AccountVO GetAccountInfo(Map params) throws Exception {
		return dao.GetAccountInfo(params);
	}

	@Override
	public int UpdateAccountInfo(Map params) throws Exception {
		return dao.UpdateAccountInfo(params);
	}

	@Override
	public int InsertObdData(OBD_VO vo) throws Exception {
		return dao.InsertObdData(vo);
	}

	@Override
	public List<OBD_VO> SelectObdData(Map params) throws Exception {
		return dao.SelectObdData(params);
	}
}
