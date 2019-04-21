package com.tianyin.dao;

import java.util.List;

import org.apache.ibatis.session.RowBounds;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Repository;

@Repository(value = "templetDao")
public class TianyinBaseDao extends TianyinBaseDaoSupport {
	private static final Logger log = LoggerFactory.getLogger("db");

	public int update(String nameSpace, Object whereParams) {
		long s = System.currentTimeMillis();
		int ret = getSqlSession().update(nameSpace, whereParams);
		long e = System.currentTimeMillis();
		if (e - s > 100) {
			if (log.isWarnEnabled())
				log.warn("[MyBatisClient:serve] {}, params=[{}] time={}ms", new Object[] { nameSpace, whereParams, e - s });
		} else {
			if (log.isInfoEnabled())
				log.info("[MyBatisClient:serve] {}, params=[{}] time={}ms", new Object[] { nameSpace, whereParams, e - s });
		}
		return ret;
	}

	public int update(String nameSpace) {
		long s = System.currentTimeMillis();
		int ret = getSqlSession().update(nameSpace);
		long e = System.currentTimeMillis();
		if (e - s > 100) {
			if (log.isWarnEnabled())
				log.warn("[MyBatisClient:serve] {}, time={}ms", new Object[] { nameSpace, e - s });
		} else {
			if (log.isInfoEnabled())
				log.info("[MyBatisClient:serve] {}, time={}ms", new Object[] { nameSpace, e - s });
		}
		return ret;
	}

	public int delete(String nameSpace, Object whereParams) {
		long s = System.currentTimeMillis();
		int ret = getSqlSession().delete(nameSpace, whereParams);
		long e = System.currentTimeMillis();
		if (e - s > 100) {
			if (log.isWarnEnabled())
				log.warn("[MyBatisClient:serve] {}, params=[{}] time={}ms", new Object[] { nameSpace, whereParams, e - s });
		} else {
			if (log.isInfoEnabled())
				log.info("[MyBatisClient:serve] {}, params=[{}] time={}ms", new Object[] { nameSpace, whereParams, e - s });
		}
		return ret;
	}

	public <T> T queryForObject(String nameSpace) {
		long s = System.currentTimeMillis();
		T ret = getSqlSession().selectOne(nameSpace);
		long e = System.currentTimeMillis();
		if (e - s > 100) {
			if (log.isWarnEnabled())
				log.warn("[MyBatisClient:serve] {}, time={}ms", new Object[] { nameSpace, e - s });
		} else {
			if (log.isInfoEnabled())
				log.info("[MyBatisClient:serve] {}, time={}ms", new Object[] { nameSpace, e - s });
		}
		return ret;
	}

	/**
	 * 使用分页查询接口, 会自动追加分页语句
	 * @param nameSpace
	 * @param whereParams
	 * @param rowBounds
	 * @return
	 */
	public <T> List<T> queryForListPagination(String nameSpace, Object whereParams, RowBounds rowBounds) {
		long s = System.currentTimeMillis();
		List<T> ret = getSqlSession().selectList(nameSpace, whereParams, rowBounds);
		long e = System.currentTimeMillis();
		if (e - s > 100) {
			if (log.isWarnEnabled())
				log.warn("[MyBatisClient:serve] {}, params=[{}] time={}ms", new Object[] { nameSpace, whereParams, e - s });
		} else {
			if (log.isInfoEnabled())
				log.info("[MyBatisClient:serve] {}, params=[{}] time={}ms", new Object[] { nameSpace, whereParams, e - s });
		}
		return ret;
	}

	public <T> List<T> queryForList(String nameSpace, Object whereParams) {
		long s = System.currentTimeMillis();
		List<T> ret = getSqlSession().selectList(nameSpace, whereParams);
		long e = System.currentTimeMillis();
		if (e - s > 100) {
			if (log.isWarnEnabled())
				log.warn("[MyBatisClient:serve] {}, params=[{}] time={}ms", new Object[] { nameSpace, whereParams, e - s });
		} else {
			if (log.isInfoEnabled())
				log.info("[MyBatisClient:serve] {}, params=[{}] time={}ms", new Object[] { nameSpace, whereParams, e - s });
		}
		return ret;
	}

	public <T> List<T> queryForList(String nameSpace) {
		long s = System.currentTimeMillis();
		List<T> ret = getSqlSession().selectList(nameSpace);
		long e = System.currentTimeMillis();
		if (e - s > 100) {
			if (log.isWarnEnabled())
				log.warn("[MyBatisClient:serve] {}, time={}ms", new Object[] { nameSpace, e - s });
		} else {
			if (log.isInfoEnabled())
				log.info("[MyBatisClient:serve] {}, time={}ms", new Object[] { nameSpace, e - s });
		}
		return ret;
	}

	public int insert(String nameSpace, Object entity) {
		long s = System.currentTimeMillis();
		int ret = getSqlSession().insert(nameSpace, entity);
		long e = System.currentTimeMillis();
		if (e - s > 100) {
			if (log.isWarnEnabled())
				log.warn("[MyBatisClient:serve] {}, entity=[{}] time={}ms", new Object[] { nameSpace, entity, e - s });
		} else {
			if (log.isInfoEnabled())
				log.info("[MyBatisClient:serve] {}, entity=[{}] time={}ms", new Object[] { nameSpace, entity, e - s });
		}
		return ret;
	}

	public <T> T queryForObject(String nameSpace, Object whereParams) {
		long s = System.currentTimeMillis();
		T ret = getSqlSession().selectOne(nameSpace, whereParams);
		long e = System.currentTimeMillis();
		if (e - s > 100) {
			if (log.isWarnEnabled())
				log.warn("[MyBatisClient:serve] {}, params=[{}] time={}ms", new Object[] { nameSpace, whereParams, e - s });
		} else {
			if (log.isInfoEnabled())
				log.info("[MyBatisClient:serve] {}, params=[{}] time={}ms", new Object[] { nameSpace, whereParams, e - s });
		}
		return ret;
	}
}
