package ea.service;

import java.util.List;
import java.util.Set;

import ea.base.DaoSupport;
import ea.domain.Role;

public interface RoleService extends DaoSupport<Role>{

	Set<Role> setRoleinit();

	
	
//	//查询所有
//	List<Role> findAll();
//
//	void delete(Long id);
//
//	void save(Role role);
//
//	Role getById(Long id);
//
//	void update(Role role);

}