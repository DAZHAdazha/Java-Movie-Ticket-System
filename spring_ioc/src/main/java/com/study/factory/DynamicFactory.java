package com.study.factory;

import com.study.dao.UserDao;
import com.study.dao.impl.UserDaoImpl;

public class DynamicFactory {

    public UserDao getUserDao(){
        return new UserDaoImpl();
    }
}
