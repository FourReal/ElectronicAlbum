package ea.util;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;


import ea.domain.User;

@Component
public class Installer {

	@Resource
	private SessionFactory sessionFactory;

	@Transactional
	public void install() {
		Session session=sessionFactory.getCurrentSession();
		
		//==============================================
		//保存超级管理员用户
		User user=new User();
		user.setLoginName("admin");
		user.setName("超级管理员");
		user.setPassword(DigestUtils.md5Hex("admin"));
		session.save(user);
		
		
		
		
	}
	
	public static void main(String args[]) {
		ApplicationContext ac=new ClassPathXmlApplicationContext("applicationContext.xml"); 
		Installer installer=(Installer) ac.getBean("installer");
		installer.install();
	}
}
