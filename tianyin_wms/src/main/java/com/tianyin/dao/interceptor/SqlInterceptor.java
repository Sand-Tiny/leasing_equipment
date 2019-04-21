/* 
 * 创建日期 2012-8-30
 *
 * 成都澳乐科技有限公司
 * 电话：028-85253121 
 * 传真：028-85253121
 * 邮编：610041 
 * 地址：成都市武侯区航空路6号丰德国际D3 1002
 * 版权所有
 */
package com.tianyin.dao.interceptor;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Locale;
import java.util.Properties;

import org.apache.ibatis.executor.Executor;
import org.apache.ibatis.mapping.BoundSql;
import org.apache.ibatis.mapping.MappedStatement;
import org.apache.ibatis.mapping.ParameterMapping;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.session.Configuration;
import org.apache.ibatis.session.ResultHandler;
import org.apache.ibatis.session.RowBounds;
import org.apache.ibatis.type.TypeHandlerRegistry;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

 
/**
 * Sql拦截器
 * 
 * @author 王文成
 * @version 1.0
 */
@Intercepts({
        @Signature(type = Executor.class, method = "update", args = { MappedStatement.class, Object.class }),
        @Signature(type = Executor.class, method = "query", args = { MappedStatement.class, Object.class,
                RowBounds.class, ResultHandler.class }) })
public class SqlInterceptor implements Interceptor {
	
	private static final Logger log = LoggerFactory.getLogger("db");
	
	/** 插件参数 @see applicationContext-core.xml org.mybatis.spring.SqlSessionFactoryBean*/
	private boolean printSql;
	public Object intercept(Invocation invocation) throws Throwable {
        long start = System.currentTimeMillis();
        Object returnValue = invocation.proceed();
        long end = System.currentTimeMillis();
        long time = (end - start);//计算调用耗时毫秒
//    	if( printSql ){//输出SQL判断
    		MappedStatement mappedStatement = (MappedStatement) invocation.getArgs()[0];
    		Object parameter = null;
            if (invocation.getArgs().length > 1) {
                parameter = invocation.getArgs()[1];
            }
    		String sqlId = mappedStatement.getId();
            BoundSql boundSql = mappedStatement.getBoundSql(parameter);
            Configuration configuration = mappedStatement.getConfiguration();
            List<Object> params = getRuntimeParams(configuration, boundSql);//查询参数
            //id:mappedStatement.getId() , sql:boundSql.getSql(), params:运行时参数  time:耗时ms
            //{"id":"queryUser", "sql":"select...","params":"[1,2,3,4]","time":20}
            if( printSql ) {
            	String sql = getRuntimeSql(boundSql, params);
            	print(sqlId, sql, time);//输入SQL
            }
//    	}
        return returnValue;
    }
 
    /**
     * 打印SQL日志
     * @param configuration
     * @param boundSql
     * @param sqlId
     * @param time
     * @return
     */
    private void print(String sqlId, String sql, long time) {
        StringBuilder info = new StringBuilder(sql.length() + 128);
        DateFormat format = DateFormat.getDateTimeInstance(DateFormat.DEFAULT, DateFormat.DEFAULT, Locale.CHINA);
        info.append( format.format(new Date()) + " [" + sqlId + "] cost " + time + " ms\n");
        info.append( sql + "\n");
        log.info(info.toString());
    }
 
    /**
     * 取得运行时的SQL 替换对应的参数
     * @param boundSql 
     * @param params
     * @return
     */
    public static String getRuntimeSql(BoundSql boundSql, List<Object> params) {
        String sql = boundSql.getSql();
        for (Object object : params) {
        	sql = sql.replaceFirst("\\?", getParameterValue(object));
		}
        return sql;
    }
    
    /**
     * 取得运行时的参数
     * @param configuration 
     * @param boundSql
     * @return
     */
    public static List<Object> getRuntimeParams(Configuration configuration, BoundSql boundSql) {
    	List<Object> params = new ArrayList<Object>();
        Object parameterObject = boundSql.getParameterObject();
        List<ParameterMapping> parameterMappings = boundSql.getParameterMappings();
        if (parameterMappings.size() > 0 && parameterObject != null) {
            TypeHandlerRegistry typeHandlerRegistry = configuration.getTypeHandlerRegistry();
            if (typeHandlerRegistry.hasTypeHandler(parameterObject.getClass())) {
                params.add(parameterObject);
            } else {
                MetaObject metaObject = configuration.newMetaObject(parameterObject);
                for (ParameterMapping parameterMapping : parameterMappings) {
                    String propertyName = parameterMapping.getProperty();
                    if (metaObject.hasGetter(propertyName)) {
                        Object obj = metaObject.getValue(propertyName);
                        params.add(obj);
                    } else if (boundSql.hasAdditionalParameter(propertyName)) {
                        Object obj = boundSql.getAdditionalParameter(propertyName);
                        params.add(obj);
                    }
                }
            }
        }
        return params;
    }
    
    /**
     * 取得参数值
     * @param obj
     * @return
     */
    private static String getParameterValue(Object obj) {
        String value = "";
        if (obj instanceof String) {
            value = "'" + obj+ "'";
        } else if (obj instanceof Date) {
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            value = "'" + formatter.format((Date)obj) + "'";
        } else if (obj != null) {
        	value = obj.toString();
        }	
        return value;
    }
 
    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }
    

    public void setProperties(Properties properties) {
    }
	
	/**允许输出SQL*/
    public void setPrintSql(String printSql) {
		this.printSql = "true".equals(printSql);
	}
}