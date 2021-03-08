package com.study.dao.impl;

import com.study.dao.UserDao;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Repository;

//    <bean id="userDao" class="com.study.dao.impl.UserDaoImpl"/>
//@Component("userDao")
@Repository("userDao")
public class UserDaoImpl implements UserDao {
    public void save(){
        System.out.println("Save");
    }
}
