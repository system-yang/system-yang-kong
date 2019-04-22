package com.hunger.test;

import com.hunger.shiro.PasswordHash;

/**
 * 生成密码
 * 
 * @author L.cm
 */
public class PwdTest {

	public static void main(String[] args) {
		PasswordHash hash = new PasswordHash();
		hash.setAlgorithmName("MD5");
		hash.setHashIterations(1);
		System.out.println(hash.toHex("123456", "admin"));
	}
}
