/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

public class Order {
    private int orderID;
    private int userID;
    private String deliveryAddress;
    private String phoneNumber;
    private String recipientName;
    private String paymentMethod;
    private float totalPrice;
    private int statusOrderID;
    private Date timeBuy;

    public Order() {
    }

    public Order(int orderID, int userID, String deliveryAddress, String phoneNumber, String recipientName, String paymentMethod, float totalPrice, int statusOrderID, Date timeBuy) {
        this.orderID = orderID;
        this.userID = userID;
        this.deliveryAddress = deliveryAddress;
        this.phoneNumber = phoneNumber;
        this.recipientName = recipientName;
        this.paymentMethod = paymentMethod;
        this.totalPrice = totalPrice;
        this.statusOrderID = statusOrderID;
        this.timeBuy = timeBuy;
    }

    public int getOrderID() {
        return orderID;
    }

    public void setOrderID(int orderID) {
        this.orderID = orderID;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getDeliveryAddress() {
        return deliveryAddress;
    }

    public void setDeliveryAddress(String deliveryAddress) {
        this.deliveryAddress = deliveryAddress;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getRecipientName() {
        return recipientName;
    }

    public void setRecipientName(String recipientName) {
        this.recipientName = recipientName;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public float getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(float totalPrice) {
        this.totalPrice = totalPrice;
    }

    public int getStatusOrderID() {
        return statusOrderID;
    }

    public void setStatusOrderID(int statusOrderID) {
        this.statusOrderID = statusOrderID;
    }

    public Date getTimeBuy() {
        return timeBuy;
    }

    public void setTimeBuy(Date timeBuy) {
        this.timeBuy = timeBuy;
    }
}
