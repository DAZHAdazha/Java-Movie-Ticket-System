package com.theater.service.impl;

import com.theater.dao.UserDao;
import com.theater.service.UserService;
import com.theater.web.UserServlet;

public class UserServiceImpl implements UserService {

    private UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public String printTest() {
        return userDao.printTest() + "\n" + "UserService call successful";
    }
}
