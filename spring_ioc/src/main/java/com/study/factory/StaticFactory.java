package com.study.factory;

import com.study.dao.UserDao;
import com.study.dao.impl.UserDaoImpl;

public class StaticFactory {

    public static UserDao getUserDao(){
        return new UserDaoImpl();
    }
}
