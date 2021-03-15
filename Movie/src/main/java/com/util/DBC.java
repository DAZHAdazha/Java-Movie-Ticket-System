package com.util;

import com.alibaba.druid.pool.DruidDataSource;
import com.entity.User;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

import javax.sql.DataSource;
import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.Base64;
import java.util.List;

public class DBC {
    public static void main(String[] args) {
        ApplicationContext app = new ClassPathXmlApplicationContext("spring.xml");
        DruidDataSource dataSource = app.getBean(DruidDataSource.class);
        JdbcTemplate jdbcTemplate = new JdbcTemplate();
        //设置数据源对象
        jdbcTemplate.setDataSource(dataSource);
        List<User> users = jdbcTemplate.query("select * from user", new BeanPropertyRowMapper<User>(User.class));
        for(User user:users){
            String base64encodedString = null;
            System.out.println("A: " + user.getUser_pwd());
            try {
                base64encodedString = Base64.getEncoder().encodeToString(user.getUser_pwd().getBytes("utf-8"));
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            System.out.println("B: " + base64encodedString);
            jdbcTemplate.update("UPDATE user SET user_pwd = ? WHERE user_id = ?",base64encodedString,user.getUser_id());
        }
    }
}
