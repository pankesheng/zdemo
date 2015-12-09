package com.thanone.zdemo.service.example;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.thanone.zdemo.entity.example.Example;
import com.thanone.zdemo.mapper.example.ExampleMapper;
import com.zcj.web.mybatis.service.BasicServiceImpl;

@Component("exampleService")
public class ExampleServiceImpl extends BasicServiceImpl<Example, Long, ExampleMapper> implements ExampleService {

	@Autowired
	private ExampleMapper exampleMapper;

	@Override
	protected ExampleMapper getMapper() {
		return exampleMapper;
	}
	
}
