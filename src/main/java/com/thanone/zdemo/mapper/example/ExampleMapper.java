package com.thanone.zdemo.mapper.example;

import com.thanone.zdemo.entity.example.Example;
import com.zcj.web.mybatis.mapper.BasicMapper;
import com.zcj.web.mybatis.mapper.BasicRepository;

@BasicRepository
public interface ExampleMapper extends BasicMapper<Example, Long> {

}
