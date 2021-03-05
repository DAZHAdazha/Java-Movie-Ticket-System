package com.study.test;

import com.study.dao.impl.UserDaoImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.junit.Test;
import org.springframework.test.annotation.Repeat;

import java.lang.annotation.Target;

public class SpringTest {

    @Test
    //测试scope属性
    //singleton对象在容器创建时创建,只要容器在对象一直活着，应用卸载，容器销毁时对象被销毁
    //prototype对象在被getBean时创建,只要对象在使用就一直活着,对象长时间不使用会被JAVA垃圾回收器回收
    public void test1(){
        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserDaoImpl userDao1 = (UserDaoImpl) app.getBean("userDao");
        UserDaoImpl userDao2 = (UserDaoImpl) app.getBean("userDao");
        System.out.println(userDao1==userDao2);
    }

    @Test
    //测试init方法和destroy方法
    public void test2(){
        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserDaoImpl userDao = (UserDaoImpl) app.getBean("userDao");
        ((ClassPathXmlApplicationContext)app).close();
        //关闭容器时,销毁singleton时执行销毁方法
    }

    @Test
    //Bean实例化的三种方法:
    //无参构造方法
    //工厂静态方法
    //工厂实例方法
    public void test3(){
        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
        UserDaoImpl userDao = (UserDaoImpl) app.getBean("userDao");
    }
}
