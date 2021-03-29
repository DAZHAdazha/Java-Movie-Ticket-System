package com.study.mapper;

import com.study.domain.User;
import org.apache.ibatis.annotations.One;
import org.apache.ibatis.annotations.Result;
import org.apache.ibatis.annotations.Results;
import org.apache.ibatis.annotations.Select;
import com.study.domain.Order;

import java.util.List;

public interface OrderMapper {

//    @Select("select *,o.id oid,u.id uid from orders o,user u where o.uid=u.id")
//    @Results({
//            @Result(column = "oid", property = "id"),
//            @Result(column = "ordertime", property = "orderTime"),
//            @Result(column = "total", property = "total"),
//            @Result(column = "uid", property = "user.id"),
//            @Result(column = "username", property = "user.username"),
//            @Result(column = "password", property = "user.password")
//    })
//    public List<Order> findAll();

    @Select("select * from orders")
    @Results({
            @Result(column = "id", property = "id"),
            @Result(column = "ordertime", property = "orderTime"),
            @Result(column = "total", property = "total"),
            @Result(
                    property = "user", //要封装的属性名称
                    column = "uid",    //根据该字段查表
                    javaType = User.class, //要封装的实体类型
                    one = @One(select = "com.study.mapper.UserMapper.findById")
            )
    })
    public List<Order> findAll();

    @Select("select * from orders where uid = #{uid}")
    public List<Order> findByUid(int uid);
}
