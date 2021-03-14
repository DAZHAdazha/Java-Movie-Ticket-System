package com.jdbc.test;

import com.alibaba.druid.pool.DruidDataSource;
import com.mchange.v2.c3p0.ComboPooledDataSource;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.JdbcTemplate;

import java.sql.Connection;

public class JdbcTemplateTest {

    @Test
    //测试JDBC模板
    public void test1() throws Exception{
        //设置数据源
        ComboPooledDataSource dataSource = new ComboPooledDataSource();
        dataSource.setDriverClass("com.mysql.cj.jdbc.Driver");
        dataSource.setPassword("991123");
        dataSource.setUser("root");
        dataSource.setJdbcUrl("jdbc:mysql://localhost:3306/test");

        JdbcTemplate jdbcTemplate = new JdbcTemplate();
        //设置数据源对象
        jdbcTemplate.setDataSource(dataSource);
        int flag = jdbcTemplate.update("insert into account (name, money) values (?,?)","tom",5000);
        System.out.println(flag);
    }

    @Test
    //测试spring产生JDBC模板
    public void test2() throws Exception{

        ApplicationContext app = new ClassPathXmlApplicationContext("ApplicationContext.xml");
        JdbcTemplate jdbcTemplate = app.getBean(JdbcTemplate.class);
        int flag = jdbcTemplate.update("insert into account (name, money) values (?,?)","bob",6000);
        System.out.println(flag);
    }
}
