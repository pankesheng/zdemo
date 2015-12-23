package com.thanone.zdemo.entity.example;

import java.util.Date;

import com.zcj.util.coder.database.TableColumn;
import com.zcj.util.coder.database.TableColumnType;
import com.zcj.util.coder.query.QueryColumnType;
import com.zcj.web.mybatis.entity.BasicEntity;

/**
 * 基础示例
 * 
 * @author ZCJ
 * @data 2015-12-08
 */
public class Example extends BasicEntity {

	private static final long serialVersionUID = -576202652932342342L;

	@TableColumnType(nullable = false)
	@QueryColumnType("=")
	private String username;// 用户名

	@TableColumnType(nullable = false)
	@QueryColumnType("=")
	private String password;// 密码

	@TableColumnType(length = 1000)
	private String url;// URL地址

	@TableColumnType(length = TableColumn.LENGTH_MAX_STRING)
	private String imgs;// 图片地址集合

	@QueryColumnType("time")
	private Date theTime;// 时间

	@TableColumnType(length = TableColumn.LENGTH_MAX_STRING)
	private String persons;// 人员Key集合

	@QueryColumnType(value = { "=", "in" })
	private Integer role;// 角色（1：超级管理员；2：普通用户）

	@QueryColumnType("=")
	private Integer valid;// 状态（1：有效；0：无效）

	@TableColumnType(length = TableColumn.LENGTH_MAX_STRING)
	@QueryColumnType("like")
	private String descr;// 描述

	@TableColumnType(length = TableColumn.LENGTH_MAX_STRING)
	private String content;// 编辑器内容

	private String show_role;// 角色字符串
	private String show_valid;// 是否有效

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getImgs() {
		return imgs;
	}

	public void setImgs(String imgs) {
		this.imgs = imgs;
	}

	public Date getTheTime() {
		return theTime;
	}

	public void setTheTime(Date theTime) {
		this.theTime = theTime;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public String getPersons() {
		return persons;
	}

	public void setPersons(String persons) {
		this.persons = persons;
	}

	public Integer getRole() {
		return role;
	}

	public void setRole(Integer role) {
		this.role = role;
	}

	public Integer getValid() {
		return valid;
	}

	public void setValid(Integer valid) {
		this.valid = valid;
	}

	public String getDescr() {
		return descr;
	}

	public void setDescr(String descr) {
		this.descr = descr;
	}

	public String getShow_role() {
		return show_role;
	}

	public void setShow_role(String show_role) {
		this.show_role = show_role;
	}

	public String getShow_valid() {
		return show_valid;
	}

	public void setShow_valid(String show_valid) {
		this.show_valid = show_valid;
	}

}
