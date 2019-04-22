package com.hunger.test;

import org.apache.shiro.crypto.hash.SimpleHash;

import com.hunger.utils.DigestUtils;

public class Test {
	
	public static void main(String[] args) {
		
		
//		String string = DigestUtils.hashByShiro("MD5", "admin", "YWRtaW4=", 1);
//		String string2 = new SimpleHash("MD5",  "admin", "YWRtaW4=", 1).toHex();
//		String string3 = new SimpleHash("MD5",  "admin", "admin", 1).toHex();
//		SimpleHash string4 = new SimpleHash("MD5",  "admin", "YWRtaW4=", 1);
//		System.out.println(string);
//		System.out.println(string2);
//		System.out.println(string3);
//		System.out.println(string3);
//		System.out.println(string4);
		
		
		
		String string5 =    DigestUtils.hashByShiro("MD5",  "admin", "123456", 1);
		String string6 =    DigestUtils.hashByShiro("MD5",  "admin", "YWRtaW4=", 1);
		System.out.println(string5);
		System.out.println(string6);
	}

}
