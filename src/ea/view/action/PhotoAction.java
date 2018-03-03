package ea.view.action;

import java.util.List;

import javax.annotation.Resource;

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
		System.out.println("照片列表");
		List<Photo> photoList=photoService.findAll();
		ActionContext.getContext().put("photoList", photoList);
		return "list";
	}
	
	
	/**
	 * 照片删除
	 */
	public String delete() throws Exception{
		photoService.delete(model.getId());
		return list();
	}
	
	/**
	 * 照片查找
	 * @return
	 */
	public String findPhotos(){

		User user=(User)ActionContext.getContext().getSession().get("user");
		List<Photo> photolist=photoService.findPhotoByUserid(user.getId());
		ActionContext.getContext().put("photoList", photolist);
		
		
		return "list";
	}
	
	/**
	 * 照片上传
	 * @return
	 */
	
	public String add() {
		return "addPhoto";
	}
}
