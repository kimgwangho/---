package com.pro.service.account;

import com.pro.dto.AccountVO;

public interface AccountService {
	public AccountVO SelectAccountInfoOne(AccountVO vo) throws Exception;
	public int InsertAccountInfo(AccountVO vo) throws Exception;
}
