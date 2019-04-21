package com.tianyin.controller;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;

import com.tianyin.common.Constant;
import com.tianyin.domain.Inventory;
import com.tianyin.domain.Order;
import com.tianyin.domain.OrderItem;
import com.tianyin.domain.PageModel;
import com.tianyin.domain.Summarize;
import com.tianyin.service.InventoryService;
import com.tianyin.service.OrderService;
/**
 * 订单管理
 * @author Tiny.Liu
 *
 */
@RequestMapping("/order")
@Controller
public class OrderController {
    @Autowired
    private OrderService orderService;
    @Autowired
    private InventoryService inventoryService;
    
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
        dateFormat.setLenient(false);
        binder.registerCustomEditor(Date.class, new CustomDateEditor(dateFormat, true));//true:允许输入空值，false:不能为空值
    }
    
    @RequestMapping(value = "/save")
    public String save(Order order, HttpServletRequest request, ModelMap map) {
        if (order == null) {
            return "redirect:/order/query";
        }
        if (order.getItems() != null) {
            for (Iterator<OrderItem> iterator = order.getItems().iterator();iterator.hasNext();) {
                OrderItem item = iterator.next();
                if (item == null || item.getInventoryId() < Constant.ONE || item.getQuantity() < Constant.ONE) {
                    iterator.remove();
                }
            }
        }
        int result = Constant.ZERO;
        if (order.getOrderId() > Constant.ZERO) {
            result = orderService.update(order);
        } else {
            order.setCreateTime(new Date());
            result = orderService.add(order);
        }
        map.put("result", result);
        return "redirect:/order/query";
    }
    @RequestMapping("/query")
    public String query(Date startDate, Date endDate, String consumerName, Integer status, Integer page, Integer pageSize, ModelMap map) {
        if (page == null || page.intValue() < Constant.ONE) {
            page = Constant.ONE;
        }
        if (pageSize == null || pageSize.intValue() < Constant.ONE) {
            pageSize = Constant.DEFAULT_PAGESIZE;
        }
        int start = (page - Constant.ONE) * pageSize;
        int limit = pageSize;
        PageModel<Order> orders = orderService.query(startDate, endDate, consumerName, status, start, limit);
        Summarize summarize = orderService.getSummarize(startDate, endDate, consumerName, status);
        List<Inventory> inventorys = inventoryService.getAllInventoryList();
        map.put("inventorys", inventorys);
        map.put("orders", orders);
        map.put("summarize", summarize);
        map.put("startDate", startDate);
        map.put("endDate", endDate);
        map.put("consumerName", consumerName);
        map.put("status", status);
        map.put("page", page);
        map.put("pageSize", pageSize);
        return "/order/list";
    }
    @RequestMapping("/updateStatus")
    public String updateStatus(Integer orderId, Integer status, HttpServletRequest request, ModelMap map) {
        if (orderId == null || orderId.intValue() < Constant.ONE) {
            return "redirect:/order/query";
        }
        if (status == null || status < Constant.ONE) {
            return "redirect:/order/query";
        }
        int result = orderService.updateStatus(orderId, status);
        map.put("result", result);
        return "redirect:/order/query";
    }

}
