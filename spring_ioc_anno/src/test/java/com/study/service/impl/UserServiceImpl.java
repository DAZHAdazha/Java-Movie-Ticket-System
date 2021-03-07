package com.study.service.impl;

import com.study.dao.UserDao;
import com.study.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Component;

//<bean id="userService" class="com.study.service.impl.UserServiceImpl"/>
@Component("userService")
public class UserServiceImpl implements UserService {

    //<property name="userDao" ref="userDao"/>
    @Autowired
    @Qualifier("userDao")
    private UserDao userDao;

    public void save(){
        userDao.save();
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }
}
