package com.study.test;

import com.study.dao.impl.UserDaoImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.junit.Test;

import java.lang.annotation.Target;

public class SpringTest {
    private ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
    @Test
    //测试scope属性
    //singleton对象在容器创建时创建,只要容器在对象一直活着，应用卸载，容器销毁时对象被销毁
    //prototype对象在被getBean时创建
    public void test1(){
        UserDaoImpl userDao1 = (UserDaoImpl) app.getBean("userDao");
        UserDaoImpl userDao2 = (UserDaoImpl) app.getBean("userDao");
        System.out.println(userDao1==userDao2);
    }

    @Test
    //测试对象创建的时机
    public void test2(){
        UserDaoImpl userDao1 = (UserDaoImpl) app.getBean("userDao");
        UserDaoImpl userDao2 = (UserDaoImpl) app.getBean("userDao");
        System.out.println(userDao1==userDao2);
    }
}
