package com.thanone.zdemo.service.user;

import java.util.List;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.thanone.zdemo.entity.user.User;
import com.thanone.zdemo.mapper.user.UserMapper;
import com.zcj.web.dto.ServiceResult;
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
	public ServiceResult login(String username, String password) {
		if (StringUtils.isBlank(username) || StringUtils.isBlank(password)) {
			return ServiceResult.initError("账号或密码不能为空！");
		}
		List<User> ulist = find(null, initQbuilder(new String[]{"username", "password"}, new Object[]{username.trim(), password.trim()}), null);
		if (ulist != null && ulist.size() > 0) {
			User u = ulist.get(0);
			if (u.getState() == null || u.getState() != 1) {
				return ServiceResult.initError("账号被冻结，请联系管理员！");
			}
			return ServiceResult.initSuccess(u);
		}
		return ServiceResult.initError("账号或密码错误！");
	}

	@Override
	public void updatePassword(Long userid, String newpassword) {
		userMapper.updatePassword(userid, newpassword);
	}

	@Override
	public void updateState(Long id, Integer i) {
		userMapper.updateState(id, i);
	}

}
