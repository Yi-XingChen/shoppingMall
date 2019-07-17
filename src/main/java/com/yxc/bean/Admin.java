package com.yxc.bean;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 管理员表
 * @author： yixingchen
 * @date： 2019-05-08
 * @version： 1.0
 **/
public class Admin {
    /**
     * 管理员id
     */
    private int adminId;
    /**
     * 管理员名
     */
    private String adminName;
    /**
     * 密码
     */
    private String adminPassword;
    /**
     * 管理员头像
     */
    private String adminPhoto;
    /**
     * 联系电话
     */
    private String adminPhone;

    public int getAdminId() {
        return adminId;
    }

    public void setAdminId(int adminId) {
        this.adminId = adminId;
    }

    public String getAdminName() {
        return adminName;
    }

    public void setAdminName(String adminName) {
        this.adminName = adminName;
    }

    public String getAdminPassword() {
        return adminPassword;
    }

    public void setAdminPassword(String adminPassword) {
        this.adminPassword = adminPassword;
    }

    public String getAdminPhoto() {
        return adminPhoto;
    }

    public void setAdminPhoto(String adminPhoto) {
        this.adminPhoto = adminPhoto;
    }

    public String getAdminPhone() {
        return adminPhone;
    }

    public void setAdminPhone(String adminPhone) {
        this.adminPhone = adminPhone;
    }
}
