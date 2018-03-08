package ea.test;

import org.hibernate.SessionFactory;
import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import ea.domain.User;
import ea.service.UserService;
import ea.view.action.UserAction;

public class SpringTest {

	private ApplicationContext context= new ClassPathXmlApplicationContext("spring.xml");
	
	@Test
	public void testBean() throws Exception{
//		TestAction testAction=(TestAction)context.getBean("testAction");
//		System.out.println(testAction);
		
		UserAction userAction=(UserAction)context.getBean("userAction");
		System.out.println("Test:useraction++++++++++"+userAction);
		
		userAction.showalbum();
	}
	
	@Test
	public void testSessionFactory() throws Exception{
		SessionFactory sessionFactory=(SessionFactory)context.getBean("sessionFactory");
		System.out.println(sessionFactory);
	}
	
	
	//测试事务
	@Test
	public void testTransaction() throws Exception{
//		TestService testService=(TestService)context.getBean("testService");
//		testService.saveTwoUser();
//		UserService userService=(UserService)context.getBean("userService");
		
	
	}
}
