package ea.service;

import java.util.Collection;
import java.util.List;

import ea.base.DaoSupport;
import ea.domain.Privilege;

public interface PrivilegeService extends DaoSupport<Privilege>{

	/**
	 * 查询所有顶级权限
	 * @return
	 */
	List<Privilege> findTopList();

	/**
	 * 查询所有权限对应的url集合（不重复）
	 * @return
	 */
	Collection<String> getAllPrivilegeUrls();

}
