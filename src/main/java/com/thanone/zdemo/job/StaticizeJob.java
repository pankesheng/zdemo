package com.thanone.zdemo.job;

import java.io.File;
import java.util.Map;

import org.apache.commons.lang3.StringUtils;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.springframework.scheduling.quartz.QuartzJobBean;
import org.springframework.web.servlet.view.freemarker.FreeMarkerConfigurer;

import com.thanone.zdemo.common.Configuration;
import com.thanone.zdemo.handler.CmsHandler;
import com.zcj.util.freemarker.FreemarkerUtil;
import com.zcj.web.context.SystemContext;

/**
 * 静态化的定时任务
 * @author zouchongjin@sina.com
 * @data 2014年8月28日
 */
public class StaticizeJob extends QuartzJobBean {

	private CmsHandler cmsHandler;
	private FreeMarkerConfigurer freemarkerConfig;
	
	@Override
	protected void executeInternal(JobExecutionContext context) throws JobExecutionException {
		final String realPath = Configuration.getRealPath();
		if (StringUtils.isNotBlank(realPath)) {
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
	
	public void setCmsHandler(CmsHandler cmsHandler) {
		this.cmsHandler = cmsHandler;
	}

	public void setFreemarkerConfig(FreeMarkerConfigurer freemarkerConfig) {
		this.freemarkerConfig = freemarkerConfig;
	}

}
