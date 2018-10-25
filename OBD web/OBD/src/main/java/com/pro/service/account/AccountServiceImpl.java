package com.pro.service.account;

import javax.inject.Inject;

import org.springframework.stereotype.Service;

import com.pro.dao.account.AccountDAO;
import com.pro.dto.AccountVO;

@Service
public class AccountServiceImpl implements AccountService {

	@Inject
    private AccountDAO dao;
	
	@Override
	public int InsertAccountInfo(AccountVO vo) throws Exception {
		return dao.InsertAccountInfo(vo);
	}

	@Override
	public AccountVO SelectAccountInfoOne(AccountVO vo) throws Exception {
		return dao.SelectAccountInfoOne(vo);
	}

}
