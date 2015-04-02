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

	@RequestMapping("/container")
	public String container(Model model) {
		return "/WEB-INF/ftl/admin/container.ftl";
	}

	@RequestMapping("/index")
	public String index(Model model) {
		return "/WEB-INF/ftl/admin/index.ftl";
	}

	@RequestMapping("/left")
	public String left(Model model) {
		return "/WEB-INF/ftl/admin/left.ftl";
	}
	
	@RequestMapping("/main")
	public String main(Model model) {
		return "/WEB-INF/ftl/admin/main.ftl";
	}
	
	@RequestMapping("/top")
	public String top(Model model) {
		return "/WEB-INF/ftl/admin/top.ftl";
	}

	// 登陆后的菜单列表
	@RequestMapping("/menu")
	public void menu(HttpServletRequest request, PrintWriter out) {
		
		Integer role = WebContext.getLoginUserRole(request);

		// 设置
		MenuDto m31 = new MenuDto("账号管理", Configuration.getContextPath() + "/user/tolist.do", null);
		MenuDto m33 = new MenuDto("修改密码", Configuration.getContextPath() + "/user/password.do", null);
		MenuDto m34 = new MenuDto("注销", Configuration.getContextPath() + "/user/logout.do", null);

		List<MenuDto> m3List = new ArrayList<MenuDto>();
		if (User.ROLE_ADMIN.equals(role)) {			
			m3List.add(m31);
		}
		m3List.add(m33);
		m3List.add(m34);
		MenuDto m3 = new MenuDto("设置", "#", m3List);

		List<MenuDto> mList = new ArrayList<MenuDto>();
		mList.add(m3);
		MenuDto m = new MenuDto("功能列表", "#", mList);

		List<MenuDto> menu = new ArrayList<MenuDto>();
		menu.add(m);

		String result = ServiceResult.initSuccessJson(menu);
		out.write(result);
	}

}
