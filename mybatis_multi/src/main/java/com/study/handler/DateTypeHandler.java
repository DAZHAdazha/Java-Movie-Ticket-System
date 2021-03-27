package com.study.handler;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Date;

public class DateTypeHandler extends BaseTypeHandler<Date> {

    @Override
    //将java类型转换成数据库需要的类型
    public void setNonNullParameter(PreparedStatement ps, int i, Date parameter, JdbcType jdbcType) throws SQLException {
        long time = parameter.getTime();
        ps.setLong(i,time);
    }

    @Override
    //将数据库中某些数据类型转换成java类型
    public Date getNullableResult(ResultSet rs, String columnName) throws SQLException {
        //String 是需要转换的字段名称
        //re 是查询结果集
        //获取结果集中需要的数据，将其转换成data类型并返回
        long aLong = rs.getLong(columnName);
        Date date = new Date(aLong);
        return date;
    }

    @Override
    //将数据库中某些数据类型转换成java类型
    public Date getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
        long aLong = rs.getLong(columnIndex);
        Date date = new Date(aLong);
        return date;
    }

    @Override
    //将数据库中某些数据类型转换成java类型
    public Date getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
        long aLong = cs.getLong(columnIndex);
        Date date = new Date(aLong);
        return date;
    }
}
