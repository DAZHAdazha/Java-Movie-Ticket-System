package com.study.demo;

import com.study.dao.impl.UserDaoImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class UserDaoDemo {
    public static void main(String[] args) {
        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserDaoImpl userDao = (UserDaoImpl) app.getBean("userDao");
        userDao.save();
    }
}
