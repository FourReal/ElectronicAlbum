package ea.test;

import javax.annotation.Resource;

import org.apache.logging.log4j.core.tools.picocli.CommandLine.Command;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

@Controller
@Scope("prototype")
public class TestAction extends ActionSupport{
	@Resource
	private TestService testService;
	
	@Override
	public String execute() throws Exception {
		System.out.println("---->TestAction.exucute()");
		
		testService.saveTwoUser();
		return "success";
	}
}
