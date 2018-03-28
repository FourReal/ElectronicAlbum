package ea.service.impl;

import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ea.base.DaoSupportImpl;
import ea.domain.User;
import ea.service.UserService;

@Service
@Transactional
@SuppressWarnings("unchecked")
public class UserServiceImpl extends DaoSupportImpl<User> implements UserService{

	public User findByLoginNameAndPassword(String loginName, String password) {
		//使用密码的md5 摘要进行对比
		String md5Digest=DigestUtils.md5Hex(password);
		return (User) getSession().createQuery(//
				"FROM User u WHERE u.loginName=? AND u.password=?")
				.setParameter(0, loginName)//
				.setParameter(1, md5Digest)
				.uniqueResult();
	}

	
	
	@Override
	public User findByLoginName(String loginName) {
		return (User) getSession().createQuery(//
				"FROM User u WHERE u.loginName=?")
				.setParameter(0, loginName)
				.uniqueResult();
	
	}



	
	@Override
	public List<User> getAllpublic() {
		return (List<User>) getSession().createQuery(
				"FROM User u WHERE u.sign=?"
				).setParameter(0, "1").list();
	}

	
}
