package com.study.test;

import com.study.domain.User;
import com.study.mapper.UserMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Before;
import org.junit.Test;

import java.io.InputStream;
import java.util.List;

public class MyBatisTest {

    private UserMapper userMapper;

    @Before
    public void before() throws Exception{
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        userMapper = new SqlSessionFactoryBuilder().build(resourceAsStream).openSession(true).getMapper(UserMapper.class);
    }

    @Test
    public void testSave(){
        User user = new User();
        user.setUsername("tom");
        user.setPassword("abc");
        userMapper.save(user);
    }

    @Test
    public void testUpdate(){
        User user = new User();
        user.setId(18);
        user.setUsername("bob");
        user.setPassword("123");
        userMapper.update(user);
    }

    @Test
    public void testDelete(){
        userMapper.delete(18);
    }

    @Test
    public void testFindById(){
        User user = userMapper.findById(2);
        System.out.println(user);
    }

    @Test
    public void testFindAll(){
        List<User> users = userMapper.findAll();
        for (User user : users) {
            System.out.println(user);
        }
    }

    @Test
    public void testFindUserAndOrderAll(){
        List<User> userAndOrderAll = userMapper.findUserAndOrderAll();
        for (User user : userAndOrderAll) {
            System.out.println(user);
        }
    }

    @Test
    public void testFindUserAndRoleAll(){
        List<User> userAndRoleAll = userMapper.findUserAndRoleAll();
        for (User user : userAndRoleAll) {
            System.out.println(user);
        }
    }
}
