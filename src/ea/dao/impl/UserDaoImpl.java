package ea.dao.impl;

import org.springframework.stereotype.Repository;

import ea.base.DaoSupportImpl;
import ea.dao.UserDao;
import ea.domain.User;

@Deprecated
@Repository
public class UserDaoImpl extends DaoSupportImpl<User> implements UserDao{

}
