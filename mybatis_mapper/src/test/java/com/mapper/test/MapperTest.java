package com.mapper.test;

import com.mapper.domain.User;
import com.mapper.mapper.UserMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

import java.io.InputStream;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;


public class MapperTest {

    @Test
    public void test1() throws Exception{
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(resourceAsStream);
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //不需要实现接口，mybatis会代理接口
        UserMapper mapper = sqlSession.getMapper(UserMapper.class);

        //模拟User
        User user = new User();
        user.setId(1);
        //user.setUsername("zhangsan");
        //user.setPassword("123");
        List<User> userList = mapper.findByCondition(user);
        System.out.println(userList);
    }

    @Test
    public void test2() throws Exception{
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(resourceAsStream);
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //不需要实现接口，mybatis会代理接口
        UserMapper mapper = sqlSession.getMapper(UserMapper.class);

        //模拟ids数据
        ArrayList<Integer> ids = new ArrayList<>();
        ids.add(1);
        ids.add(3);
        List<User> userList = mapper.findByIds(ids);
        System.out.println(userList);
    }

}
