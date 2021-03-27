package com.entity;

public class Card {
    private long user_id;

    @Override
    public String toString() {
        return "Card{" +
                "user_id=" + user_id +
                ", money=" + money +
                '}';
    }

    private double money;

    public long getUser_id() {
        return user_id;
    }

    public void setUser_id(long user_id) {
        this.user_id = user_id;
    }

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }
}
