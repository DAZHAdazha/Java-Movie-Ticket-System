package com.config.test;

import com.config.domain.User;
import com.config.mapper.UserMapper;
import com.github.pagehelper.Page;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mysql.cj.ParseInfo;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Test;

import java.io.InputStream;
import java.util.Date;
import java.util.List;

public class MybatisTest {

    @Test
    public void test1() throws Exception{
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(resourceAsStream);
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //不需要实现接口，mybatis会代理接口
        UserMapper mapper = sqlSession.getMapper(UserMapper.class);
        //模拟User
        User user = new User();
        user.setUsername("ceshi");
        user.setPassword("abc");
        user.setBirthday(new Date());
        //执行保存
        mapper.save(user);
        sqlSession.commit();
        sqlSession.close();
    }

    @Test
    public void test2() throws Exception{
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(resourceAsStream);
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //不需要实现接口，mybatis会代理接口
        UserMapper mapper = sqlSession.getMapper(UserMapper.class);
        User byId = mapper.findById(9);
        System.out.println(byId.getBirthday());
        sqlSession.commit();
        sqlSession.close();
    }

    @Test
    public void test3() throws Exception{
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(resourceAsStream);
        SqlSession sqlSession = sqlSessionFactory.openSession();
        UserMapper mapper = sqlSession.getMapper(UserMapper.class);
        //设置分页的相关参数 当前页 + 每页显示的条数
        PageHelper.startPage(1, 3);
        List<User> userList = mapper.findAll();
        for (User user : userList) {
            System.out.println(user);
        }
        //获得相关分页参数
        PageInfo<User> pageInfo = new PageInfo<>(userList);
        System.out.println("当前页: "+pageInfo.getPageNum());
        System.out.println("每页显示条数: "+pageInfo.getPageSize());
        System.out.println("总条数: "+pageInfo.getTotal());
        System.out.println("总页数: "+pageInfo.getPages());
        System.out.println("上一页: "+pageInfo.getPrePage());
        System.out.println("下一页: "+pageInfo.getNextPage());
        System.out.println("是否是第一页: "+pageInfo.isIsFirstPage());
        System.out.println("是否是最后页: "+pageInfo.isIsLastPage());
        sqlSession.commit();
        sqlSession.close();
    }

}
