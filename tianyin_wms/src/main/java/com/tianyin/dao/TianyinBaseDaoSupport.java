package com.tianyin.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.mybatis.spring.support.SqlSessionDaoSupport;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;

/**
 * 基础DAO
 * 
 * @author MacChen
 * 
 */
public abstract class TianyinBaseDaoSupport extends SqlSessionDaoSupport {
	@Autowired
	@Qualifier(value = "sqlSessionTemplate")
	@Override
	public void setSqlSessionTemplate(SqlSessionTemplate sqlSessionTemplate) {
		super.setSqlSessionTemplate(sqlSessionTemplate);
	}
}
