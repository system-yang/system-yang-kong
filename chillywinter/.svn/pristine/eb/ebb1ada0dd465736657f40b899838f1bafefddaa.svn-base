package com.hunger.controller;

import java.util.List;

import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.hunger.request.Tree;
import com.hunger.service.ISysMenuService;
import com.hunger.shiro.ShiroUser;

@Controller
@RequestMapping(value="/menu")
public class SysMenuController {
	
	@Autowired
	ISysMenuService sysMenuService;
	
	
	@RequestMapping(value="/tree")
	@ResponseBody
	public List<Tree> treeList() {
		
		ShiroUser shiroUser = (ShiroUser) SecurityUtils.getSubject().getPrincipal();
		List<Tree> list= sysMenuService.selectTreeMenu(shiroUser);
		return list;
	}

}
