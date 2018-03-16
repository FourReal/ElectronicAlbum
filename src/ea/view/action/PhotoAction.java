package ea.view.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.apache.struts2.json.annotations.*;
import com.opensymphony.xwork2.ActionSupport;  
import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
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
	
	private static final long serialVersionUID = 1L;
	private int pageNow=1;   //动态改变 页面获取
    private int pageSize=14;    //固定不变
	
    private Map<String,String> phPath = new HashMap<String,String>();		//返回给makealb页面的相册导入事件的照片路径
	
	
	public Map<String, String> getPhPath() {
		return phPath;
	}


	public void setPhPath(Map<String, String> phPath) {
		this.phPath = phPath;
	}


	/**
	 * 照片展示
	 * @return
	 */
	
	public String list() throws Exception{
		User user=(User)ActionContext.getContext().getSession().get("user");
//		List<Photo> photolist=photoService.findPhotoByUserid(user.getId());
		List<Photo> photoList=photoService.findAllPhotosByUserid(pageNow,pageSize,user.getId());
		ActionContext.getContext().put("photoList", photoList);
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
		if(user!=null) {
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
		}
		return "list";
	}
	
	
	
	 /**
	  * 实现相册导入照片
	  */
	public String scanPhotos() throws Exception {
//		System.out.println("浏览图片");
		phPath = new HashMap<String,String>();
		User user=(User) ActionContext.getContext().getSession().get("user");
		List<Photo> photoList=photoService.findAllPhotosByUserid(pageNow,pageSize,user.getId());
		Iterator<Photo> it = photoList.iterator();
		int cnt = 0;			//照片下标
		while(it.hasNext()) {
			cnt++;
//			System.out.println(cnt);
			//it.next().getPName();
			phPath.put(Integer.toString(cnt), it.next().getPName());
		}
		
	    return "success";
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
