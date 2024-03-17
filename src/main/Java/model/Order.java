
// Source code is decompiled from a .class file using FernFlower decompiler.
package model;

import java.sql.Date;

public class Order {
   private int orderID;
   private int userID;
   private String deliveryAddress;
   private String phoneNumber;
   private String recipientName;
   private String paymentMethod;
   private int status_order_id;
   private Date timeBuy;

   public Order() {
   }

   public Order(int orderID, int userID, String deliveryAddress, String phoneNumber, String recipientName, String paymentMethod, int status_order_id, Date timeBuy) {
      this.orderID = orderID;
      this.userID = userID;
      this.deliveryAddress = deliveryAddress;
      this.phoneNumber = phoneNumber;
      this.recipientName = recipientName;
      this.paymentMethod = paymentMethod;
      this.status_order_id = status_order_id;
      this.timeBuy = timeBuy;
   }

   public Order(int userID, String deliveryAddress, String phoneNumber, String recipientName, String paymentMethod, int status_order_id, Date timeBuy) {
      this.userID = userID;
      this.deliveryAddress = deliveryAddress;
      this.phoneNumber = phoneNumber;
      this.recipientName = recipientName;
      this.paymentMethod = paymentMethod;
      this.status_order_id = status_order_id;
      this.timeBuy = timeBuy;
   }

   public Order(int userID, String deliveryAddress, String phoneNumber, String recipientName, String paymentMethod, int status_order_id) {
      this.userID = userID;
      this.deliveryAddress = deliveryAddress;
      this.phoneNumber = phoneNumber;
      this.recipientName = recipientName;
      this.paymentMethod = paymentMethod;
      this.status_order_id = status_order_id;
   }

   public int getOrderID() {
      return this.orderID;
   }

   public void setOrderID(int orderID) {
      this.orderID = orderID;
   }

   public int getUserID() {
      return this.userID;
   }

   public void setUserID(int userID) {
      this.userID = userID;
   }

   public String getDeliveryAddress() {
      return this.deliveryAddress;
   }

   public void setDeliveryAddress(String deliveryAddress) {
      this.deliveryAddress = deliveryAddress;
   }

   public String getPhoneNumber() {
      return this.phoneNumber;
   }

   public void setPhoneNumber(String phoneNumber) {
      this.phoneNumber = phoneNumber;
   }

   public String getRecipientName() {
      return this.recipientName;
   }

   public void setRecipientName(String recipientName) {
      this.recipientName = recipientName;
   }

   public String getPaymentMethod() {
      return this.paymentMethod;
   }

   public void setPaymentMethod(String paymentMethod) {
      this.paymentMethod = paymentMethod;
   }

   public int getStatus_order_id() {
      return this.status_order_id;
   }

   public void setStatus_order_id(int status_order_id) {
      this.status_order_id = status_order_id;
   }

   public Date getTimeBuy() {
      return this.timeBuy;
   }

   public void setTimeBuy(Date timeBuy) {
this.timeBuy = timeBuy;
   }
}