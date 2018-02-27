package ea.util;



import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.AbstractInterceptor;
import com.opensymphony.xwork2.interceptor.Interceptor;

import ea.domain.User;

public class CheckPrivilegeInterceptor extends AbstractInterceptor{

	@Override
	public String intercept(ActionInvocation invocation) throws Exception {
		
//		System.out.println("------->之前");
//		String result=invocation.invoke(); //放行
//		System.out.println("------->之后");
//		return result;
		
		//获取信息
		User user=(User)ActionContext.getContext().getSession().get("user");
		String namespace=invocation.getProxy().getNamespace();
		String actionName=invocation.getProxy().getActionName();
		String privUrl=namespace+actionName;
		
		//如果未登录，就转到登录界面
		if(user==null)
		{
			if(privUrl.startsWith("/user_login")) {
			//如果是去登录，就放行
				return invocation.invoke();
			}else {
			//如果不是去登录，就转到登录界面
				return "loginUI";
			}
		}
		//如果已登录，就判断权限
		else {
			
				return invocation.invoke();
			}
			
		}
	
	}
