package com.thanone.zdemo.action.example;

import java.io.PrintWriter;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
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

import com.thanone.zdemo.common.ZwPageResult;
import com.thanone.zdemo.entity.example.Example;
import com.thanone.zdemo.service.example.ExampleService;
import com.zcj.util.UtilString;
import com.zcj.web.dto.ServiceResult;
import com.zcj.web.springmvc.action.BasicAction;

@Controller
@RequestMapping("/example")
@Scope("prototype")
@Component("exampleAction")
public class ExampleAction extends BasicAction {

	@Resource
	private ExampleService exampleService;

	@RequestMapping("/tolist")
	public String tolist(Model model) {

		return "/WEB-INF/ftl/admin/example/example_list.ftl";
	}

	@RequestMapping("/list")
	public void list(String searchKey, Integer role, Date theTimeBegin, Date theTimeEnd, PrintWriter out) {
		Map<String, Object> qbuilder = new HashMap<String, Object>();
		if (StringUtils.isNotBlank(searchKey)) {
			qbuilder.put("username", "%" + searchKey + "%");
		}
		if (role != null) {
			qbuilder.put("role", role);
		}
		if (theTimeBegin != null) {
			qbuilder.put("theTimeBegin", theTimeBegin);
		}
		if (theTimeEnd != null) {
			qbuilder.put("theTimeEnd", theTimeEnd);
		}
		page.setRows(exampleService.findByPage(null, qbuilder));
		page.setTotal(exampleService.getTotalRows(qbuilder));
		out.write(ZwPageResult.converByServiceResult(ServiceResult.initSuccess(page)));
	}

	@RequestMapping("/toadd")
	public String toadd(Model model) {
		return "/WEB-INF/ftl/admin/example/example_modify.ftl";
	}

	@RequestMapping("/tomodify/{id}")
	public String tomodify(@PathVariable Long id, Model model) {
		model.addAttribute("obj", exampleService.findById(id));
		return "/WEB-INF/ftl/admin/example/example_modify.ftl";
	}

	@RequestMapping("/delete")
	public void delete(HttpServletRequest request, Long[] id, PrintWriter out) {
		if (id == null || id.length == 0) {
			out.write(ServiceResult.initErrorJson("请选择需要删除的记录！"));
			return;
		}
		exampleService.deleteByIds(Arrays.asList(id));
		out.write(ServiceResult.initSuccessJson(null));
	}

	@RequestMapping("/modify")
	public void modify(HttpServletRequest request, Long id, Example obj, PrintWriter out) {
		if (obj == null) {
			out.write(ServiceResult.initErrorJson("操作错误"));
		} else if (UtilString.isBlank(obj.getUsername())) {
			out.write(ServiceResult.initErrorJson("请填写用户名"));
		} else {
			if (id == null) {
				obj.setId(UtilString.getLongUUID());
				exampleService.insert(obj);
			} else {
				obj.setId(id);
				exampleService.update(obj);
			}
			out.write(ServiceResult.initSuccessJson(null));
		}
	}

}
