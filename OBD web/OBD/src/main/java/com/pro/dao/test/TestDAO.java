package com.pro.dao.test;

import java.util.List;

import com.pro.dto.AccountVO;

public interface TestDAO {
	public List<AccountVO> SelectPushId() throws Exception;
}
