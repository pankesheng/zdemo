package com.thanone.zdemo.action;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.zcj.web.springmvc.action.BasicAction;

@Controller
@RequestMapping("/index2")
@Scope("prototype")
@Component("index2Action")
public class IndexV2Action extends BasicAction {

	@RequestMapping("/index")
	public String index(HttpServletRequest request, Model model) {
		return "/WEB-INF/ftl/admin_v2/index.ftl";
	}
	
	@RequestMapping("/menu")
	public void menu(PrintWriter out) {
		
		String result = "{\"s\":1,\"d\":[{\"name\":\"基本功能\",\"orders\":1,\"childs\":[{\"pid\":1,\"name\":\"任务管理\",\"url\":\"/module/tolist.do\",\"orders\":1,\"id\":2},{\"pid\":1,\"name\":\"已完成项目\",\"url\":\"/module/tolistfinish.do\",\"orders\":2,\"id\":3}],\"id\":1}]}";
		
		out.write(result);
	}
	
}
