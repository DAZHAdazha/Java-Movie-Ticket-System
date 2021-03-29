package com.study.test;

import com.study.domain.Order;
import com.study.mapper.OrderMapper;
import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;
import org.junit.Before;
import org.junit.Test;

import java.io.InputStream;
import java.util.List;

public class MyBatisTest2 {

    private OrderMapper orderMapper;

    @Before
    public void before() throws Exception{
        InputStream resourceAsStream = Resources.getResourceAsStream("sqlMapConfig.xml");
        orderMapper = new SqlSessionFactoryBuilder().build(resourceAsStream).openSession(true).getMapper(OrderMapper.class);
    }

    @Test
    public void testFindAll(){
        List<Order> orders = orderMapper.findAll();
        for (Order order : orders) {
            System.out.println(order);
        }
    }
    @Test
    public void testFindByUid(){
        List<Order> orders = orderMapper.findByUid(1);
        for (Order order : orders) {
            System.out.println(order);
        }
    }
}
