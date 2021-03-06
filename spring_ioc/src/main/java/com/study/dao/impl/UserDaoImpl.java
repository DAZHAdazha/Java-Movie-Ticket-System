package com.study.dao.impl;

import com.study.dao.UserDao;
import com.study.domain.User;

import java.util.List;
import java.util.Map;
import java.util.Properties;

public class UserDaoImpl implements UserDao {

    private String username;
    private int age;
    private List<String> strList;
    private Map<String, User> userMap;
    private Properties properties;

    public void setStrList(List<String> strList) {
        this.strList = strList;
    }

    public void setUserMap(Map<String, User> userMap) {
        this.userMap = userMap;
    }

    public void setProperties(Properties properties) {
        this.properties = properties;
    }

    public void setUsername(String username){
        this.username = username;
    }

    public void setAge(int age){
        this.age = age;
    }

    public UserDaoImpl(){
        System.out.println("UserDao创建...");
    }

    public void save(){
        System.out.println(username+"===="+age);
        System.out.println(strList);
        System.out.println(userMap);
        System.out.println(properties);
        System.out.println("Saving...");
    }
    public void init(){
        System.out.println("Initializing...");
    }

    public void destroy(){
        System.out.println("Destroying...");
    }
}
