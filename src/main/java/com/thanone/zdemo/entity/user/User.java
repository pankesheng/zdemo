package com.thanone.zdemo.entity.user;

import com.zcj.web.mybatis.entity.BasicEntity;

/**
 * 用户
 * 
 * @author ZCJ
 * @data 2013-4-2
 */
public class User extends BasicEntity {

	private static final long serialVersionUID = -576202652932342342L;

	public static final Integer ROLE_ADMIN = 1;
	
	private String username;
	private String password;
	private Integer role;// 角色（1：超级管理员；2：普通用户）

	private String realname;// 真实姓名
	private Integer state;// 状态（1：启用；0：冻结）

	public void init() {
		if (getState() == null || getState() != 1) {
			setState(0);
		}
	}

	public String getRealname() {
		return realname;
	}

	public void setRealname(String realname) {
		this.realname = realname;
	}

	public Integer getState() {
		return state;
	}

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

	public void setState(Integer state) {
		this.state = state;
	}

	public Integer getRole() {
		return role;
	}

	public void setRole(Integer role) {
		this.role = role;
	}

}
