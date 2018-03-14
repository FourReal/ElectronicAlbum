package ea.service.impl;

import java.util.Collection;
import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ea.base.DaoSupportImpl;
import ea.domain.Privilege;
import ea.service.PrivilegeService;


@Service
@Transactional
@SuppressWarnings("unchecked")
public class PrivilegeServiceImpl extends DaoSupportImpl<Privilege> implements PrivilegeService{

	
	public List<Privilege> findTopList() {
		return getSession().createQuery(
				"FROM Privilege p WHERE p.parent IS NULL")
				.list();
	}


	public Collection<String> getAllPrivilegeUrls() {
		
		return getSession().createQuery(
				"SELECT DISTINCT p.url FROM Privilege p WHERE p.url IS NOT NULL"
				).list();
	}

}
