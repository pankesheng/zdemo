package com.thanone.zdemo.service.user;

import com.thanone.zdemo.entity.user.User;
import com.zcj.web.mybatis.service.BasicService;

public interface UserService extends BasicService<User, Long> {

	void updateState(Long id, Integer i);
	
}
