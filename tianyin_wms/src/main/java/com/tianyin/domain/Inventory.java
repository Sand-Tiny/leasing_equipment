package com.tianyin.domain;

import java.io.Serializable;
/**
 * 设备库存
 * @author Tiny.Liu
 *
 */
public class Inventory implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    /**主键ID*/
    private int id;
    /**设备名称*/
    private String name;
    /**设备库存*/
    private Integer stock;
    /**标准单价*/
    private Double price;
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }
    public Integer getStock() {
        return stock;
    }
    public void setStock(Integer stock) {
        this.stock = stock;
    }
    public Double getPrice() {
        return price;
    }
    public void setPrice(Double price) {
        this.price = price;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    @Override
    public String toString() {
        return "Inventory [id=" + id + ", name=" + name + ", stock=" + stock + ", price=" + price + "]";
    }
}
