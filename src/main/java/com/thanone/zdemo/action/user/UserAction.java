package com.thanone.zdemo.action.user;

import java.io.File;
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

import com.thanone.zdemo.common.Configuration;
import com.thanone.zdemo.common.WebContext;
import com.thanone.zdemo.common.ZwPageResult;
import com.thanone.zdemo.dto.ExportExcelUserDto;
import com.thanone.zdemo.entity.user.User;
import com.thanone.zdemo.service.user.UserService;
import com.zcj.util.UtilString;
import com.zcj.util.poi.excel.ExcelUtil;
import com.zcj.web.dto.DownloadResult;
import com.zcj.web.dto.ServiceResult;
import com.zcj.web.springmvc.action.BasicAction;

@Controller
@RequestMapping("/user")
@Scope("prototype")
@Component("userAction")
public class UserAction extends BasicAction {

	@Resource
	private UserService userService;

	@RequestMapping("/login")
	public void login(HttpServletRequest request, String username, String password, PrintWriter out) {
		ServiceResult sr = userService.login(username, password);
		if (sr.success()) {
			User u = (User) sr.getD();
			WebContext.updateLoginUser(request, u);
		}
		out.write(ServiceResult.GSON_DT.toJson(sr));
	}

	@RequestMapping("/logout")
	public String logout(HttpServletRequest request) {
		WebContext.removeLoginUserAndSession(request);
		return "/login.jsp";
	}

	@RequestMapping("/tolist")
	public String tolist(Model model) {

		return "/WEB-INF/ftl/admin/user/user_list.ftl";
	}

	@RequestMapping("/list")
	public void list(String searchKey, Integer searchRole, Integer searchState, PrintWriter out) {
		Map<String, Object> qbuilder = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(searchKey)) {
			qbuilder.put("realname", "%" + searchKey + "%");
		}
		if (searchRole != null) {
			qbuilder.put("role", searchRole);
		}
		if (searchState != null) {
			qbuilder.put("state", searchState);
		}
		page.setRows(userService.findByPage(null, qbuilder));
		page.setTotal(userService.getTotalRows(qbuilder));
		out.write(ZwPageResult.converByServiceResult(ServiceResult.initSuccess(page)));
	}

	@RequestMapping("/toadd")
	public String toadd(Model model) {
		return "/WEB-INF/ftl/admin/user/user_modify.ftl";
	}

	@RequestMapping("/tomodify/{id}")
	public String tomodify(@PathVariable Long id, Model model) {
		model.addAttribute("obj", userService.findById(id));
		return "/WEB-INF/ftl/admin/user/user_modify.ftl";
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
		return "/WEB-INF/ftl/admin/user/user_password.ftl";
	}

	@RequestMapping("/modify")
	public void modify(HttpServletRequest request, Long id, User obj, PrintWriter out) {
		if (obj == null || StringUtils.isBlank(obj.getUsername())) {
			out.write(ServiceResult.initErrorJson("账号不能为空！"));
			return;
		} else if (StringUtils.isBlank(obj.getPassword())) {
			out.write(ServiceResult.initErrorJson("密码不能为空！"));
			return;
		} else if (StringUtils.isBlank(obj.getRealname())) {
			out.write(ServiceResult.initErrorJson("真实姓名不能为空！"));
			return;
		}

		// 判断用户名是否存在
		if (id == null) {
			int count = userService.getTotalRows(userService.initQbuilder("username", obj.getUsername()));
			if (count > 0) {
				out.write(ServiceResult.initErrorJson("账号已存在，请重新设置！"));
				return;
			}
		} else {
			List<User> ulist = userService.find(null, userService.initQbuilder("username", obj.getUsername()), null);
			if (ulist != null && ulist.size() > 0 && !ulist.get(0).getId().equals(id)) {
				out.write(ServiceResult.initErrorJson("账号已存在，请重新设置！"));
				return;
			}
		}

		// 修改自己的账号信息
		if (id != null && id.equals(WebContext.getLoginUserId(request))) {
			Integer loginRole = WebContext.getLoginUserRole(request);
			if (obj.getState() == null || obj.getState() != 1) {
				out.write(ServiceResult.initErrorJson("必须设置自己的账号为启用状态！"));
				return;
			} else if (User.ROLE_ADMIN.equals(loginRole) && !User.ROLE_ADMIN.equals(obj.getRole())) {
				out.write(ServiceResult.initErrorJson("超级管理员不能自我降职，只能通过其他管理员降职！"));
				return;
			}
		}

		obj.init();
		if (id == null) {
			obj.setId(UtilString.getLongUUID());
			userService.insert(obj);
		} else {
			obj.setId(id);
			userService.update(obj);

			// 如果是修改自己的账号信息，则需要同时修改session中的信息
			if (id.equals(WebContext.getLoginUserId(request))) {
				WebContext.updateLoginUser(request, obj);
			}
		}
		out.write(ServiceResult.initSuccessJson(null));
	}

	@RequestMapping("/valid/{id}")
	public void valid(HttpServletRequest request, @PathVariable Long id, PrintWriter out) {
		userService.updateState(id, 1);
		out.write(ServiceResult.initSuccessJson(null));
	}

	@RequestMapping("/cancelvalid/{id}")
	public void cancelvalid(HttpServletRequest request, @PathVariable Long id, PrintWriter out) {
		userService.updateState(id, 0);
		out.write(ServiceResult.initSuccessJson(null));
	}

	@RequestMapping("/updatepassword")
	public void updatepassword(HttpServletRequest request, String oldpassword, String newpassword, PrintWriter out) {
		if (StringUtils.isBlank(oldpassword) || StringUtils.isBlank(newpassword)) {
			out.write(ServiceResult.initErrorJson("请输入密码！"));
			return;
		} else {
			Long userid = WebContext.getLoginUserId(request);
			if (userid != null) {
				User u = userService.findById(userid);
				if (u != null) {
					if (!oldpassword.trim().equals(u.getPassword())) {
						out.write(ServiceResult.initErrorJson("原密码错误！"));
						return;
					} else {
						userService.updatePassword(userid, newpassword.trim());
						out.write(ServiceResult.initSuccessJson("修改成功！"));
						return;
					}
				}
			}
		}
		out.write(ServiceResult.initErrorJson("操作错误！"));
	}

	@RequestMapping("/export")
	public void export(PrintWriter out) {
		// 查询数据
		Map<String, Object> qbuilder = new HashMap<String, Object>();
		List<User> stList = userService.find(null, qbuilder, null);
		List<ExportExcelUserDto> dtoList = ExportExcelUserDto.byEntityList(stList);

		// 通过模板生成Excel
		String absoluteFile = Configuration.getRealPath() + File.separator + "template" + File.separator
				+ ExportExcelUserDto.FILENAME_TEMPLAT;
		String path = File.separator + "download" + File.separator + UtilString.getUUID() + ".xls";
		String downloadFile = Configuration.getRealPath() + path;
		try {
			ExcelUtil.getInstance().exportObjToExcelByTemplate(null, absoluteFile, downloadFile, dtoList, ExportExcelUserDto.class);
			out.write(ServiceResult.initSuccessJson(new DownloadResult(ExportExcelUserDto.FILENAME_EXPORT, path)));
		} catch (Exception e) {
			e.printStackTrace();
			out.write(ServiceResult.initErrorJson("生成Excel失败"));
		}
	}

}
