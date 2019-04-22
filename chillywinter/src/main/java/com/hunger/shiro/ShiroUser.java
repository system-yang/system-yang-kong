package com.hunger.shiro;

import java.io.Serializable;
import java.util.Set;

public class ShiroUser implements Serializable {
    private static final long serialVersionUID = -1373760761780840081L;
    
    private Long id;
    private String username;
    private String nickname;
    private Set<String> urlSet;
    private Set<String> roleSet;

    

	public ShiroUser(Long id, String username, String nickname, Set<String> urlSet, Set<String> roleSet) {
		super();
		this.id = id;
		this.username = username;
		this.nickname = nickname;
		this.urlSet = urlSet;
		this.roleSet = roleSet;
	}



	public ShiroUser(String username) {
		super();
		this.username = username;
	}



	public Long getId() {
		return id;
	}



	public void setId(Long id) {
		this.id = id;
	}



	public String getUsername() {
		return username;
	}



	public void setUsername(String username) {
		this.username = username;
	}



	public String getNickname() {
		return nickname;
	}



	public void setNickname(String nickname) {
		this.nickname = nickname;
	}



	public Set<String> getUrlSet() {
		return urlSet;
	}



	public void setUrlSet(Set<String> urlSet) {
		this.urlSet = urlSet;
	}



	public Set<String> getRoleSet() {
		return roleSet;
	}



	public void setRoleSet(Set<String> roleSet) {
		this.roleSet = roleSet;
	}



	/**
     * 本函数输出将作为默认的<shiro:principal/>输出.
     */
    @Override
    public String toString() {
        return username;
    }
}