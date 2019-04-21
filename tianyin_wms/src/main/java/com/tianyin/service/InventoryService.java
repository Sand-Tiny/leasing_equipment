package com.tianyin.service;

import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.tianyin.common.CacheKeyFactory;
import com.tianyin.common.Constant;
import com.tianyin.dao.TianyinBaseDao;
import com.tianyin.domain.Inventory;
import com.util.cache.CacheFactory;
import com.util.cache.model.ICache;

@Service
public class InventoryService {

//    private final ICache cache = CacheFactory.getLocalCache(CacheKeyFactory.INVENTORY);
    private final ICache cache = CacheFactory.getRedisCache(CacheKeyFactory.INVENTORY);
    
    @Autowired
    private TianyinBaseDao dao;

    private void flushCache() {
        cache.remove(CacheKeyFactory.INVENTORY);
        getAllInventoryList();
    }
    
    public int adds(List<Inventory> inventories) {
        int result = Constant.ZERO;
        Map<String, Object> entity = new HashMap<String, Object>();
        entity.put("inventories", inventories);
        result = dao.insert("inventory.adds", entity);
        if (result > Constant.ZERO) {
            flushCache();
        }
        return result;
    }

    public int add(Inventory inventory) {
        int result = dao.insert("inventory.add", inventory);
        if (result > Constant.ZERO) {
            flushCache();
        }
        return result;
    }

    public int update(Inventory inventory) {
        int result = dao.update("inventory.update", inventory);
        if (result > Constant.ZERO) {
            flushCache();
        }
        return result;
    }

    public List<Inventory> getAllInventoryList() {
        if (cache.containsKey(CacheKeyFactory.INVENTORY)) {
            return cache.get(CacheKeyFactory.INVENTORY);
        }
        List<Inventory> inventories = dao.queryForList("inventory.getAllInventory");
        if (inventories == null) {
            inventories = Collections.emptyList();
        }
        cache.put(CacheKeyFactory.INVENTORY, inventories);
        return inventories;
    }
    
    public Map<Integer, Inventory> getAllInventoryMap() {
        List<Inventory> inventorys = getAllInventoryList();
        if (inventorys == null) {
            return Collections.emptyMap();
        }
        Map<Integer, Inventory> result = new HashMap<Integer, Inventory>();
        for (Inventory inventory : inventorys) {
            int id = inventory.getId();
            result.put(id, inventory);
        }
        return result;
    }
    public int delete(Integer inventoryId) {
        int result = Constant.ZERO;
        if (inventoryId == null || inventoryId.intValue() < Constant.ONE) {
            return result;
        }
        result = dao.delete("inventory.delete", inventoryId);
        if (result > Constant.ZERO) {
            flushCache();
        }
        return result;
    }
}
