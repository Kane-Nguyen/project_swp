package model;

/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */

/**
 *
 * @author THANHVINH
 */
public class productDescription {
    private int descriptionId;
    private String sizeDisplay;
    private String chipset;
    private String battery;
    private String osystem;
    private String camera;
    private String sim;
    private int productId;

    public productDescription() {
    }

    public productDescription(int descriptionId, String sizeDisplay, String chipset, String battery, String osystem, String camera, String sim, int productId) {
        this.descriptionId = descriptionId;
        this.sizeDisplay = sizeDisplay;
        this.chipset = chipset;
        this.battery = battery;
        this.osystem = osystem;
        this.camera = camera;
        this.sim = sim;
        this.productId = productId;
    }

    public int getDescriptionId() {
        return descriptionId;
    }

    public void setDescriptionId(int descriptionId) {
        this.descriptionId = descriptionId;
    }

    public String getSizeDisplay() {
        return sizeDisplay;
    }

    public void setSizeDisplay(String sizeDisplay) {
        this.sizeDisplay = sizeDisplay;
    }

    public String getChipset() {
        return chipset;
    }

    public void setChipset(String chipset) {
        this.chipset = chipset;
    }

    public String getBattery() {
        return battery;
    }

    public void setBattery(String battery) {
        this.battery = battery;
    }

    public String getOsystem() {
        return osystem;
    }

    public void setOsystem(String osystem) {
        this.osystem = osystem;
    }

    public String getCamera() {
        return camera;
    }

    public void setCamera(String camera) {
        this.camera = camera;
    }

    public String getSim() {
        return sim;
    }

    public void setSim(String sim) {
        this.sim = sim;
    }

    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    } 
}
