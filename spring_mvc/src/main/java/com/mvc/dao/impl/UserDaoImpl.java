package com.mvc.dao.impl;

import com.mvc.dao.UserDao;
import org.springframework.stereotype.Repository;

@Repository("userDao")
public class UserDaoImpl implements UserDao {
    public void save(){
        System.out.println("save");
    }
}
