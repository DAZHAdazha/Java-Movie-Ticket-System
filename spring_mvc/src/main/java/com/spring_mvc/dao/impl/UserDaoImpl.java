package com.spring_mvc.dao.impl;

import com.spring_mvc.dao.UserDao;

public class UserDaoImpl implements UserDao {
    @Override
    public void save() {
        System.out.println("Saving...");
    }
}
