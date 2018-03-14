package ea.util;

import java.util.Collection;
import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import ea.domain.Privilege;
import ea.service.PrivilegeService;




public class InitListener implements ServletContextListener {


	public void contextInitialized(ServletContextEvent sce) {
		//获取容器与相关的Service对象
		ApplicationContext ac=WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
		PrivilegeService privilegeService=(PrivilegeService)ac.getBean("privilegeServiceImpl");
		//准备数据；
		List<Privilege> topPrivilegeList=privilegeService.findTopList();
		sce.getServletContext().setAttribute("topPrivilegeList",topPrivilegeList);
		System.out.println("---------》已准备数据topPrivilegeList《------------"+topPrivilegeList);
		
		//准备数据：allPrivilegeUrls
		Collection<String> allPrivilegeUrls=privilegeService.getAllPrivilegeUrls();
		sce.getServletContext().setAttribute("allPrivilegeUrls", allPrivilegeUrls);
		System.out.println("---------》已准备数据allPrivilegeUrls《------------"+allPrivilegeUrls);
	}
	
	public void contextDestroyed(ServletContextEvent arg0) {

	}


}
