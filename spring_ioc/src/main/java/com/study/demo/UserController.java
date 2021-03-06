package com.study.demo;

import com.study.service.UserService;
import com.study.service.impl.UserServiceImpl;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.context.support.FileSystemXmlApplicationContext;

public class UserController {
    public static void main(String[] args) {
        //ApplicationContext app = new FileSystemXmlApplicationContext("F:\\StudySpring\\spring_ioc\\src\\main\\resources\\applicationContext.xml");
        ApplicationContext app = new ClassPathXmlApplicationContext("applicationContext.xml");
        //UserService userService = (UserService) app.getBean("userService");
        UserService userService = app.getBean(UserService.class);
        userService.save();
    }
}
