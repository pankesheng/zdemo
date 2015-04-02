package com.thanone.zdemo.service.user;

import com.thanone.zdemo.entity.user.User;
import com.zcj.web.dto.ServiceResult;
import com.zcj.web.mybatis.service.BasicService;

public interface UserService extends BasicService<User, Long> {

	ServiceResult login(String username, String password);

	void updatePassword(Long userid, String newpassword);
	
	void updateState(Long id, Integer i);
	
}
