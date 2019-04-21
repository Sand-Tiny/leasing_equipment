package com.tianyin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

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

    @RequestMapping("/save")
    public String save(Inventory inventory, HttpServletRequest request, ModelMap map) {
        if (inventory == null) {
            return "redirect:/inventory/all";
        }
        if (inventory.getId() > Constant.ZERO) {
            inventoryService.update(inventory);
        } else {
            inventoryService.add(inventory);
        }
        return "redirect:/inventory/all";
    }
    
    @RequestMapping("/adds")
    public String adds(InventoriesInfo inventoriesInfo, HttpServletRequest request, ModelMap map) {
        if (inventoriesInfo == null || inventoriesInfo.getInventories() == null || inventoriesInfo.getInventories().size() < Constant.ONE) {
            return "redirect:/inventory/all";
        }
        inventoryService.adds(inventoriesInfo.getInventories());
        return "redirect:/inventory/all";
    }
    
    @RequestMapping("/all")
    public String all(HttpServletRequest request, ModelMap map) {
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
}
