package com.study.dao.impl;

import com.study.dao.UserDao;

public class UserDaoImpl implements UserDao {
    public UserDaoImpl(){
        System.out.println("UserDao创建...");
    }
    public void save(){
        System.out.println("Saving...");
    }
    public void init(){
        System.out.println("Initializing...");
    }
    public void destroy(){
        System.out.println("Destroying...");
    }
}
