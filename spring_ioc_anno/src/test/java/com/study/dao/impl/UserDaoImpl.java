package com.study.dao.impl;

import com.study.dao.UserDao;
import org.springframework.stereotype.Component;

//    <bean id="userDao" class="com.study.dao.impl.UserDaoImpl"/>
@Component("userDao")
public class UserDaoImpl implements UserDao {
    public void save(){
        System.out.println("Save");
    }
}
