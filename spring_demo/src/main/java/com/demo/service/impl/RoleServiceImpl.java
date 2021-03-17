package com.demo.service.impl;

import com.demo.dao.RoleDao;
import com.demo.domain.Role;
import com.demo.service.RoleService;

import java.util.List;

public class RoleServiceImpl implements RoleService {

    public RoleDao roleDao;

    public void setRoleDao(RoleDao roleDao) {
        this.roleDao = roleDao;
    }

    @Override
    public List<Role> list() {
        List<Role> roleList = roleDao.findAll();
        return roleList;
    }
}
