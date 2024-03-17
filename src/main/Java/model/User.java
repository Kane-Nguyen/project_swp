package model;

import java.sql.Date;
import java.text.SimpleDateFormat;

public class User {

    private int userId;
    private String fullName;
    private Date birthDate;
    private String phoneNumber;
    private String email;
    private String password;
    private String address;
    private Date dateAdded;
    private String userRole;

    public User() {
    }

    public User(int userId, String fullName, Date birthDate, String phoneNumber, String email, String password, String address, Date dateAdded, String userRole) {
        this.userId = userId;
        this.fullName = fullName;
        this.birthDate = birthDate;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.password = password;
        this.address = address;
        this.dateAdded = dateAdded;
        this.userRole = userRole;
    }

    public User(String fullName, Date birthDate, String phoneNumber, String email, String password, String address, String userRole) {
        this.fullName = fullName;
        this.birthDate = birthDate;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.password = password;
        this.address = address;
        this.userRole = userRole;
    }

    public User(int userId, String fullName, Date birthDate, String phoneNumber, String email, String address, String userRole) {
        this.userId = userId;
        this.fullName = fullName;
        this.birthDate = birthDate;
        this.phoneNumber = phoneNumber;
        this.email = email;
        this.address = address;
        this.userRole = userRole;
    }

    public User(String fullName, Date birthDate, String phoneNumber, String address) {
        this.fullName = fullName;
        this.birthDate = birthDate;
        this.phoneNumber = phoneNumber;
        this.address = address;
    }
    

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public Date getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(Date birthDate) {
        this.birthDate = birthDate;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getDateAdded() {
        return dateAdded;
    }

    public void setDateAdded(Date DateAdded) {
        this.dateAdded = DateAdded;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

}