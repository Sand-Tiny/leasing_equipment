package com.tianyin.controller;

import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.tianyin.common.Constant;
import com.tianyin.domain.InventoriesInfo;
import com.tianyin.domain.Inventory;
import com.tianyin.service.InventoryService;
/**
 * 库存管理
 * @author Tiny.Liu
 *
 */
@RequestMapping("/inventory")
@Controller
public class InventoryController {
    
    @Autowired
    private InventoryService inventoryService;
    
    @RequestMapping("/adds")
    public String adds(InventoriesInfo inventoriesInfo, HttpServletRequest request, ModelMap map) {
        if (inventoriesInfo == null) {
            return "redirect:/inventory/all";
        }
        List<Inventory> inventories = inventoriesInfo.getInventories();
        if (inventories == null || inventories.size() < Constant.ONE) {
            return "redirect:/inventory/all";
        }
        for (Iterator<Inventory> iterator = inventories.iterator();iterator.hasNext();) {
            Inventory inventory = iterator.next();
            if (inventory.getName() == null || inventory.getName().trim().length() == 0) {
                iterator.remove();
                continue;
            }
            if (inventory.getStock() == null) {
                iterator.remove();
                continue;
            }
            if (inventory.getPrice() == null) {
                iterator.remove();
                continue;
            }
        }
        inventoryService.adds(inventories);
        return "redirect:/inventory/all";
    }
    
    @RequestMapping("/all")
    public String all(HttpServletRequest request, ModelMap map, HttpSession session) {
        if (session.getAttribute("role") == null) {
            return "redirect:/order/query";
        }
        String role = session.getAttribute("role").toString();
        if (!"admin".equalsIgnoreCase(role)) {
            return "redirect:/order/query";
        }
        List<Inventory> inventories = inventoryService.getAllInventoryList();
        map.put("inventories", inventories);
        return "/inventory/list";
    }
    @RequestMapping("/del")
    public String del(Integer inventoryId, HttpServletRequest request, ModelMap map) {
        if (inventoryId == null || inventoryId.intValue() < Constant.ONE) {
            return "redirect:/inventory/all";
        }
        inventoryService.delete(inventoryId.intValue());
        return "redirect:/inventory/all";
    }
    @ResponseBody
    @RequestMapping("/update")
    public int update(Inventory inventory, HttpServletRequest request, ModelMap map) {
        if (inventory.getId() < Constant.ONE) {
            return Constant.ZERO;
        }
        return inventoryService.update(inventory);
    }

}
