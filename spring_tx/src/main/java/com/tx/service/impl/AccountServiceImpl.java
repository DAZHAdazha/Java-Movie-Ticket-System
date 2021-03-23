package com.tx.service.impl;


import com.tx.dao.AccountDao;
import com.tx.service.AccountService;

public class AccountServiceImpl implements AccountService {

    private AccountDao accountDao;
    public void setAccountDao(AccountDao accountDao) {
        this.accountDao = accountDao;
    }

    public void transfer(String outMan, String inMan, double money) {
        accountDao.out(outMan,money);
        int i=1/0;
        accountDao.in(inMan,money);
    }
}
