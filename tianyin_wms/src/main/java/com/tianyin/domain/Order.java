package com.tianyin.domain;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

import org.springframework.format.annotation.DateTimeFormat;
/**
 * 订单
 * @author Tiny.Liu
 *
 */
public class Order implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;
    /**主键ID*/
    private int orderId;
    /**约定日期*/
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date appointDate;
    /**客户名称*/
    private String consumerName;
    /**约定地点*/
    private String appointAddress;
    /**客户电话*/
    private String consumerPhone;
    /**订单状态*/
    private Integer status;
    /**总金额*/
    private double sumMoney;
    /**创建时间*/
    private Date createTime;
    /**所需物品*/
    private List<OrderItem> items;
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
    public String getConsumerName() {
        return consumerName;
    }
    public void setConsumerName(String consumerName) {
        this.consumerName = consumerName;
    }
    public String getAppointAddress() {
        return appointAddress;
    }
    public void setAppointAddress(String appointAddress) {
        this.appointAddress = appointAddress;
    }
    public String getConsumerPhone() {
        return consumerPhone;
    }
    public void setConsumerPhone(String consumerPhone) {
        this.consumerPhone = consumerPhone;
    }
    public Integer getStatus() {
        return status;
    }
    public void setStatus(Integer status) {
        this.status = status;
    }
    public double getSumMoney() {
        return sumMoney;
    }
    public void setSumMoney(double sumMoney) {
        this.sumMoney = sumMoney;
    }
    public Date getCreateTime() {
        return createTime;
    }
    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
    public List<OrderItem> getItems() {
        return items;
    }
    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    @Override
    public String toString() {
        return "Order [orderId=" + orderId + ", appointDate=" + appointDate + ", consumerName=" + consumerName + ", appointAddress=" + appointAddress
                + ", consumerPhone=" + consumerPhone + ", status=" + status + ", sumMoney=" + sumMoney + ", createTime=" + createTime + ", items=" + items
                + "]";
    }
    public enum Status {
        NOTPAID(1, "未结算正常订单"), PAID(2, "已结算"), DELETED(4, "已删除");
        private int value;
        private String desc;
        private Status(int value, String desc) {
            this.value = value;
            this.desc = desc;
        }
        public int getValue() {
            return value;
        }
        public void setValue(int value) {
            this.value = value;
        }
        public String getDesc() {
            return desc;
        }
        public void setDesc(String desc) {
            this.desc = desc;
        }
    }
}
