package ea.service.impl;

import java.util.List;
import java.util.Set;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ea.base.DaoSupportImpl;
import ea.domain.Role;
import ea.service.RoleService;

@Service
@Transactional
public class RoleServiceImpl extends DaoSupportImpl<Role> implements RoleService{

//	@Resource
//	private RoleDao roleDao;
//	
//	public List<Role> findAll() {
//		
//		return roleDao.findAll();
//	}
//
//	public void delete(Long id) {
//		roleDao.delete(id);	
//	}
//
//
//	public void save(Role role) {
//		roleDao.save(role);
//		
//	}
//
//	
//	public Role getById(Long id) {
//	
//		return roleDao.getById(id);
//	}
//
//
//	public void update(Role role) {
//		roleDao.update(role);
//		
//	}
	
	@SuppressWarnings("unchecked")
	public Set<Role> setRoleinit() {
		return (Set<Role>) getSession().createQuery(
				"From Role r WHERE r.id=1").list();	
	}
	
}