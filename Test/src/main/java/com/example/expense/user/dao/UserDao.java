package com.example.expense.user.dao;

import org.springframework.stereotype.Repository;

import com.example.expense.entity.TUser;
import com.norteksoft.product.orm.Page;
import com.norteksoft.product.orm.hibernate.HibernateDao;

@Repository
public class UserDao extends HibernateDao<TUser, Long>{

	public Page<TUser> search(Page<TUser> page) {
		// TODO Auto-generated method stub
		return this.searchPageByHql(page, "from TUser t");
	}

}
