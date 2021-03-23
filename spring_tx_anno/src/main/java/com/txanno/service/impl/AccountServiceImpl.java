package com.txanno.service.impl;


import com.txanno.dao.AccountDao;
import com.txanno.service.AccountService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Isolation;
import org.springframework.transaction.annotation.Transactional;

@Service("accountService")
//表示该类的所有方法都用事务控制
@Transactional
public class AccountServiceImpl implements AccountService {

    @Autowired
    private AccountDao accountDao;

    @Transactional(isolation = Isolation.READ_COMMITTED)
    public void transfer(String outMan, String inMan, double money) {
        accountDao.out(outMan,money);
        int i=1/0;
        accountDao.in(inMan,money);
    }
}
