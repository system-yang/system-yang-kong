package com.hunger.shiro;

import com.hunger.model.SysUser;
import com.hunger.service.ISysRoleService;
import com.hunger.service.ISysUserService;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import org.apache.shiro.authc.*;
import org.apache.shiro.authc.credential.CredentialsMatcher;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.cache.CacheManager;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.subject.SimplePrincipalCollection;
import org.apache.shiro.util.SimpleByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;
import java.util.Set;

public class ShiroDbRealm extends AuthorizingRealm {
    private static final Logger logger = LogManager.getLogger(ShiroDbRealm.class);

    @Autowired private ISysUserService userService;
    @Autowired private ISysRoleService roleService;
    
    public ShiroDbRealm(CacheManager cacheManager, CredentialsMatcher matcher) {
        super(cacheManager, matcher);
    }
    
    /**
     * Shiro登录认证(原理：用户提交 用户名和密码  --- shiro 封装令牌 ---- realm 通过用户名将密码查询返回 ---- shiro 自动去比较查询出密码和用户输入密码是否一致---- 进行登陆控制 )
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authcToken) throws AuthenticationException {
    	logger.info("====================Shiro开始登录认证====================");
        UsernamePasswordToken token = (UsernamePasswordToken) authcToken;
        String username = token.getUsername();
        String password = new String(token.getPassword());
        logger.info("====================页面传参的账号===="+username);
        logger.info("====================页面传参的账号===="+password);
//        SysUserVo uservo = new SysUserVo();
//        uservo.setUsername(token.getUsername());
        List<SysUser> list = userService.selectByUserName(token.getUsername());
        // 账号不存在
        if (list == null || list.isEmpty()) {
            return null;
        }
        SysUser user = list.get(0);
        // 账号未启用
        if ("1".equals(user.getStatus()) ){
            return null;
        }
        // 读取用户的url和角色
        Map<String, Set<String>> resourceMap = roleService.selectResourceMapByUserId(user.getUid());
        Set<String> urls = resourceMap.get("urls");
        Set<String> roles = resourceMap.get("roles");
        ShiroUser shiroUser = new ShiroUser(user.getUid(), user.getUsername(), user.getNickname(), urls, roles);
        shiroUser.setRoleSet(roles);
        // 认证缓存信息
        return new SimpleAuthenticationInfo(shiroUser, user.getPassword().toCharArray(), 
    											ShiroByteSource.of(user.getSalt()), getName());
    }

    /**
     * Shiro权限认证
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(
            PrincipalCollection principals) {
        ShiroUser shiroUser = (ShiroUser) principals.getPrimaryPrincipal();
        
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setRoles(shiroUser.getRoleSet());
        info.addStringPermissions(shiroUser.getUrlSet());
        
        return info;
    }

    @Override
    protected Object getAuthenticationCacheKey(PrincipalCollection principals) {
        ShiroUser shiroUser = (ShiroUser) super.getAvailablePrincipal(principals);
        return shiroUser.toString();
    }

    @Override
    protected Object getAuthorizationCacheKey(PrincipalCollection principals) {
        ShiroUser shiroUser = (ShiroUser) super.getAvailablePrincipal(principals);
        return shiroUser.toString();
    }

    /**
     * 清除用户缓存
     * @param shiroUser
     */
    public void removeUserCache(ShiroUser shiroUser){
        SimplePrincipalCollection principals = new SimplePrincipalCollection();
        principals.add(shiroUser, super.getName());
        super.clearCache(principals);
    }

    /**
     * 清除用户缓存
     * @param loginName
     */
    public void removeUserCache(String loginName){
        removeUserCache(new ShiroUser(loginName));
    }
}
