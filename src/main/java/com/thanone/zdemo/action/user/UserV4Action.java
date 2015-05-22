package com.thanone.zdemo.action.user;

import java.io.PrintWriter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.apache.commons.lang3.StringUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

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

	@RequestMapping("/password")
	public String password(Model model) {
		return "/WEB-INF/ftl/admin_v4/user/user_password.ftl";
	}
	
}
