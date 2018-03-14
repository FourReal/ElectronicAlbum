package ea.view.action;

import java.util.HashSet;
import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import ea.base.BaseAction;
import ea.domain.Privilege;
import ea.domain.Role;


@Controller
@Scope("prototype")
public class RoleAction extends BaseAction<Role>{
	
//	@Resource
//	private RoleService roleService;
	
//	private Long id;
//	private String name;
//	private String description;
	
//	private Role model=new Role();
//
//	public Role getModel() {
//		return model;
//	}
	
	private Long[] privilegeIds;
	
	
	/** 列表*/
	public String list() throws Exception{
		List<Role> roleList=roleService.findAll();
		ActionContext.getContext().put("roleList", roleList);
		return "list";
	}
	
	/** 删除*/
	public String delete() throws Exception{
		roleService.delete(model.getId());
		return "toList";
	}
	
	/** 添加页面*/
	public String addUI() throws Exception{
		return "saveUI";
	}
	
	/**添加*/
	public String add() throws Exception{
//		//封装到对象中
//		Role role=new Role();
//		role.setName(model.getName());
//		role.setDescription(model.getDescription());
//		//保存到数据库中
//		roleService.save(role);
		
		roleService.save(model);
		
		return "toList";
	}
	
	/** 修改页面*/
	public String editUI() throws Exception{
		//准备回显数据
		Role role=roleService.getById(model.getId());
		ActionContext.getContext().getValueStack().push(role);
	
		return "saveUI";
	}
	
	/** 修改*/
	public String edit() throws Exception{
		//从数据库获取原对象
		Role role=roleService.getById(model.getId());
		
		//设置修改的属性
		role.setName(model.getName());
		role.setDescription(model.getDescription());
		//保存到数据库
		roleService.update(role);
		return "toList";
	}
	
	
	/** 设置权限页面*/
	public String setPrivilegeUI() throws Exception{
		//准备回显数据
		Role role=roleService.getById(model.getId());
		ActionContext.getContext().getValueStack().push(role);
	
		if(role.getPrivileges()!=null) {
			privilegeIds=new Long[role.getPrivileges().size()];
			int index=0;
			for(Privilege priv:role.getPrivileges()) {
				privilegeIds[index++]=priv.getId();
			}
		
		}
		
		//准备数据privilegeList
		
		List<Privilege> privilegeList=privilegeService.findAll();
//		System.out.println("setPrivilegeUI:privilegeList++++++++++++++++"+privilegeList);
		ActionContext.getContext().put("privilegeList", privilegeList);
		
		
		return "setPrivilegeUI";
	}
	
	/** 设置权限*/
	public String setPrivilege() throws Exception{
		//1.从数据库获取原对象
		Role role=roleService.getById(model.getId());
		
		//2.设置修改的属性
		List<Privilege> privilegeList=privilegeService.getByIds(privilegeIds);
		role.setPrivileges(new HashSet<Privilege>(privilegeList));
		
		//3.保存到数据库
		roleService.update(role);
		return "toList";
	}

	
	//-------------------
	public Long[] getPrivilegeIds() {
		return privilegeIds;
	}

	public void setPrivilegeIds(Long[] privilegeIds) {
		this.privilegeIds = privilegeIds;
	}
	
	
	
	
}
