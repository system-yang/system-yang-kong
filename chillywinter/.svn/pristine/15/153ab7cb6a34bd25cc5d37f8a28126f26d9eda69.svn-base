package com.hunger.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.mapper.Wrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.hunger.mapper.SysMenuMapper;
import com.hunger.model.SysMenu;
import com.hunger.request.Tree;
import com.hunger.service.ISysMenuService;
import com.hunger.shiro.ShiroUser;

@Service
public class SysMenuServiceImpl extends ServiceImpl<SysMenuMapper, SysMenu> implements ISysMenuService {
	
	private static final String MENU_STATUS_USING = "0";
	
    @Autowired
    private SysMenuMapper menuMapper;

	@Override
	public List<Tree> selectTreeMenu(ShiroUser shiroUser) {
		
		List<Tree> treeList = new ArrayList<Tree>();
		
		Set<String> roleSet = shiroUser.getRoleSet();
		if(roleSet.contains("admin")) {
			List<SysMenu> listMenu = this.selectAllMenuBystatus(MENU_STATUS_USING);
			treeList = this.listMenuToListTree(treeList,listMenu);
		}
		
		
		
		return treeList;
	}

	private List<Tree> listMenuToListTree(List<Tree> treeList, List<SysMenu> listMenu) {
		
		for (SysMenu sysMenu : listMenu) {
			
			Long parentid = sysMenu.getParentid();
			//父级菜单
			if(parentid==0) {
				Tree parentTree = new Tree();
				
				parentTree.setId(sysMenu.getMid());
				parentTree.setText(sysMenu.getMname());
				parentTree.setPid(sysMenu.getParentid());
				parentTree.setIconCls(sysMenu.getIcon());
				parentTree.setUrl(sysMenu.getUrl());
				parentTree.setState(sysMenu.getState());
				treeList.add(parentTree);
			}
		}
		//挂子级菜单
		for(Tree parentTree:treeList) {
			List<Tree> childrens = new ArrayList<Tree>();
			for (SysMenu sysMenu : listMenu) {
				
				Long mid = parentTree.getId();
				Long parentid = sysMenu.getParentid();
				if(parentid==mid) {
					Tree child = new Tree();
					
					child.setId(sysMenu.getMid());
					child.setText(sysMenu.getMname());
					child.setPid(sysMenu.getParentid());
					child.setIconCls(sysMenu.getIcon());
					child.setUrl(sysMenu.getUrl());
					childrens.add(child);
				}
				parentTree.setChildren(childrens);
			}
		}
		
		
		return treeList;
	}

	private List<SysMenu> selectAllMenuBystatus(String menuStatusUsing) {
		SysMenu sm = new SysMenu();
		sm.setStatus(menuStatusUsing);
		Wrapper<SysMenu> wrapper = new EntityWrapper<SysMenu>(sm);
		List<SysMenu> list = menuMapper.selectList(wrapper);
		return list;
	}
	
	


}
