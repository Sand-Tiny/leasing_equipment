package com.tianyin.domain;

import java.io.Serializable;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;
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
    /**约定日期*/
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date appointDate;
    /**库存ID*/
    private Integer inventoryId;
    /**库存名称*/
    private String inventoryName;
    /**库存*/
    private Inventory inventory;
    /**数量*/
    private Integer quantity;
    /**单价格*/
    private Double price;
    /**小计*/
    private double subtotal;
    /**所有库存数量*/
    private int totalQuantity;
    /**当日已经预定的数量*/
    private int bookQuantity;
    /**当日剩余数量*/
    private int remanQuantity;
    public int getOrderId() {
        return orderId;
    }
    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }
    public Date getAppointDate() {
        return appointDate;
    }
    public void setAppointDate(Date appointDate) {
        this.appointDate = appointDate;
    }
    public Integer getInventoryId() {
        return inventoryId;
    }
    public void setInventoryId(Integer inventoryId) {
        this.inventoryId = inventoryId;
    }
    public String getInventoryName() {
        return inventoryName;
    }
    public void setInventoryName(String inventoryName) {
        this.inventoryName = inventoryName;
    }
    public Inventory getInventory() {
        return inventory;
    }
    public void setInventory(Inventory inventory) {
        this.inventory = inventory;
    }
    public Integer getQuantity() {
        return quantity;
    }
    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
    }
    public Double getPrice() {
        return price;
    }
    public void setPrice(Double price) {
        this.price = price;
    }
    public double getSubtotal() {
        return subtotal;
    }
    public void setSubtotal(double subtotal) {
        this.subtotal = subtotal;
    }
    public int getTotalQuantity() {
        return totalQuantity;
    }
    public void setTotalQuantity(int totalQuantity) {
        this.totalQuantity = totalQuantity;
    }
    public int getBookQuantity() {
        return bookQuantity;
    }
    public void setBookQuantity(int bookQuantity) {
        this.bookQuantity = bookQuantity;
    }
    public int getRemanQuantity() {
        return remanQuantity;
    }
    public void setRemanQuantity(int remanQuantity) {
        this.remanQuantity = remanQuantity;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    @Override
    public String toString() {
        return "OrderItem [orderId=" + orderId + ", appointDate=" + appointDate + ", inventoryId=" + inventoryId
                + ", inventoryName=" + inventoryName + ", inventory=" + inventory + ", quantity=" + quantity
                + ", price=" + price + ", subtotal=" + subtotal + ", totalQuantity=" + totalQuantity
                + ", bookQuantity=" + bookQuantity + ", remanQuantity=" + remanQuantity + "]";
    }
}
