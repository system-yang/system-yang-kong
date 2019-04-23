package com.hunger.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.hunger.model.SysMenu;
import com.hunger.model.SysUser;
import com.hunger.request.PageInfo;
import com.hunger.request.Result;
import com.hunger.service.ISysUserService;
import com.hunger.shiro.PasswordHash;
import com.hunger.utils.DigestUtils;

@Controller
@RequestMapping(value="/user")
public class SysUserController {
	
	@Autowired
	ISysUserService sysUserService;
	
	
	
	
	@RequestMapping(value="/manage")
	public String view() {
		return "/admin/user";
	}
	
	@RequestMapping(value="/list")
	@ResponseBody
	public PageInfo<SysUser> list() {//@RequestParam Integer pagesize,@RequestParam  Integer rows
		Page<SysUser> p = new Page<SysUser>();
		SysUser u = new SysUser();
		Wrapper<SysUser> wrapper = new EntityWrapper<SysUser>(u);
		Page<SysUser> page = sysUserService.selectPage(p, wrapper);
		
		PageInfo<SysUser> pageInfo = new PageInfo<SysUser>();
		pageInfo.setRows(page.getRecords());
		pageInfo.setTotal(page.getTotal());
		return pageInfo;
	}
	
	@RequestMapping(value="/add")
	@ResponseBody
	public Result add(SysUser u) {
		String pwd = u.getPassword();
		u.setSalt(u.getNickname());
		String salt = u.getSalt();
		String realpwd = DigestUtils.hashByShiro("md5", pwd, salt, 2);
		u.setPassword(realpwd);
		boolean b = sysUserService.insert(u);
		
		return new Result(b);
	}

}
