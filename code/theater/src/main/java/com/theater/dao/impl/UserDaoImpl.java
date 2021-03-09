package com.theater.dao.impl;

import com.theater.dao.UserDao;

public class UserDaoImpl implements UserDao {
    @Override
    public String printTest() {
        return "UserDao call successful";
    }
}
