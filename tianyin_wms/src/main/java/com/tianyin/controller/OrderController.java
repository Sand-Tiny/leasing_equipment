package com.tianyin.controller;

import java.io.IOException;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tianyin.common.Constant;
import com.tianyin.common.PageMethodModel;
import com.tianyin.domain.Inventory;
import com.tianyin.domain.Order;
import com.tianyin.domain.OrderItem;
import com.tianyin.domain.PageModel;
import com.tianyin.domain.Summarize;
import com.tianyin.service.InventoryService;
import com.tianyin.service.OrderItemService;
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
    private OrderItemService orderItemService;
    @Autowired
    private InventoryService inventoryService;
    @Autowired
    private PageMethodModel pageMethodModel;
    
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
                if (item == null) {
                    iterator.remove();
                    continue;
                }
                if (item.getInventoryId() == null) {
                    iterator.remove();
                    continue;
                }
                if (item.getQuantity() == null) {
                    iterator.remove();
                    continue;
                }
                if (item.getPrice() == null) {
                    iterator.remove();
                    continue;
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
        if (startDate == null) {
            startDate = getToday();
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
        map.put("pg", pageMethodModel);
        return "/order/list";
    }
    
    @RequestMapping("/export")
    public void export(Date startDate, Date endDate, String consumerName, Integer status, HttpServletResponse response) throws IOException {
        response.setHeader("Content-Disposition", "attachment; filename=" + new String("导出文件".getBytes("gb2312"), "iso8859-1")+".xlsx");
        response.setHeader("Pragma", "public");
        response.setHeader("Cache-Control", "must-revalidate, post-check=0, pre-check=0");
        response.setHeader("Content-Transfer-Encoding", "binary");
        response.setContentType("application/vnd.ms-excel;charset=UTF-8");
        response.setCharacterEncoding("UTF-8");
        if (startDate == null) {
            startDate = getToday();
        }
        PageModel<Order> orders = orderService.query(startDate, endDate, consumerName, status, null, null);
        ServletOutputStream os = response.getOutputStream();
        HSSFWorkbook hw = new HSSFWorkbook();
        HSSFSheet sheet = hw.createSheet();
        List<Order> data = orders.getData();
        if (data == null || data.isEmpty()) {
            hw.write(os);
            os.close();
            hw.close();
            return;
        }
        DateFormat dataFormat = new SimpleDateFormat("yyyy-MM-dd");
        for (int i = 0; i < data.size(); i ++) {
            Order order = data.get(i);
            HSSFRow row = sheet.createRow(i);
            HSSFCell cell = row.createCell(0);
            cell.setCellValue(order.getConsumerName()+"("+ dataFormat.format(order.getAppointDate()) + ")");
            cell = row.createCell(1);
            cell.setCellValue(order.getSumMoney());
            List<OrderItem> items = order.getItems();
            if (items == null || items.isEmpty()) {
                continue;
            }
            for (int index = 2; index < items.size() + 2; index ++) {
                OrderItem item = items.get(index - 2);
                cell = row.createCell(index);
                cell.setCellValue(item.getInventoryName() + "(" + item.getQuantity() + ")");
            }
        }
        hw.write(os);
        os.close();
        hw.close();
    }
    private Date getToday() {
        try {
            return new SimpleDateFormat("yyyy-MM-dd").parse(new SimpleDateFormat("yyyy-MM-dd").format(new Date()));
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return null;
    }

    @ResponseBody
    @RequestMapping("/updateStatus")
    public int updateStatus(Integer orderId, Integer status, HttpServletRequest request, ModelMap map) {
        if (orderId == null || orderId.intValue() < Constant.ONE) {
            return 0;
        }
        if (status == null || status < Constant.ONE) {
            return 0;
        }
        return orderService.updateStatus(orderId, status);
    }
    
    @ResponseBody
    @RequestMapping("/updateItem")
    public int updateItem(OrderItem orderItem) {
        if (orderItem == null) {
            return 0;
        }
        if (orderItem.getOrderId() == 0) {
            return 0;
        }
        if (orderItem.getInventoryId() == null) {
            return 0;
        }
        return orderItemService.update(orderItem);
    }
    
    @ResponseBody
    @RequestMapping("/addItem")
    public int addItem(OrderItem orderItem) {
        if (orderItem == null) {
            return 0;
        }
        if (orderItem.getOrderId() == 0) {
            return 0;
        }
        if (orderItem.getInventoryId() == null) {
            return 0;
        }
        if (orderItem.getQuantity() == null || orderItem.getQuantity() < 1) {
            return 0;
        }
        return orderItemService.addItems(orderItem.getOrderId(), Arrays.asList(orderItem));
    }
    
    @ResponseBody
    @RequestMapping("/deleteItem")
    public int deleteItem(int orderId, int inventoryId) {
        if (orderId < 1) {
            return 0;
        }
        if (inventoryId < 1) {
            return 0;
        }
        return orderItemService.deleteItem(orderId, inventoryId);
    }
}
