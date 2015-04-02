package com.thanone.zdemo.dto;

import java.util.ArrayList;
import java.util.List;

import com.thanone.zdemo.entity.user.User;
import com.zcj.util.poi.excel.ExcelResources;

/**
 * 导出Excel辅助类
 * 
 * @author zouchongjin@sina.com
 * @data 2014年3月31日
 */
public class ExportExcelUserDto {
	
	public static final String FILENAME_TEMPLAT = "template1.xls";// 源文件名（不要用英文，不然打包的时候文件名会乱码）
	public static final String FILENAME_EXPORT = "用户账号.xls";// 导出的文件名

	private String xh;
	private String realname;// 真实姓名
	private String username;
	private String password;
	private String role;// 角色（1：超级管理员；2：普通用户）
	private String state;// 状态（1：可见；0：不可见）
	
	public static List<ExportExcelUserDto> byEntityList(List<User> userList) {
		if (userList == null || userList.size() == 0) {
			return new ArrayList<ExportExcelUserDto>();
		}
		List<ExportExcelUserDto> list = new ArrayList<ExportExcelUserDto>();
		
		int xh = 1;
		for (User ws : userList) {
			ExportExcelUserDto s = new ExportExcelUserDto();
			s.setXh(String.valueOf(xh++));
			s.setRealname(ws.getRealname());
			s.setUsername(ws.getUsername());
			s.setPassword(ws.getPassword());
			if (1 == ws.getRole()) {
				s.setRole("超级管理员");
			} else if (2 == ws.getRole()) {
				s.setRole("普通用户");
			}
			if (1 == ws.getState()) {				
				s.setState("启用");
			} else {
				s.setState("冻结");
			}
			list.add(s);
		}

		return list;
	}

	@ExcelResources(order = 1)
	public String getXh() {
		return xh;
	}

	public void setXh(String xh) {
		this.xh = xh;
	}

	@ExcelResources(order = 2)
	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	@ExcelResources(order = 3)
	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	@ExcelResources(order = 4)
	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	@ExcelResources(order = 5)
	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	@ExcelResources(order = 6)
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

}
