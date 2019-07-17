package com.yxc.bean;

/**
 * Copyright(c) 2018 YXC.All rights Reserved
 * 注意：本内容仅限于学习用，禁止用于商业目的
 *
 * @description： 会员实体类
 * @author： yixingchen
 * @date： 2019-04-22
 * @version： 1.0
 **/
public class User {
    /**
     * 会员id
     */
    private int userId;
    /**
     * 会员名
     */
    private String userName;
    /**
     * 密码
     */
    private String password;
    /**
     * 联系电话
     */
    private String phone;
    /**
     * 性别（0：男；1：女）
     */
    private int sex;
    /**
     * 年龄
     */
    private int age;
    /**
     * 收货地址
     */
    private String address;
    /**
     * 剩余金额
     */
    private int money;

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getSex() {
        return sex;
    }

    public void setSex(int sex) {
        this.sex = sex;
    }

    public int getAge() {
        return age;
    }

    public void setAge(int age) {
        this.age = age;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public int getMoney() {
        return money;
    }

    public void setMoney(int money) {
        this.money = money;
    }
}
