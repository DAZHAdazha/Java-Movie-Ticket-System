package com.mybatis;

import com.mybatis.domain.User;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.apache.log4j.lf5.util.Resource;
import org.junit.Test;

import java.io.InputStream;
import java.util.List;

public class MybatisTest {

    @Test
    //查询操作
    public void test1() throws Exception{
        //获取核心配置文件
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        //获取session工厂
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(resourceAsStream);
        //获取session对象
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //执行操作 参数：namespace + id
        List<User> userList = sqlSession.selectList("userMapper.findAll");
        //打印
        System.out.println(userList);
        sqlSession.close();
    }

    @Test
    //插入操作
    public void test2() throws Exception{

        User user = new User();
        user.setUsername("tom");
        user.setPassword("abc");


        //获取核心配置文件
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        //获取session工厂
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(resourceAsStream);
        //获取session对象
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //执行操作 参数：namespace + id
        sqlSession.insert("userMapper.save",user);
        //mybatis更新操作需要提交事务
        sqlSession.commit();
        sqlSession.close();
    }

    @Test
    //修改操作
    public void test3() throws Exception{

        User user = new User();
        user.setId(7);
        user.setUsername("lucy");
        user.setPassword("123");


        //获取核心配置文件
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        //获取session工厂
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(resourceAsStream);
        //获取session对象
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //执行操作 参数：namespace + id
        sqlSession.update("userMapper.update",user);
        //mybatis更新操作需要提交事务
        sqlSession.commit();
        sqlSession.close();
    }

    @Test
    //删除操作
    public void test4() throws Exception{

        //获取核心配置文件
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        //获取session工厂
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(resourceAsStream);
        //获取session对象
        SqlSession sqlSession = sqlSessionFactory.openSession();
        //执行操作 参数：namespace + id
        //传递单个参数可以使用任意字符
        sqlSession.delete("userMapper.delete",8);
        //mybatis更新操作需要提交事务
        sqlSession.commit();
        sqlSession.close();
    }

    @Test
    //查询一个对象
    public void test5() throws Exception{
        //获取核心配置文件
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        //获取session工厂
        SqlSessionFactory sqlSessionFactory = new SqlSessionFactoryBuilder().build(resourceAsStream);
        //获取session对象
        SqlSession sqlSession = sqlSessionFactory.openSession(true);
        //执行操作 参数：namespace + id
        User user = sqlSession.selectOne("userMapper.findOne",2);
        //打印
        System.out.println(user);
        sqlSession.close();
    }
}
