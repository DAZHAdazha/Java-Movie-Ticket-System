package com.study.service.impl;

import com.study.dao.UserDao;
import com.study.dao.impl.UserDaoImpl;
import com.study.service.UserService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

//注入数据类型主要有三种:
//普通数据类型
//引用数据类型
//集合数据类型

public class UserServiceImpl implements UserService {

    private UserDao userDao;

    public UserServiceImpl(){}

    public UserServiceImpl(UserDao userDao){
        this.userDao = userDao;
    }

    public void setUserDao(UserDao userDao){
        this.userDao = userDao;
    }

    public void save(){
        userDao.save();
    }
}
