package ea.view.action;

import java.util.List;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import ea.base.BaseAction;
import ea.domain.Photo;
import ea.domain.User;

@Controller
@Scope("prototype")
public class PhotoAction extends BaseAction<Photo>{
	
	/**
	 * 照片展示
	 * @return
	 */
	
	public String list() throws Exception{
		List<Photo> photoList=photoService.findAll();
		ActionContext.getContext().put("photoList", photoList);
		return "photo_list";
	}
	
	
	
	/**
	 * 照片查找
	 * @return
	 */
	public String findPhotos(){

		User user=(User)ActionContext.getContext().getSession().get("user");
		List<Photo> photolist=photoService.findPhotoByUserid(user.getId());
		ActionContext.getContext().put("photoList", photolist);
		
		return "photo_list";
	}
	
}
