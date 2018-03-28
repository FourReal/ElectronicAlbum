package ea.view.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

@Controller
@Scope("prototype")
public class HomeAction extends ActionSupport{
	
	public String index() throws Exception{
		return "index";
	}
	public String top() throws Exception{
		return "top";
	}
	public String bottom() throws Exception{
		return "bottom";
	}
	public String left() throws Exception{
		return "left";
	}
	public String right() throws Exception{
		return "right";
	}
	public String about() throws Exception{
		return "about";
	}
}
