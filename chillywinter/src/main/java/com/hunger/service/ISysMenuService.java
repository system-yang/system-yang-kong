package com.hunger.service;

import java.util.List;

import com.baomidou.mybatisplus.service.IService;
import com.hunger.model.SysMenu;
import com.hunger.request.Tree;
import com.hunger.shiro.ShiroUser;

public interface ISysMenuService extends IService<SysMenu> {

	List<Tree> selectTreeMenu(ShiroUser shiroUser);

}
