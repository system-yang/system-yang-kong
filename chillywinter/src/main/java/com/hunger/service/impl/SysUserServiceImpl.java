package com.hunger.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hunger.mapper.SysUserMapper;
import com.hunger.mapper.SysUserRoleMapper;
import com.hunger.model.SysUser;
import com.hunger.service.ISysUserService;

@Service
public class SysUserServiceImpl extends ServiceImpl<SysUserMapper, SysUser> implements ISysUserService {
	
    @Autowired
    private SysUserMapper userMapper;
    @Autowired
    private SysUserRoleMapper userRoleMapper;

	@Override
	public List<SysUser> selectByUserName(String userName) {
		SysUser user = new SysUser();
        user.setUsername(userName);
        EntityWrapper<SysUser> wrapper = new EntityWrapper<SysUser>(user);
        return this.selectList(wrapper);
	}

}
