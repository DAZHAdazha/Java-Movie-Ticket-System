package com.demo.service.impl;

import com.demo.dao.Impl.UserDaoImpl;
import com.demo.dao.RoleDao;
import com.demo.dao.UserDao;
import com.demo.domain.Role;
import com.demo.domain.User;
import com.demo.service.UserService;
import org.springframework.dao.EmptyResultDataAccessException;

import java.util.List;

public class UserServiceImpl implements UserService {

    private UserDao userDao;
    private RoleDao roleDao;

    public void setRoleDao(RoleDao roleDao) {
        this.roleDao = roleDao;
    }

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public List<User> list() {
        List<User> userList= userDao.findAll();
        //封装userList中的Roles
        for (User user : userList) {
            // 获得userId
            Long id = user.getId();
            //将id作为参数，查询当前userId对应的Role集合
            List<Role> roles = roleDao.findByUserId(id);
            user.setRoles(roles);
        }
        return userList;
    }

    @Override
    public void save(User user, Long[] roleIds) {
        //第一步向sys_user中存储数据
        Long userId = userDao.save(user);
        //第二部向sys_user_role存储多条数据
        userDao.saveUserRoleRel(userId,roleIds);
    }

    @Override
    public void del(Long userId) {
        //删除关系表
        userDao.delUserRoleRel(userId);
        //删除user表
        userDao.del(userId);
    }

    @Override
    public User login(String username, String password) {
        try{
            User user = userDao.findByUsernameAndPassword(username,password);
            return user;
        }catch (EmptyResultDataAccessException e){
            return null;
        }
    }
}
