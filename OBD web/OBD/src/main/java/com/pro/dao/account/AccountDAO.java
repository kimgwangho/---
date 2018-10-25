package com.pro.dao.account;

import java.util.List;
import java.util.Map;

import com.pro.dto.AccountVO;

public interface AccountDAO {
	public int InsertAccountInfo(AccountVO vo) throws Exception;
	public AccountVO SelectAccountInfoOne(AccountVO vo) throws Exception;
}
