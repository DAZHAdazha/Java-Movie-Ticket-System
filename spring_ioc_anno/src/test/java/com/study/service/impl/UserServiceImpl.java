package com.study.service.impl;

import com.study.dao.UserDao;
import com.study.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import javax.annotation.PreDestroy;
import javax.annotation.Resource;

// <bean id="userService" class="com.study.service.impl.UserServiceImpl"/>
// @Component("userService")
@Service("userService")
// 采用注解方法set方法可以不写
@Scope("singleton")
public class UserServiceImpl implements UserService {

    //<property name="userDao" ref="userDao"/>

    @Autowired
    //Autowired按照数据类型从spring容器中匹配
    @Qualifier("userDao")
    //Qualifier过滤名称id,需要结合Autowired
    //@Resource(name="userDao")
    //是Autowired和Qualifier的结合
    private UserDao userDao;

    @Value("${jdbc.driver}")
    private String driver;

    public void save(){
        System.out.println(driver);
        userDao.save();
    }

    @PostConstruct
    public void init(){
        System.out.println("init");
    }

    @PreDestroy
    public void destroy(){
        System.out.println("destroy");
    }
}
