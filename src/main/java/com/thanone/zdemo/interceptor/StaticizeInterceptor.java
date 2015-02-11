package com.thanone.zdemo.interceptor;

import java.io.File;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.regex.Pattern;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.thanone.zdemo.common.Configuration;
import com.thanone.zdemo.handler.CmsHandler;
import com.zcj.util.freemarker.FreemarkerUtil;
import com.zcj.web.context.SystemContext;

/**
 * 静态化拦截器
 * @author zouchongjin@sina.com
 * @data 2014年8月26日
 */
public class StaticizeInterceptor implements HandlerInterceptor {
	
	private static boolean staticize = true;

	private CmsHandler cmsHandler;
	private FreeMarkerConfigurer freemarkerConfig;
	
	private static List<String> URLS = new ArrayList<String>();
	static {
		URLS.add("/catalog/modify.*");
		URLS.add("/catalog/delete.*");
		URLS.add("/article/modify.*");
		URLS.add("/article/delete.*");
		URLS.add("/article/tops/.*");
		URLS.add("/article/canceltops/.*");
		URLS.add("/article/valid/.*");
		URLS.add("/article/cancelvalid/.*");
		URLS.add("/ad/modify.*");
		URLS.add("/ad/delete.*");
		URLS.add("/link/modify.*");
		URLS.add("/link/delete.*");
		URLS.add("/index/staticize.*");
	}
	
	@Override
	public void afterCompletion(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, Exception arg3) throws Exception {
		// 最后执行，可用于释放资源；可以根据ex是否为null判断是否发生了异常，进行日志记录
		if (exclude(arg0)) {
			final String realPath = Configuration.getRealPath();
			staticize = false;
			SystemContext.getExecutorService().execute(new Runnable() {
				@Override
				public void run() {
					Map<String, Object> roots = cmsHandler.index();
					FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(roots, "/WEB-INF/ftl/www/template/head.ftl", realPath+File.separator+"head.html");
					FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(roots, "/WEB-INF/ftl/www/template/foot.ftl", realPath+File.separator+"foot.html");
					FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(roots, "/WEB-INF/ftl/www/template/left.ftl", realPath+File.separator+"left.html");
					FreemarkerUtil.getInstance(freemarkerConfig).htmlFile(roots, "/WEB-INF/ftl/www/template/index.ftl", realPath+File.separator+"index.html");
				}
			});
		}
	}

	@Override
	public void postHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2, ModelAndView arg3) throws Exception {
	}

	@Override
	public boolean preHandle(HttpServletRequest arg0, HttpServletResponse arg1, Object arg2) throws Exception {
		return true;
	}
	
	private boolean exclude(HttpServletRequest arg0) {
		if (URLS != null) {
			for (String exc : URLS) {
				if (Pattern.matches(arg0.getContextPath()+exc, arg0.getRequestURI())) {
					return true;
				}
			}
		}
		if (staticize) {
			return true;
		}
		return false;
	}

	public void setCmsHandler(CmsHandler cmsHandler) {
		this.cmsHandler = cmsHandler;
	}

	public void setFreemarkerConfig(FreeMarkerConfigurer freemarkerConfig) {
		this.freemarkerConfig = freemarkerConfig;
	}

}
