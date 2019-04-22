package com.hunger.mapper;

import java.util.List;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.hunger.model.SysUserRole;

public interface SysUserRoleMapper extends BaseMapper<SysUserRole> {

	List<Long> selectRoleIdListByUserId(Long uid);
}