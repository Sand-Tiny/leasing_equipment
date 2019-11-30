package com.tianyin.common;

import java.util.List;

import org.springframework.stereotype.Service;

import freemarker.template.TemplateMethodModelEx;
import freemarker.template.TemplateModelException;

@Service
public class PageMethodModel implements TemplateMethodModelEx {

    /***
     * 三个参数 第一个是pageModel, 第二个是当前页，第三个是每页的条数
     */
    @SuppressWarnings({ "rawtypes"})
    public Object exec(List args) throws TemplateModelException {
        if (args == null || args.size() < 3) {
            return "";
        }
        Object arg = args.get(Constant.ZERO);
        if (arg == null) {
            return "";
        }
        int total = 0;
        total = Integer.parseInt(arg + "");
        int page = 1;
        Object pageArg = args.get(Constant.ONE);
        if (pageArg != null) {
            try {
                page = Integer.parseInt(pageArg + "");
            } catch (Exception e) {
            }
        }
        int pageSize = 20;
        Object pageSizeArg = args.get(2);
        if (pageSizeArg != null) {
            try {
                pageSize = Integer.parseInt(pageSizeArg + "");
            } catch (Exception e) {
            }
        }
        if (total < pageSize) {
            return "";
        }
        int totalPage = total / pageSize;
        if (total % pageSize != 0) {
            totalPage += 1;
        }
        int startIndex = 1;
        int endIndex = totalPage + 1;
        if (totalPage > 5 && page > 2) {
            startIndex = page - 2;
        }
        if (totalPage > 5 && page < total - 2) {
            endIndex = totalPage - 2;
        }
        StringBuilder sb = new StringBuilder("<ul class='pagination pull-right'>");
        if (page > Constant.ONE) {
            int prePage = page - 1;
            sb.append("<li><a href='javascript:changePage(" + prePage + ")'>上一页</a></li>");
        }
        for (int index = startIndex; index < endIndex; index++) {
            if (index == page) {
                sb.append("<li class='active'><a href='#" + index + "</a></li>");
            }
            sb.append("<li><a href='javascript:changePage(" + index + ")'>" + index + "</a></li>");
        }
        if (page != totalPage) {
            int nextPage = page + 1;
            sb.append("<li><a href='javascript:changePage(" + nextPage + ")'>下一页</a></li>");
        }
        sb.append("</ul>");
        return sb.toString();
    }
}
