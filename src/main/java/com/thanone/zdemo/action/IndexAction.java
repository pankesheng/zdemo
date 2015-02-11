package com.thanone.zdemo.action;

import java.io.PrintWriter;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thanone.zdemo.common.WebContext;
import com.thanone.zdemo.entity.user.User;
import com.thanone.zdemo.service.user.UserService;
import com.zcj.web.dto.ServiceResult;
import com.zcj.web.springmvc.action.BasicAction;

@Controller
@RequestMapping("/index")
@Scope("prototype")
@Component("indexAction")
public class IndexAction extends BasicAction {

	@Resource
	private UserService userService;

	@RequestMapping("/index")
	public String index(HttpServletRequest request, Model model) {

		User u = new User();
		u.setId(1L);
		u.setRealname("测试用户");
		WebContext.updateLoginUser(request, u);
		
		return "/WEB-INF/ftl/admin/index.ftl";
	}
	
	@RequestMapping("/container")
	public String container(Model model) {
		return "/WEB-INF/ftl/admin/container.ftl";
	}

	@RequestMapping("/left")
	public String left(Model model) {
		return "/WEB-INF/ftl/admin/left.ftl";
	}

	@RequestMapping("/logout")
	public void logout(HttpServletRequest request, HttpServletResponse response, PrintWriter out) {
		WebContext.removeLoginUserAndSession(request);
		out.write(ServiceResult.initSuccessJson("注销成功"));
	}

	// 登陆后的菜单列表
	@RequestMapping("/menu")
	public void menu(HttpServletRequest request, PrintWriter out) {

		// {\"s\":1,\"d\":[{\"name\":\"功能列表\",\"url\":\"#\",\"childs\":[{\"name\":\"文章信息\",\"url\":\"#\",\"orders\":1,\"childs\":[{\"pid\":30,\"name\":\"信息发布\",\"url\":\"/ohedu/article/toadd.do\",\"orders\":1,\"id\":3010},{\"pid\":30,\"name\":\"信息管理\",\"url\":\"/ohedu/article/tolist.do\",\"orders\":2,\"id\":3011},{\"pid\":30,\"name\":\"文章审核","url":"/ohedu/article/toverifylist.do","orders":3,"id":3012},{"pid":30,"name":"发文统计","url":"/ohedu/article/totjlist.do","orders":4,"id":3013}],"id":30},{"name":"基本设置","url":"#","orders":2,"childs":[{"pid":10,"name":"栏目管理","url":"/ohedu/catalog/tolist.do","orders":1,"id":1010},{"pid":10,"name":"用户组管理","url":"/ohedu/usergroup/tolist.do","orders":2,"id":1011},{"pid":10,"name":"用户管理","url":"/ohedu/user/tolist.do","orders":3,"id":1012},{"pid":10,"name":"广告管理","url":"/ohedu/ad/tolist.do","orders":4,"id":1013},{"pid":10,"name":"友情链接","url":"/ohedu/link/tolist.do","orders":5,"id":1014},{"pid":10,"name":"日志管理","url":"/ohedu/logs/tolist.do","orders":6,"id":1015},{"pid":10,"name":"云平台用户","url":"/ohedu/user/toyunlist.do","orders":7,"id":1016}],"id":10},{"name":"教育专题","url":"#","orders":11,"childs":[{"pid":2011,"name":"模板管理","url":"/ohedu/ztTopicTemplate/tolist.do","orders":1,"id":201111},{"pid":2011,"name":"专题管理","url":"/ohedu/ztTopicList/tolist.do","orders":2,"id":201112},{"pid":2011,"name":"文章管理","url":"/ohedu/ztTopicArticle/tolist.do","orders":3,"id":201113}],"id":2011},{"name":"电脑制作专题","url":"#","orders":12,"childs":[{"pid":2020,"name":"竞赛届次管理","url":"/ohedu/dnCompetition/tolist.do","orders":1,"id":202020},{"pid":2020,"name":"图片渐变管理","url":"/ohedu/dnPicture/tolist.do","orders":2,"id":202021},{"pid":2020,"name":"作品信息管理","url":"/ohedu/dnInformation/tolist.do","orders":3,"id":202025},{"pid":2020,"name":"评比信息管理","url":"/ohedu/dnRatingList/tolist.do","orders":4,"id":202027}],"id":2020},{"name":"多媒体教育专题","url":"#","orders":13,"childs":[{"pid":2030,"name":"竞赛届次管理","url":"/ohedu/dmtCompetition/tolist.do","orders":1,"id":203030},{"pid":2030,"name":"图片渐变管理","url":"/ohedu/dmtPicture/tolist.do","orders":2,"id":203031},{"pid":2030,"name":"作品信息管理","url":"/ohedu/dmtInformation/tolist.do","orders":3,"id":203035},{"pid":2030,"name":"评比信息管理","url":"/ohedu/dmtRatingList/tolist.do","orders":4,"id":203037}],"id":2030}]}]};
		out.write("");
	}

	// 测试用。静态化，实现写在staticzeInterceptor拦截器里
	@RequestMapping("/staticize")
	public void staticize(PrintWriter out) {
		out.write(ServiceResult.initSuccessJson("静态化成功"));
	}
	
}
