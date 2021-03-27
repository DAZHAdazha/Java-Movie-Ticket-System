package com.study.mapper;

import com.study.domain.Role;
import com.study.domain.User;

import java.util.List;

public interface UserMapper {
    public List<User> findAll();

    public List<User> findUserAndRoleAll();
}
