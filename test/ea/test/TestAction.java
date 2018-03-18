package ea.test;

import javax.annotation.Resource;

import org.apache.logging.log4j.core.tools.picocli.CommandLine.Command;
import org.junit.jupiter.api.Test;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionSupport;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import ea.util.StringUtil;

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
	
	@Test
	public void testjson()throws Exception{
		String test="[[{\"src\":\"http://localhost:8080/ElectronicAlbum/imgs/20180317150315_jiating2.jpg\",\"x\":158,\"y\":55,\"w\":200,\"h\":200,\"page\":0},{\"src\":\"http://localhost:8080/ElectronicAlbum/imgs/20180317150320_jiating5.jpg\",\"x\":235,\"y\":315,\"w\":200,\"h\":200,\"page\":0},{\"src\":\"http://localhost:8080/ElectronicAlbum/imgs/20180317150315_jiating2.jpg\",\"x\":449,\"y\":132,\"w\":200,\"h\":200,\"page\":0}]]";
		test=test.substring(1, test.length()-1);
		JSONArray result=JSONArray.fromObject(test);
		
		System.out.println(result);
		
		
	}
}
