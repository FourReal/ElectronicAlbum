package ea.view.action;

import java.util.List;

import javax.annotation.Resource;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import ea.base.BaseAction;
import ea.domain.AlbumBgp;
import ea.domain.Photo;
import ea.domain.User;
import ea.util.PageShow;

@Controller
@Scope("prototype")
public class PhotoAction extends BaseAction<Photo>{
	

	private int pageNow=1;   //动态改变 页面获取
    private int pageSize=5;    //固定不变
	
	
	
	/**
	 * 照片展示
	 * @return
	 */
	
	public String list() throws Exception{
		User user=(User)ActionContext.getContext().getSession().get("user");
		List<Photo> photolist=photoService.findPhotoByUserid(user.getId());
		ActionContext.getContext().put("photoList", photolist);
		return "list";
	}
	
	
	/**
	 * 照片删除
	 */
	public String delete() throws Exception{
		photoService.delete(model.getId());
		return "toList";
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
	 * 分页展示照片
	 * @return
	 */
	public String getAllPhotos() {
		User user=(User) ActionContext.getContext().getSession().get("user");
		System.out.println("getAllBgps:user++++++++++++"+user.getId());
		System.out.println("getAllBgps:page++++++++++++"+getPageNow());
//		Long userid=(long)1;
		List<Photo> photoList=photoService.findAllPhotosByUserid(pageNow,pageSize,user.getId());
		if(photoList.size()>0) {   //bgp列表
			ActionContext.getContext().put("photoList", photoList);
			PageShow page=new PageShow(pageNow,photoService.findPhotoSizeByUserid(user.getId()),pageSize);
//			Map request=(Map) ActionContext.getContext().get("request");
//			request.put("page", page);
			ActionContext.getContext().getSession().put("pagePhoto", page);
//			System.out.println("getAllBgps+++++++++"+page.getPageSize()+page.getPageNow());
			
		}
		
		return "list";
	}
	
	
	
	
	
	/**
	 * 照片上传
	 * @return
	 */
	
	public String add() {
		return "addPhoto";
	}


	public int getPageNow() {
		return pageNow;
	}


	public void setPageNow(int pageNow) {
		this.pageNow = pageNow;
	}


	public int getPageSize() {
		return pageSize;
	}


	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	
	
	
}
