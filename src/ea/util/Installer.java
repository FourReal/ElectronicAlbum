package ea.util;

import javax.annotation.Resource;

import org.apache.commons.codec.digest.DigestUtils;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Component;
import org.springframework.transaction.annotation.Transactional;

import ea.domain.Privilege;
import ea.domain.User;

@Component
public class Installer {

	@Resource
	private SessionFactory sessionFactory;

	
	/**
	 * 执行安装
	 */
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
		
		
		
		//===============================================
		//保存权限数据
		Privilege menu,menu1,menu2,menu3,menu4,menu5;
		
		//-------------------
		menu=new Privilege("系统管理",null,null);
		menu1=new Privilege("角色管理","/role_list",menu);
		menu2=new Privilege("相册模板管理","/album_list",menu);
		menu3=new Privilege("用户管理","/user_list",menu);
		menu4=new Privilege("用户照片管理","/photo_adminlist",menu);
		menu5=new Privilege("用户相册管理","/albumbook_adminlist",menu);
		session.save(menu);
		session.save(menu1);
		session.save(menu2);
		session.save(menu3);
		session.save(menu4);
		session.save(menu5);
		
		session.save(new Privilege("角色列表","/role_list",menu1));
		session.save(new Privilege("角色删除","/role_delete",menu1));
		session.save(new Privilege("角色添加","/role_add",menu1));
		session.save(new Privilege("角色修改","/role_edit",menu1));
	
		session.save(new Privilege("相册列表","/album_list",menu2));
		session.save(new Privilege("相册删除","/album_delete",menu2));
		session.save(new Privilege("相册添加","/album_add",menu2));
		session.save(new Privilege("相册修改","/album_edit",menu2));
		
		session.save(new Privilege("用户列表","/user_list",menu3));
		session.save(new Privilege("用户删除","/user_delete",menu3));
		session.save(new Privilege("用户添加","/user_add",menu3));
		session.save(new Privilege("用户修改","/user_edit",menu3));
		session.save(new Privilege("初始化密码","/user_initPassword",menu3));
		
		
		//-------------------------
		menu=new Privilege("你的一切",null,null);
		menu1=new Privilege("个人信息","/user_personal",menu);
		menu2=new Privilege("我的照片","/photo_getAllPhotos",menu);
		menu3=new Privilege("我的相册","/albumbook_list",menu);
		menu4=new Privilege("相册制作","/user_makeAlbum",menu);
		session.save(menu);
		session.save(menu1);
		session.save(menu2);
		session.save(menu3);
		session.save(menu4);
		
	
		
		
	}
	
	public static void main(String args[]) {
		ApplicationContext ac=new ClassPathXmlApplicationContext("spring.xml"); 
		Installer installer=(Installer) ac.getBean("installer");
		installer.install();
	}
}
