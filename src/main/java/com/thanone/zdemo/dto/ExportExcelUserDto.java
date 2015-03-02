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
	public static final String FILENAME_EXPORT = "XXXXX用户账号.xls";// 导出的文件名

	private String xh;
	private String realname;// 真实姓名
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
			if (1 == ws.getState()) {				
				s.setState("可见");
			} else {
				s.setState("不可见");
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
	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

}
