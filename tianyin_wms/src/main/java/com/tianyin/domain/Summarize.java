package com.tianyin.domain;

import java.io.Serializable;
/**
 * 查询的概括，包括总的条数和总的金额
 * @author Tiny.Liu
 *
 */
public class Summarize implements Serializable {

    /**
     * 
     */
    private static final long serialVersionUID = 2476118155739324780L;
    /**总条数*/
    private int totalCount;
    /**已结算的条数*/
    private int paidCount;
    /**未结算的条数*/
    private int notpaidCount;
    /**总的金额*/
    private double totalMoney;
    /**已结算的金额*/
    private double paidMoney;
    /**未结算的金额*/
    private double notpaidMoney;
    public int getTotalCount() {
        return totalCount;
    }
    public void setTotalCount(int totalCount) {
        this.totalCount = totalCount;
    }
    public int getPaidCount() {
        return paidCount;
    }
    public void setPaidCount(int paidCount) {
        this.paidCount = paidCount;
    }
    public int getNotpaidCount() {
        return notpaidCount;
    }
    public void setNotpaidCount(int notpaidCount) {
        this.notpaidCount = notpaidCount;
    }
    public double getTotalMoney() {
        return totalMoney;
    }
    public void setTotalMoney(double totalMoney) {
        this.totalMoney = totalMoney;
    }
    public double getPaidMoney() {
        return paidMoney;
    }
    public void setPaidMoney(double paidMoney) {
        this.paidMoney = paidMoney;
    }
    public double getNotpaidMoney() {
        return notpaidMoney;
    }
    public void setNotpaidMoney(double notpaidMoney) {
        this.notpaidMoney = notpaidMoney;
    }
    public static long getSerialversionuid() {
        return serialVersionUID;
    }
    @Override
    public String toString() {
        return "Summarize [totalCount=" + totalCount + ", paidCount=" + paidCount + ", notpaidCount=" + notpaidCount + ", totalMoney=" + totalMoney
                + ", paidMoney=" + paidMoney + ", notpaidMoney=" + notpaidMoney + "]";
    }
}
