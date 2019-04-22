package com.hunger.mapper;

import java.util.List;
import java.util.Map;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.hunger.model.SysRole;

public interface SysRoleMapper extends BaseMapper<SysRole> {

	List<Map<String, String>> selectMenuListByRoleId(Long roleId);
	
}