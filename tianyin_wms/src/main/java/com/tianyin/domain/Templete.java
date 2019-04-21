package com.tianyin.domain;

import java.io.Serializable;

public class Templete implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 2807188100933608062L;

    private int id;
    private String name;
    private double price;
    private int stock;
    private int spuId;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock() {
        return stock;
    }

    public void setStock(int stock) {
        this.stock = stock;
    }

    public int getSpuId() {
        return spuId;
    }

    public void setSpuId(int spuId) {
        this.spuId = spuId;
    }

    public static long getSerialversionuid() {
        return serialVersionUID;
    }

    @Override
    public String toString() {
        return "Sku [id=" + id + ", name=" + name + ", price=" + price + ", stock=" + stock + ", spuId=" + spuId + "]";
    }
    
}
