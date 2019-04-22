package com.hunger.service.impl;

import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hunger.mapper.SysRoleMapper;
import com.hunger.mapper.SysUserRoleMapper;
import com.hunger.model.SysRole;
import com.hunger.service.ISysRoleService;

@Service
public class SysRoleServiceImpl extends ServiceImpl<SysRoleMapper, SysRole> implements ISysRoleService {
	@Autowired
	SysUserRoleMapper userRoleMapper;
	
	@Autowired
	SysRoleMapper roleMapper;

	@Override
	public Map<String, Set<String>> selectResourceMapByUserId(Long uid) {
		Map<String, Set<String>> resourceMap = new HashMap<String, Set<String>>();
        List<Long> roleIdList = userRoleMapper.selectRoleIdListByUserId(uid);
        Set<String> urlSet = new HashSet<String>();
        Set<String> roles = new HashSet<String>();
        for (Long id : roleIdList) {
            List<Map<String, String>> resourceList = roleMapper.selectMenuListByRoleId(id);
            if (resourceList != null && !resourceList.isEmpty()) {
                for (Map<String, String> map : resourceList) {
                    if (map != null && !StringUtils.isEmpty(map.get("url"))) {
                        urlSet.add(map.get("url"));
                    }
                }
            }
            SysRole role = roleMapper.selectById(id);
            if (role != null) {
                roles.add(role.getRolename());
            }
        }
        resourceMap.put("urls", urlSet);
        resourceMap.put("roles", roles);
        return resourceMap;
	}

}
