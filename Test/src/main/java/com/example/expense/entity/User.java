package com.example.expense.entity;

import javax.persistence.Entity;
import javax.persistence.Table;

import com.norteksoft.product.orm.IdEntity;

@Entity
@Table(name="t_user")
public class User extends IdEntity{
	private static final long serialVersionUID = 1L;
	
	private String username;//用户姓名
	private String sex;//用户年龄
	private Integer age;//用户年龄
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getSex() {
		return sex;
	}
	public void setSex(String sex) {
		this.sex = sex;
	}
	public Integer getAge() {
		return age;
	}
	public void setAge(Integer age) {
		this.age = age;
	}
	public String getIdentity() {
		return identity;
	}
	public void setIdentity(String identity) {
		this.identity = identity;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getEmain() {
		return emain;
	}
	public void setEmain(String emain) {
		this.emain = emain;
	}
	public String getQq() {
		return qq;
	}
	public void setQq(String qq) {
		this.qq = qq;
	}
	
	private String identity;//用户身份证号
	private String phone;//用户电话
	private String emain;//用户邮箱
	private String qq;//用户qq
	
}
