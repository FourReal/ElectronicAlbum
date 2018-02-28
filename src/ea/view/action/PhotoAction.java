package ea.view.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import ea.base.BaseAction;
import ea.domain.Photo;

@Controller
@Scope("prototype")
public class PhotoAction extends BaseAction<Photo>{
	/**
	 * 照片上传
	 * @return
	 */
	public String upload()
	{
		return null;
	}
}
