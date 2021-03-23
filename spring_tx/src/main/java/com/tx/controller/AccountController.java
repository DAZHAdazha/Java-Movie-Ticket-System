package com.tx.controller;

import com.tx.service.AccountService;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class AccountController {

    public static void main(String[] args) {
        ApplicationContext app = new ClassPathXmlApplicationContext("spring.xml");
        AccountService accountService = app.getBean(AccountService.class);
        accountService.transfer("tom","lucy",500);
    }

}
