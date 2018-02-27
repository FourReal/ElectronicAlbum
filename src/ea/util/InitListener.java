package ea.util;

import java.util.Collection;
import java.util.List;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.springframework.context.ApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;



public class InitListener implements ServletContextListener {


	public void contextInitialized(ServletContextEvent sce) {
		//获取容器与相关的Service对象
		ApplicationContext ac=WebApplicationContextUtils.getWebApplicationContext(sce.getServletContext());
	
		
	}
	
	public void contextDestroyed(ServletContextEvent arg0) {

	}


}
