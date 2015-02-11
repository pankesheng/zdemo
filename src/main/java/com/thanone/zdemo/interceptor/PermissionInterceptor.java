package com.thanone.zdemo.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

public class PermissionInterceptor implements HandlerInterceptor {

	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3) throws Exception {
		// 最后执行，可用于释放资源；可以根据ex是否为null判断是否发生了异常，进行日志记录

	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3) throws Exception {
		// 生成视图之前执行；有机会修改ModelAndView

//		Map<String, Object> map = arg3.getModel();
//		map.put("test", "append something");
	}

	@Override
	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2) throws Exception {
		
//		System.out.println(arg0.getRequestURI());	// "/ssm/login.do"
//		System.out.println(arg0.getContextPath());	// "/ssm"
//		System.out.println(arg0.getSession().getServletContext().getRealPath("/"));	// "E:\Kuaipan\Java_Developer\eclipseWorkspace\.metadata\.plugins\org.eclipse.wst.server.core\tmp8\wtpwebapps\spring_springmvc_mybatis\"
//		System.out.println(arg0.getServletPath());	// "/login.do"

		return true;
	}
	
}
