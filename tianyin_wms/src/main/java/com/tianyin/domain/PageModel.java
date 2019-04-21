package com.tianyin.domain;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class PageModel<T> implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = -7853638211261253566L;
    
    private int total;
    private List<T> data = new ArrayList<T>();
    public int getTotal() {
        return total;
    }
    public void setTotal(int total) {
        this.total = total;
    }
    public List<T> getData() {
        return data;
    }
    public void setData(List<T> data) {
        this.data = data;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    @Override
    public String toString() {
        return "PageModel [total=" + total + ", data=" + data + "]";
    }
}
