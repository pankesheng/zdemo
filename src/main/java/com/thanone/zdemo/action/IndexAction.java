package com.thanone.zdemo.action;

import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thanone.zdemo.common.Configuration;
import com.thanone.zdemo.common.WebContext;
import com.thanone.zdemo.dto.MenuDto;
import com.thanone.zdemo.entity.user.User;
import com.zcj.web.dto.ServiceResult;
import com.zcj.web.springmvc.action.BasicAction;

@Controller
@RequestMapping("/index")
@Scope("prototype")
@Component("indexAction")
public class IndexAction extends BasicAction {

	@RequestMapping("/index")
	public String index(HttpServletRequest request, Model model) {
		return "/WEB-INF/ftl/admin/index.ftl";
	}

	@RequestMapping("/top")
	public String top(Model model) {
		return "/WEB-INF/ftl/admin/top.ftl";
	}

	@RequestMapping("/container")
	public String container(Model model) {
		return "/WEB-INF/ftl/admin/container.ftl";
	}

	@RequestMapping("/left")
	public String left(Model model) {
		return "/WEB-INF/ftl/admin/left.ftl";
	}

	@RequestMapping("/start")
	public String start(Model model) {
		return "/WEB-INF/ftl/admin/start.ftl";
	}

	// 登录后的菜单列表
	@RequestMapping("/menu")
	public void menu(HttpServletRequest request, PrintWriter out) {

		Integer role = WebContext.getLoginUserRole(request);

		MenuDto m31 = new MenuDto("账号管理", Configuration.getContextPath() + "/user/tolist.do");
		MenuDto m32 = new MenuDto("参数设置", Configuration.getContextPath() + "/user/tolist.do");
		List<MenuDto> m3List = new ArrayList<MenuDto>();
		if (User.ROLE_ADMIN.equals(role)) {
			m3List.add(m31);
			m3List.add(m32);
		}
		MenuDto m3 = new MenuDto("设置", "#", Boolean.TRUE, m3List);

		List<MenuDto> mList = new ArrayList<MenuDto>();
		mList.add(m3);
		MenuDto m = new MenuDto("功能列表", "#", Boolean.TRUE, mList);

		List<MenuDto> menu = new ArrayList<MenuDto>();
		menu.add(m);

		String result = ServiceResult.initSuccessJson(menu);
		out.write(result);
	}

	// 登录后的顶部子应用列表
	@RequestMapping("/menutop")
	public void menutop(HttpServletRequest request, PrintWriter out) {

		MenuDto m1 = new MenuDto("应用1", Configuration.getContextPath() + "/admin/images/icon/icon1.png", "http://www.baidu.com/");
		MenuDto m2 = new MenuDto("应用2", Configuration.getContextPath() + "/admin/images/icon/icon2.png", "http://www.baidu.com/");
		MenuDto m3 = new MenuDto("应用3", Configuration.getContextPath() + "/admin/images/icon/icon3.png", "http://www.baidu.com/");

		List<MenuDto> m3List = new ArrayList<MenuDto>();
		m3List.add(m1);
		m3List.add(m2);
		m3List.add(m3);

		String result = ServiceResult.initSuccessJson(m3List);
		out.write(result);
	}

}
