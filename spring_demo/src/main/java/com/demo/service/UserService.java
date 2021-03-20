package com.demo.service;

import com.demo.domain.User;

import java.util.List;

public interface UserService {

    List<User> list();

    void save(User user, Long[] roleIds);

    void del(Long userId);

    User login(String username, String password);
}
