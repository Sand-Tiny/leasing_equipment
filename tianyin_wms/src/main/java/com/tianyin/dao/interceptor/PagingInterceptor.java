package com.tianyin.dao.interceptor;

import java.sql.Connection;
import java.util.Properties;

import org.apache.ibatis.executor.statement.RoutingStatementHandler;
import org.apache.ibatis.executor.statement.StatementHandler;
import org.apache.ibatis.plugin.Interceptor;
import org.apache.ibatis.plugin.Intercepts;
import org.apache.ibatis.plugin.Invocation;
import org.apache.ibatis.plugin.Plugin;
import org.apache.ibatis.plugin.Signature;
import org.apache.ibatis.reflection.MetaObject;
import org.apache.ibatis.reflection.factory.DefaultObjectFactory;
import org.apache.ibatis.reflection.factory.ObjectFactory;
import org.apache.ibatis.reflection.wrapper.DefaultObjectWrapperFactory;
import org.apache.ibatis.reflection.wrapper.ObjectWrapperFactory;
import org.apache.ibatis.session.RowBounds;

/**
 * @author ivan
 * @version $Id: PagingInterceptor.java, v 0.1 2015-5-15 下午2:05:17 ivan Exp $
 */
@Intercepts({ @Signature(method = "prepare", type = StatementHandler.class, args = { Connection.class }) })
public class PagingInterceptor implements Interceptor {

    private ObjectFactory objectFactory = new DefaultObjectFactory();
    private ObjectWrapperFactory objectWrapperFactory = new DefaultObjectWrapperFactory();
    
    public Object intercept(Invocation invocation) throws Throwable {

        final RoutingStatementHandler handler = (RoutingStatementHandler) invocation
                .getTarget();
        MetaObject metaStatementHandler = MetaObject.forObject(handler,
                objectFactory, objectWrapperFactory);
        RowBounds rowBounds = (RowBounds) metaStatementHandler
                .getValue("delegate.rowBounds");

        if (rowBounds == null || rowBounds == RowBounds.DEFAULT) {
            return invocation.proceed();
        }

        String originalSql = (String) metaStatementHandler
                .getValue("delegate.boundSql.sql");

        metaStatementHandler.setValue(
                "delegate.boundSql.sql",
                new StringBuilder(originalSql).append(" limit ")
                        .append(rowBounds.getOffset()).append(",")
                        .append(rowBounds.getLimit()).toString());

        metaStatementHandler.setValue("delegate.rowBounds.offset",
                RowBounds.NO_ROW_OFFSET);

        metaStatementHandler.setValue("delegate.rowBounds.limit",
                RowBounds.NO_ROW_LIMIT);

        return invocation.proceed();
    }

    public Object plugin(Object target) {
        return Plugin.wrap(target, this);
    }

    public void setProperties(Properties properties) {
    }

}
