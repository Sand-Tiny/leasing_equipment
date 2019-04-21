package com.tianyin.domain;

import java.io.Serializable;
/**
 * 订单所需要带的物品详情
 * @author Tiny.Liu
 *
 */
public class OrderItem implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = -1242727447184117880L;
    /**主订单ID*/
    private int orderId;
    /**库存ID*/
    private int inventoryId;
    /**库存*/
    private Inventory inventory;
    /**数量*/
    private int quantity;
    /**单价格*/
    private double price;
    /**小计*/
    private double subtotal;
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public int getInventoryId() {
        return inventoryId;
    }
    public void setInventoryId(int inventoryId) {
        this.inventoryId = inventoryId;
    }
    public Inventory getInventory() {
        return inventory;
    }
    public void setInventory(Inventory inventory) {
        this.inventory = inventory;
    }
    public int getQuantity() {
        return quantity;
    }
    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public double getSubtotal() {
        return subtotal;
    }
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    @Override
    public String toString() {
        return "OrderItem [orderId=" + orderId + ", inventoryId=" + inventoryId + ", inventory=" + inventory + ", quantity=" + quantity + ", price=" + price
                + ", subtotal=" + subtotal + "]";
    }
}
