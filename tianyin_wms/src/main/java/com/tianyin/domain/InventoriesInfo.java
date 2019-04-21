package com.tianyin.domain;

import java.io.Serializable;
import java.util.List;

public class InventoriesInfo implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 3709649387448236298L;

    private List<Inventory> inventories;

    public List<Inventory> getInventories() {
        return inventories;
    }

    public void setInventories(List<Inventory> inventories) {
        this.inventories = inventories;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }
}
