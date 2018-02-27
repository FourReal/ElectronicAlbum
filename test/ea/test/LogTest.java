package ea.test;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.junit.Test;

public class LogTest {

	private Log log=LogFactory.getLog(this.getClass());
	
	@Test
	public void test() throws Exception{
		log.debug("这是debug信息");
		log.info("这是info信息");
		log.warn("这是warn信息");
		log.error("这是error信息");
		log.fatal("这是fatal信息");
	}
}
