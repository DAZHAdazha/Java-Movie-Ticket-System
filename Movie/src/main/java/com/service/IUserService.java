package com.service;


import java.io.UnsupportedEncodingException;
import java.util.List;

import com.entity.Card;
import com.entity.User;
import com.github.pagehelper.PageInfo;

public interface IUserService {
	User login(String user_name,String user_pwd) throws UnsupportedEncodingException;
	Integer updateUserInfo(User user);
	User findUserById(long user_id);
	List<User> findUserByName(String name);
	List<User> findUserLikeName(String name);
	Integer addUser(User user);
	Integer deleteUser(long user_id);
	List<User> findAllUserInfos();
	PageInfo<User> findAllUserBySplitPage(Integer page,Integer limit,String keyword);
	public Card findCardByUID(int user_id);
}
