package com.pro.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.pro.dto.AccountVO;

public class LoginCheckInterceptor extends HandlerInterceptorAdapter {
	
	protected final Logger logger = LoggerFactory.getLogger(this.getClass());
	
	@Override
	public boolean preHandle (HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
		
		logger.info("==================== LoginCheckInterceptor =================");
		
		HttpSession session = request.getSession(false);
		if(session == null)
		{
			logger.info(" Request URI \t: " + request.getRequestURI());

			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}
		
		AccountVO member = (AccountVO)session.getAttribute("account");
		if(member == null)
		{
			logger.info(" Request URI \t: " + request.getRequestURI());

			response.sendRedirect(request.getContextPath() + "/");
			return false;
		}
		
		return true;
	}
	
	@Override
	public void postHandle(HttpServletRequest requset, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception{
	}
}
