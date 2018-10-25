package com.pro.dao.Interface;

import java.util.List;
import java.util.Map;

import com.pro.dto.AccountVO;
import com.pro.dto.OBD_VO;

public interface InterfaceDAO {
	public int UpdateAccountInfo(Map params) throws Exception;
	public AccountVO GetAccountInfo(Map params) throws Exception;
	public int InsertObdData(OBD_VO vo) throws Exception;
	public List<OBD_VO> SelectObdData(Map params) throws Exception;
}
