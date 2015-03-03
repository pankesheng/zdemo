package com.thanone.zdemo.action.user;

import java.io.File;
import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;
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

import com.thanone.zdemo.common.BuiPageResult;
import com.thanone.zdemo.common.Configuration;
import com.thanone.zdemo.dto.ExportExcelUserDto;
import com.thanone.zdemo.entity.user.User;
import com.thanone.zdemo.service.user.UserService;
import com.zcj.util.UtilDate;
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

	@RequestMapping("/tolist")
	public String tolist(Model model) {
		
		return "/WEB-INF/ftl/admin/user/user_list.ftl";
	}

	@RequestMapping("/list")
	public void list(PrintWriter out) {
		List<User> userList = userService.findByPage(null, null);
		page.setRows(userList);
		page.setTotal(userService.getTotalRows(null));
		out.write(BuiPageResult.converByServiceResult(ServiceResult.initSuccess(page)));
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

	@RequestMapping("/modify")
	public void modify(HttpServletRequest request, Long id, User obj, PrintWriter out) {
		if (obj == null || StringUtils.isBlank(obj.getRealname())) {
			out.write(ServiceResult.initErrorJson("姓名不能为空！"));
			return;
		}
		obj.init();
		if (id == null) {
			obj.setId(UtilString.getLongUUID());
			userService.insert(obj);
		} else {
			obj.setId(id);
			userService.update(obj);
		}
		out.write(ServiceResult.initSuccessJson(null));
	}
	
	@RequestMapping("/delete")
	public void delete(HttpServletRequest request, Long[] ids, PrintWriter out) {
		if (ids == null || ids.length == 0) {
			out.write(ServiceResult.initErrorJson("请选择需要删除的记录！"));
			return;
		}
		userService.deleteByIds(Arrays.asList(ids));
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
	
	@RequestMapping("/export")
	public void export(PrintWriter out) {
		// 查询数据
		Map<String, Object> qbuilder = new HashMap<String, Object>();
		List<User> stList = userService.find(null, qbuilder, null);
		List<ExportExcelUserDto> dtoList = ExportExcelUserDto.byEntityList(stList);
		
		// 通过模板生成Excel
		String absoluteFile = Configuration.getRealPath() + File.separator + "template" + File.separator + ExportExcelUserDto.FILENAME_TEMPLAT;
		String path = File.separator + "download" + File.separator + UtilString.getUUID() + ".xls";
		String downloadFile = Configuration.getRealPath() + path;
		try {
			Map<String, String> datas = new HashMap<String, String>();
			datas.put("title", "这里是标题");
			datas.put("date", UtilDate.SDF_DATETIME.get().format(new Date()));
			datas.put("dep", "这里是额外信息");
			ExcelUtil.getInstance().exportObjToExcelByTemplate(datas, absoluteFile, downloadFile, dtoList, ExportExcelUserDto.class);
			out.write(ServiceResult.initSuccessJson(new DownloadResult(ExportExcelUserDto.FILENAME_EXPORT, path)));
		} catch (Exception e) {
			e.printStackTrace();
			out.write(ServiceResult.initErrorJson("生成Excel失败"));
		}
	}

}
