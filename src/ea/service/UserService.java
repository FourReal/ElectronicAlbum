package ea.service;

import ea.base.DaoSupport;
import ea.domain.User;

public interface UserService extends DaoSupport<User>{

	/**
	 * 根据登录名和密码查询用户
	 * @param loginName
	 * @param password 明文密码
	 * @return
	 */
	
	User findByLoginNameAndPassword(String loginName, String password);

	User findByLoginName(String loginName);

}
