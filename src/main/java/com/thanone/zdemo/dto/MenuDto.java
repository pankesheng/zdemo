package com.thanone.zdemo.dto;

import java.util.List;

/**
 * 菜单
 * @author zouchongjin@sina.com
 * @data 2015年2月27日
 */
public class MenuDto {

	private String name;
	private String url;
	private List<MenuDto> childs;
	
	public MenuDto() {
		super();
	}
	
	public MenuDto(String name, String url, List<MenuDto> childs) {
		super();
		this.name = name;
		this.url = url;
		this.childs = childs;
	}

	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}
	public List<MenuDto> getChilds() {
		return childs;
	}
	public void setChilds(List<MenuDto> childs) {
		this.childs = childs;
	}
	
}
