package com.demo.dao;

import com.demo.domain.Role;
import java.util.List;

public interface RoleDao {
    public List<Role> findAll();

    void save(Role role);

    List<Role> findByUserId(Long id);
}
