package com.jdbc.domain;

public class Account {
    private String name;
    private double money;

    @Override
    public String toString() {
        return "Account{" +
                "name='" + name + '\'' +
                ", money=" + money +
                '}';
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    public String getName() {
        return name;
    }

    public double getMoney() {
        return money;
    }
}
