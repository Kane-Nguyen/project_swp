package model;
import java.sql.Date;


public class User {
        private int userID;
        private String fullName;
        private String email;
        private String passWord;
        private String address;
        private Date birthDay;
        private Date registationDay;
        private String userRole;
        private String phoneNumber;

    public User() {
    }

    public User(int userID, String fullName, String email, String passWord, String address, Date birthDay, Date registationDay, String userRole, String phoneNumber) {
        this.userID = userID;
        this.fullName = fullName;
        this.email = email;
        this.passWord = passWord;
        this.address = address;
        this.birthDay = birthDay;
        this.registationDay = registationDay;
        this.userRole = userRole;
        this.phoneNumber = phoneNumber;
    }

    public int getUserID() {
        return userID;
    }

    public void setUserID(int userID) {
        this.userID = userID;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getPassWord() {
        return passWord;
    }

    public void setPassWord(String passWord) {
        this.passWord = passWord;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public Date getBirthDay() {
        return birthDay;
    }

    public void setBirthDay(Date birthDay) {
        this.birthDay = birthDay;
    }

    public Date getRegistationDay() {
        return registationDay;
    }

    public void setRegistationDay(Date registationDay) {
        this.registationDay = registationDay;
    }

    public String getUserRole() {
        return userRole;
    }

    public void setUserRole(String userRole) {
        this.userRole = userRole;
    }

    public String getPhoneNumber() {
        return phoneNumber;
    }

    public void setPhoneNumber(String phoneNumber) {
        this.phoneNumber = phoneNumber;
    }
        

   
}
