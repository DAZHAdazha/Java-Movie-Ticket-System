package com.study.test;

import com.study.dao.impl.UserDaoImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.junit.Test;

import java.lang.annotation.Target;

public class SpringTest {
    @Test
    //测试scope属性
    //singleton对象在容器创建时创建,只要容器在对象一直活着，应用卸载，容器销毁时对象被销毁
    //prototype对象在被getBean时创建,只要使用就一直存在,长时间不使用就会被回收
    public void test1(){
        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserDaoImpl userDao1 = (UserDaoImpl) app.getBean("userDao");
        UserDaoImpl userDao2 = (UserDaoImpl) app.getBean("userDao");
        System.out.println(userDao1==userDao2);
    }

    @Test
    //测试对象创建和销毁时机的时机
    public void test2(){
        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserDaoImpl userDao = (UserDaoImpl) app.getBean("userDao");
        ((ClassPathXmlApplicationContext)app).close();
    }

    @Test
    //3种构造方法
    //无参构造方法实例化
    //工厂静态方法实例化
    //动态工厂方法实例化
    public void test3(){
        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserDaoImpl userDao = (UserDaoImpl) app.getBean("userDao");
        userDao.save();
    }
}
