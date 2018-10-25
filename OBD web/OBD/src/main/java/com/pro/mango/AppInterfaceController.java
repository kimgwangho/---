package com.pro.mango;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.pro.dto.OBD_VO;
import com.pro.service.Interface.InterfaceService;

@Controller
public class AppInterfaceController {
	private static final Logger logger = LoggerFactory.getLogger(AppInterfaceController.class);

	@Inject
	private InterfaceService service;

	@Autowired
	DataSource dataSource;
	
	@RequestMapping(value = "/update_account_info.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String UpdateAccountInfo(
			@RequestParam(defaultValue="") String language_id,
			@RequestParam(defaultValue="") String sex,
			@RequestParam(defaultValue="") String grade,
			@RequestParam(defaultValue="") String user_id,
			HttpServletResponse response) throws Exception {
		
		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
	
		int result;
		// construct an appropriate transaction manager
		DataSourceTransactionManager txManager = new DataSourceTransactionManager(dataSource);
		TransactionStatus sts = txManager.getTransaction(def);

		try {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("language_id", language_id);
			params.put("sex", sex);
			params.put("grade", grade);
			params.put("user_id", user_id);
			
			// update order info..
			result = service.UpdateAccountInfo(params);			
		}catch(Exception e){
			 txManager.rollback(sts);
			 return "{\"result\":-2}";
		}
		
		// 일치하는 데이터가 없습니다.
		if(result  == 0) {
			txManager.rollback(sts);
			return "{\"result\":0}";
		} else if (result > 1) {
			// 일치하는 데이터가 1개 이상 있습니다.
			txManager.rollback(sts);
			return "{\"result\":-1}";
		}
		
		txManager.commit(sts);
		return "{\"result\":1}";
	}
	

	@RequestMapping(value = "/select_obd_data_list.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody List<OBD_VO> SelectAccountInfoList(
//			@RequestParam(defaultValue="0") int start,
//			@RequestParam(defaultValue="100") int end,		
//			@RequestParam("user_id") String user_id, 
//			@RequestParam(value="auth", required=false) String auth, 
//			@RequestParam(value="name", required=false) String name, 
//			@RequestParam(value="hp_num", required=false) String hp_num, 
			HttpServletResponse response) throws Exception {
		
		Map<String, Object> parms = new HashMap<String, Object>();
//		parms.put("start", start);
//		parms.put("end", end);
//		parms.put("user_id", user_id);
//		parms.put("auth", auth);
//		parms.put("name", name);
//		parms.put("hp_num", hp_num);

		return service.SelectObdData(parms);
	}
	
	@RequestMapping(value = "/insert_obd_data.json", method = RequestMethod.POST, produces = "application/json;charset=utf8")
	public @ResponseBody String InsertObdData(
//			@RequestParam("user_id") String user_id,
			@RequestParam(value = "timestamp", required = false) String timestamp,
			@RequestParam(value = "msgcnt", required = false) String msgcnt,
			@RequestParam(value = "cool_temp", required = false) String cool_temp,
			@RequestParam(value = "rpm", required = false) String rpm,
			@RequestParam(value = "time_after", required = false) String time_after,
			@RequestParam(value = "vehicle_spd", required = false) String vehicle_spd,
			@RequestParam(value = "engine_oil_temp", required = false) String engine_oil_temp,
			@RequestParam(value = "fuel_type", required = false) String fuel_type,
			@RequestParam(value = "bettery_rmn", required = false) String bettery_rmn,
			@RequestParam(value = "remain_oil", required = false) String remain_oil,
			@RequestParam(value = "consume_oil", required = false) String consume_oil,
			@RequestParam(value = "distance_driven", required = false) String distance_driven,
			HttpServletResponse response)
			throws Exception {

		OBD_VO vo = new OBD_VO();
		vo.setBettery_rmn(bettery_rmn);
		vo.setCool_temp(cool_temp);
		vo.setEngine_oil_temp(engine_oil_temp);
		vo.setFuel_type(fuel_type);
		vo.setMsgcnt(msgcnt);
		vo.setRpm(rpm);
		vo.setTime_after(time_after);
		vo.setTimestamp(timestamp);
		vo.setVehicle_spd(vehicle_spd);
		vo.setRemain_oil(remain_oil);
		vo.setConsume_oil(consume_oil);
		vo.setdistance_driven(distance_driven);
		// vo.setPush_id(push_id);

		DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);

		// construct an appropriate transaction manager
		DataSourceTransactionManager txManager = new DataSourceTransactionManager(dataSource);
		TransactionStatus sts = txManager.getTransaction(def);

		try {
			// miner의 정보를 입력한다.
			service.InsertObdData(vo);
		} catch (Exception e) {
			txManager.rollback(sts);
			return "{\"result\":-1}";
		}

		txManager.commit(sts);
		return "{\"result\":0}";
	}
	
	@RequestMapping(value = "/get_account_info.json", method = RequestMethod.POST, produces = "application/json")
	public @ResponseBody String GetAccountInfo(
			@RequestParam(defaultValue="") String user_id,
			@RequestParam(defaultValue="") String pwd,
			HttpServletResponse response) throws Exception {
		
		AccountVO result_vo = new AccountVO();
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("user_id", user_id);
		params.put("pwd", pwd);
		
		result_vo = service.GetAccountInfo(params);
		
		if( result_vo != null) {
//			service.UpdateAccountPushId(params);
			return "{\"result\":1}";	///< account를 검색
		} else {
			return "{\"result\":0}"; ///< 검색된 정보가 없을 경우
		}
	}
	

}
