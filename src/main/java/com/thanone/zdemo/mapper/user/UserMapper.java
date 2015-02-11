package com.thanone.zdemo.mapper.user;

import org.apache.ibatis.annotations.Param;

import com.thanone.zdemo.entity.user.User;
import com.zcj.web.mybatis.mapper.BasicMapper;
import com.zcj.web.mybatis.mapper.BasicRepository;

@BasicRepository
public interface UserMapper extends BasicMapper<User, Long> {

	void updateState(@Param(ID) Long id, @Param("value") Integer value);
	
}
