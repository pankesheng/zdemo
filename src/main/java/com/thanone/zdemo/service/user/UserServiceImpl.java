package com.thanone.zdemo.service.user;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.thanone.zdemo.entity.user.User;
import com.thanone.zdemo.mapper.user.UserMapper;
import com.zcj.web.mybatis.service.BasicServiceImpl;

@Component("userService")
public class UserServiceImpl extends BasicServiceImpl<User, Long, UserMapper> implements UserService {

	@Autowired
	private UserMapper userMapper;

	@Override
	protected UserMapper getMapper() {
		return userMapper;
	}

	@Override
	public void updateState(Long id, Integer i) {
		userMapper.updateState(id, i);
	}

}
