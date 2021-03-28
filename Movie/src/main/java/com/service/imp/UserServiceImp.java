package com.service.imp;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.List;

import com.entity.Card;
import com.mapper.CardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import com.entity.User;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mapper.UserMapper;
import com.service.IUserService;

@Service
public class UserServiceImp implements IUserService{

	@Autowired
	private UserMapper usermapper;
	@Autowired
	private CardMapper cardMapper;
	
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	@Override
	public User login(String user_name, String user_pwd) throws UnsupportedEncodingException {
		List<User> userList = usermapper.findUserByName(user_name);
		for(User user : userList) {
			if(user.compare(user_pwd)) {
				return user;
			}
		}
		return null;
	}
	
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	@Override
	public Integer updateUserInfo(User user) {
		return this.usermapper.updateUser(user);
	}
	
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	@Override
	public User findUserById(long user_id) {
		return this.usermapper.findUserById(user_id);
	}
	
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	@Override
	public List<User> findUserByName(String name) {	
		return this.usermapper.findUserByName(name);
	}
	
	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	@Override
	public Integer addUser(User user) {
		int rs = this.usermapper.addUser(user);
		this.cardMapper.setNewCard(user.getUser_id(),10101);
		return rs;
	}

	@Transactional(propagation=Propagation.REQUIRED,rollbackFor=Exception.class)
	@Override
	public Integer deleteUser(long user_id) {
		this.cardMapper.deleteCardByUID(user_id);
		return this.usermapper.deleteUser(user_id);
	}
	
	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	@Override
	public PageInfo<User> findAllUserBySplitPage(Integer page, Integer limit, String keyword) {
		PageHelper.startPage(page, limit);
		List<User> list = new ArrayList<User>();
		if(keyword != null && !keyword.trim().equals("")) {
			list = this.usermapper.findUserLikeName(keyword);
		}else {
			list = this.usermapper.findAllUser();
		}
		PageInfo<User> info = new PageInfo<User>(list);
		return info;
	}

	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	@Override
	public List<User> findAllUserInfos() {
		return this.usermapper.findAllUser();
	}

	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	@Override
	public List<User> findUserLikeName(String name) {
		return this.usermapper.findUserLikeName(name);
	}

	@Transactional(propagation=Propagation.REQUIRED,readOnly=true)
	@Override
	public Card findCardByUID(int user_id) {
		return this.cardMapper.findByUID(user_id);
	}
}


