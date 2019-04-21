package com.tianyin.service;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tianyin.common.Constant;
import com.tianyin.dao.TianyinBaseDao;
import com.tianyin.domain.Inventory;
import com.tianyin.domain.OrderItem;
@Service
public class OrderItemService {

    @Autowired
    private TianyinBaseDao dao;
    @Autowired
    private InventoryService inventoryService;
    public int addOrderItems(int orderId, List<OrderItem> items) {
        int result = Constant.ZERO;
        if (items == null || items.size() < Constant.ONE) {
            return result;
        }
        if (orderId < Constant.ONE) {
            return result;
        }
        deleteItemsByOrderId(orderId);
        result = addItems(orderId, items);
        return result;
    }
    private int addItems(int orderId, List<OrderItem> items) {
        int result = Constant.ZERO;
        Map<String, Object> entity = new HashMap<String, Object>();
        entity.put("items", items);
        entity.put("orderId", orderId);
        result = dao.insert("orderItem.addOrderItems", entity);
        return result;
    }
    public int deleteItemsByOrderId(int orderId) {
        int result = Constant.ZERO;
        if (orderId < Constant.ONE) {
            return result;
        }
        Map<String, Object> whereParams = new HashMap<String, Object>();
        whereParams.put("orderId", orderId);
        result = dao.delete("orderItem.deleteItemsByOrderId", whereParams);
        return result;
    }
    
    public List<OrderItem> queryItemByOrderIds(List<Integer> orderIds) {
        List<OrderItem> result = new ArrayList<OrderItem>();
        Map<String, Object> whereParams = new HashMap<String, Object>();
        whereParams.put("orderIds", orderIds);
        result = dao.queryForList("orderItem.queryItemByOrderIds", whereParams);
        if (result == null) {
            result = Collections.emptyList();
        }
        return result;
    }
    
    public Map<Integer, List<OrderItem>> queryItems (List<Integer> orderIds) {
        if (orderIds == null || orderIds.size() < Constant.ONE) {
            return Collections.emptyMap();
        }
        List<OrderItem> items = queryItemByOrderIds(orderIds);
        if (items == null || items.size() < Constant.ONE) {
            return Collections.emptyMap();
        }
        Map<Integer, List<OrderItem>> result = new HashMap<Integer, List<OrderItem>>();
        Map<Integer, Inventory> inventoryMap = inventoryService.getAllInventoryMap();
        for (OrderItem orderItem : items) {
            int orderId = orderItem.getOrderId();
            List<OrderItem> orderItems = result.get(orderId);
            if (orderItems == null) {
                orderItems = new ArrayList<OrderItem>();
            }
            int inventoryId = orderItem.getInventoryId();
            Inventory inventory = inventoryMap.get(inventoryId);
            orderItem.setInventory(inventory);
            orderItem.setSubtotal(orderItem.getPrice() * orderItem.getQuantity());
            orderItems.add(orderItem);
            result.put(orderId, orderItems);
        }
        return result;
    }

}
