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
    /**计量单位*/
    private String measureUnit;
    /**设备库存*/
    private int stock;
    /**标准单价*/
    private double price;
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
    public String getMeasureUnit() {
        return measureUnit;
    }
    public void setMeasureUnit(String measureUnit) {
        this.measureUnit = measureUnit;
    }
    public int getStock() {
        return stock;
    }
    public void setStock(int stock) {
        this.stock = stock;
    }
    public double getPrice() {
        return price;
    }
    public void setPrice(double price) {
        this.price = price;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    @Override
    public String toString() {
        return "Inventory [id=" + id + ", name=" + name + ", measureUnit=" + measureUnit + ", stock=" + stock + ", price=" + price + "]";
    }
}
