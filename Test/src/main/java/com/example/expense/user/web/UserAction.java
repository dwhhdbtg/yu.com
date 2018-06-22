package com.example.expense.user.web;

import org.apache.struts2.convention.annotation.Action;
import org.apache.struts2.convention.annotation.Namespace;
import org.apache.struts2.convention.annotation.ParentPackage;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.expense.entity.TUser;
import com.example.expense.user.service.UserService;
import com.norteksoft.product.orm.Page;
import com.norteksoft.product.util.PageUtils;
import com.norteksoft.product.web.struts2.CrudActionSupport;
@Namespace("/user")
@ParentPackage("default")
public class UserAction extends CrudActionSupport<TUser>{
	private static final long serialVersionUID = 1L;
	private TUser user;
	private Long id;
	private Page<TUser> page;
	
	
	

	@Autowired
	private UserService userManager;
	
	public Page<TUser> getPage() {
		return page;
	}

	public void setPage(Page<TUser> page) {
		this.page = page;
	}
	public TUser getUser() {
		return user;
	}

	public void setUser(TUser user) {
		this.user = user;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	@Override
	public TUser getModel() {
		// TODO Auto-generated method stub
		return user;
	}

	@Override
	public String delete() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	@Action("input")
	public String input() throws Exception {
		// TODO Auto-generated method stub
		return SUCCESS;
	}

	@Override
	@Action("list")
	public String list() throws Exception {
		// TODO Auto-generated method stub
		return SUCCESS;
	}

	@Override
	protected void prepareModel() throws Exception {
		// TODO Auto-generated method stub
		if(id==null){
			user=new TUser();
		}else{
			
		}
	}

	@Override
	public String save() throws Exception {
		// TODO Auto-generated method stub
		return null;
	}
	@Action("user-listDatas")
	public String userListDatas(){
			page=userManager.search(page);
			renderText(PageUtils.pageToJson(page));
		return null;
	}
}
