package com.thanone.zdemo.action.user;

import java.io.PrintWriter;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.thanone.zdemo.common.WebContext;
import com.thanone.zdemo.common.ZwPageResult;
import com.thanone.zdemo.entity.user.User;
import com.thanone.zdemo.service.user.UserService;
import com.zcj.web.dto.ServiceResult;
import com.zcj.web.springmvc.action.BasicAction;

@Controller
@RequestMapping("/user4")
@Scope("prototype")
@Component("userV4Action")
public class UserV4Action extends BasicAction {

	@Resource
	private UserService userService;

	@RequestMapping("/tolist")
	public String tolist(Model model) {
		
		return "/WEB-INF/ftl/admin_v4/user/user_list.ftl";
	}

	@RequestMapping("/list")
	public void list(String searchKey, Integer searchRole, Integer searchState, PrintWriter out) {
		Map<String, Object> qbuilder = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(searchKey)) {
			qbuilder.put("realname", "%"+searchKey+"%");
		}
		if (searchRole != null) {
			qbuilder.put("role", searchRole);
		}
		if (searchState != null) {
			qbuilder.put("state", searchState);
		}
		List<User> userList = userService.findByPage(null, qbuilder);
		page.setRows(userList);
		page.setTotal(userService.getTotalRows(qbuilder));
		out.write(ZwPageResult.converByServiceResult(ServiceResult.initSuccess(page)));
	}
	
	@RequestMapping("/toadd")
	public String toadd(Model model) {
		return "/WEB-INF/ftl/admin_v4/user/user_modify.ftl";
	}
	
	@RequestMapping("/tomodify/{id}")
	public String tomodify(@PathVariable Long id, Model model) {
		model.addAttribute("obj", userService.findById(id));
		return "/WEB-INF/ftl/admin_v4/user/user_modify.ftl";
	}
	
	@RequestMapping("/delete")
	public void delete(HttpServletRequest request, Long[] id, PrintWriter out) {
		if (id == null || id.length == 0) {
			out.write(ServiceResult.initErrorJson("请选择需要删除的记录！"));
			return;
		} else if (Arrays.asList(id).contains(WebContext.getLoginUserId(request))) {
			out.write(ServiceResult.initErrorJson("不能删除自己的账号！"));
			return;
		}
		userService.deleteByIds(Arrays.asList(id));
		out.write(ServiceResult.initSuccessJson(null));
	}

	@RequestMapping("/password")
	public String password(Model model) {
		return "/WEB-INF/ftl/admin_v4/user/user_password.ftl";
	}
	
}
