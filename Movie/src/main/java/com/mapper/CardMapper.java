package com.mapper;

import com.entity.Card;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

@Repository
public interface CardMapper {
    public Card findByUID(long uid);
    public double getMoney(long uid);
    public void setMoney(@Param("user_id") long user_id,@Param("money") double money);
    public void deleteCardByUID(long uid);
    public Integer setNewCard(@Param("user_id") long user_id,@Param("money") double money);
}
