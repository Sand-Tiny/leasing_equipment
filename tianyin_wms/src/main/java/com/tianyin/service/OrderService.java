package com.tianyin.service;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tianyin.common.Constant;
import com.tianyin.dao.TianyinBaseDao;
import com.tianyin.domain.Order;
import com.tianyin.domain.OrderItem;
import com.tianyin.domain.PageModel;
import com.tianyin.domain.Summarize;

@Service
public class OrderService {

    @Autowired
    private TianyinBaseDao dao;
    @Autowired
    private OrderItemService orderItemService;
    public int add(Order order) {
        int result = Constant.ZERO;
        if (order == null) {
            return result;
        }
        result = dao.insert("order.add", order);
        if (result < Constant.ONE) {
            return result;
        }
        orderItemService.addOrderItems(order.getOrderId(), order.getItems());
        return result;
    }

    public int update(Order order) {
        int result = Constant.ZERO;
        if (order == null || order.getOrderId() < Constant.ONE) {
            return result;
        }
        result = dao.update("order.update", order);
        if (result < Constant.ONE) {
            return result;
        }
        orderItemService.addOrderItems(order.getOrderId(), order.getItems());
        return result;
    }

    public int updateStatus(Integer orderId, Integer status) {
        int result = Constant.ZERO;
        if (orderId == null || orderId.intValue() < Constant.ONE) {
            return result;
        }
        if (status == null || status.intValue() < Constant.ONE) {
            return result;
        }
        Map<String, Object> whereParams = new HashMap<String, Object>();
        whereParams.put("orderId", orderId);
        whereParams.put("status", status);
        result = dao.update("order.updateStatus", whereParams);
        return result;
    }

    public PageModel<Order> query(Date startDate, Date endDate, String consumerName, Integer status, Integer start, Integer limit) {
        PageModel<Order> result = new PageModel<Order>();
        if (start != null && limit != null && limit.intValue() < Constant.ONE) {
            return result;
        }
        Map<String, Object> whereParams = new HashMap<String, Object>();
        whereParams.put("startDate", startDate);
        whereParams.put("endDate", endDate);
        whereParams.put("consumerName", consumerName);
        whereParams.put("status", status);
        whereParams.put("start", start);
        whereParams.put("limit", limit);
        int total = dao.queryForObject("order.getCount", whereParams);
        if (total < Constant.ONE) {
            return result;
        }
        result.setTotal(total);
        if (start != null && limit != null && start.intValue() >= total) {
            return result;
        }
        List<Order> data = dao.queryForList("order.query", whereParams);
        Map<Date, Map<Integer, OrderItem>> dayBookQuantity = orderItemService.getDayBookQuantity(startDate, endDate);
        wrapOrderItem(data, dayBookQuantity);
        result.setData(data);
        return result;
    }

    private void wrapOrderItem(List<Order> data, Map<Date, Map<Integer, OrderItem>> dayBookQuantity) {
        if (data == null || data.size() < Constant.ONE) {
            return ;
        }
        Set<Integer> orderIds = new HashSet<Integer>();
        for (Order order : data) {
            int orderId = order.getOrderId();
            orderIds.add(orderId);
        }
        Map<Integer, List<OrderItem>> items = orderItemService.queryItems(new ArrayList<Integer>(orderIds));
        for (Order order : data) {
            int orderId = order.getOrderId();
            List<OrderItem> orderItems = items.get(orderId);
            Date appointDate = order.getAppointDate();
            wrapBookQuantity(orderItems, dayBookQuantity.get(appointDate));
            double sumMoney = getSumMoney(orderItems);
            order.setSumMoney(sumMoney);
            order.setItems(orderItems);
        }
    }

    private void wrapBookQuantity(List<OrderItem> orderItems, Map<Integer, OrderItem> bookQuantity) {
        if (orderItems == null || bookQuantity == null) {
            return;
        }
        for (OrderItem orderItem : orderItems) {
            Integer inventoryId = orderItem.getInventoryId();
            OrderItem bookItem = bookQuantity.get(inventoryId);
            int totalQuantity = orderItem.getTotalQuantity();
            if (bookItem == null) {
                orderItem.setRemanQuantity(totalQuantity);
                continue;
            }
            int bookedQuantity = bookItem.getBookQuantity();
            orderItem.setBookQuantity(bookedQuantity);
            orderItem.setRemanQuantity(totalQuantity - bookedQuantity);
        }
    }

    private double getSumMoney(List<OrderItem> orderItems) {
        if (orderItems == null || orderItems.size() < Constant.ONE) {
            return Constant.ZERO;
        }
        double result = Constant.ZERO;
        for (OrderItem orderItem : orderItems) {
            result += orderItem.getSubtotal();
        }
        return result;
    }

    public Summarize getSummarize(Date startDate, Date endDate, String consumerName, Integer status) {
        Map<String, Object> whereParams = new HashMap<String, Object>();
        whereParams.put("startDate", startDate);
        whereParams.put("endDate", endDate);
        whereParams.put("consumerName", consumerName);
        whereParams.put("status", status);
        Summarize summarize = new Summarize();
        Summarize countDetail = dao.queryForObject("order.getCountDetail", whereParams);
        Summarize moneyDetail = dao.queryForObject("order.getMoneyDetail", whereParams);
        summarize.setTotalCount(countDetail.getTotalCount());
        summarize.setPaidCount(countDetail.getPaidCount());
        summarize.setNotpaidCount(countDetail.getNotpaidCount());
        if (moneyDetail == null) {
            return summarize;
        }
        summarize.setTotalMoney(moneyDetail.getTotalMoney());
        summarize.setPaidMoney(moneyDetail.getPaidMoney());
        summarize.setNotpaidMoney(moneyDetail.getNotpaidMoney());
        return summarize;
    }

}
