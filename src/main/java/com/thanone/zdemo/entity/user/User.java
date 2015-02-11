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

	private String realname;// 真实姓名
	private Integer state;// 状态（1：可见；0：不可见）

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

	public void setState(Integer state) {
		this.state = state;
	}
	
}
