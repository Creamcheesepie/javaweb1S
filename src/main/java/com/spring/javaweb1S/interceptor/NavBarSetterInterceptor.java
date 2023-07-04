package com.spring.javaweb1S.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.spring.javaweb1S.service.BoardService;
import com.spring.javaweb1S.vo.CategoryVO;

public class NavBarSetterInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	BoardService boardService;
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {
		List<CategoryVO> category_vos = boardService.getCategoryList();
		
		if(!"XMLHttpRequest".equals(request.getHeader("x-requested-with"))) {
			modelAndView.addObject("nav_vos", category_vos);
		}
		else {
			return ;
		}
		super.postHandle(request, response, handler, modelAndView);
	}
	
	
}
