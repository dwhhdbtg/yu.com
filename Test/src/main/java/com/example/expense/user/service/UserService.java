package com.example.expense.user.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.expense.entity.TUser;
import com.example.expense.user.dao.UserDao;
import com.norteksoft.mms.base.utils.view.ComboxValues;
import com.norteksoft.product.orm.Page;

@Service
@Transactional
public class UserService implements ComboxValues{
	@Autowired
	private UserDao userDao;

	@Override
	public Map<String, String> getValues(Object arg0) {
		// TODO Auto-generated method stub
		return null;
	}

	public Page<TUser> search(Page<TUser> page) {
		// TODO Auto-generated method stub
		
		return userDao.search(page);
	}
	
}
