package com.pro.mango;

import javax.inject.Inject;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.pro.dto.AccountVO;
import com.pro.service.account.AccountService;

@Controller
public class UserPageController {

	private static final Logger logger = LoggerFactory.getLogger(UserPageController.class);

	@Inject
	private AccountService service;

	@Autowired
	DataSource dataSource;

	// @RequestMapping(value = "/insert_account_info.json", method =
	// RequestMethod.POST, produces = "application/json")
	@RequestMapping(value = "/insert_account_info.json", method = RequestMethod.POST, produces = "application/json;charset=utf8")
	public @ResponseBody String InsertAccountInfo(@RequestParam("user_id") String user_id,
			@RequestParam(value = "pwd", required = false) String pwd,
			@RequestParam(value = "name", required = false) String name,
			@RequestParam(value = "hp_num", required = false) String hp_num, HttpServletResponse response)
			throws Exception {

		AccountVO vo = new AccountVO();
		vo.setUser_id(user_id);
		vo.setPwd(pwd);
		// vo.setAuth(auth);
		vo.setName(name);
		vo.setHp_num(hp_num);
		// vo.setPush_id(push_id);

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		// construct an appropriate transaction manager
		DataSourceTransactionManager txManager = new DataSourceTransactionManager(dataSource);
		TransactionStatus sts = txManager.getTransaction(def);

		try {
			// miner의 정보를 입력한다.
			service.InsertAccountInfo(vo);
		} catch (Exception e) {
			txManager.rollback(sts);
			return "{\"result\":-1}";
		}

		txManager.commit(sts);
		return "{\"result\":0}";
	}

}
