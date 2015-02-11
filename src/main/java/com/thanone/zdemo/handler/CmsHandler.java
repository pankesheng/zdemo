package com.thanone.zdemo.handler;

import java.util.HashMap;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.stereotype.Component;

import com.thanone.zdemo.service.user.UserService;

/**
 * 提供后台的服务供前台调用
 * 
 * @author zouchongjin@sina.com
 * @data 2014年8月22日
 */
@Component("cmsHandler")
public class CmsHandler {

	@Resource
	private UserService userService;

	/** 获取前台首页需要的数据 */
	public Map<String, Object> index() {
		Map<String, Object> result = new HashMap<String, Object>();

		// ...

		return result;
	}

}
