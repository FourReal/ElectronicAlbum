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
	private int dosign=1;		//标记页面操作的动作类型
	private Long searchId;		//进行查找操作时获取页面传送的用户id
	
    
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
		PageShow page=(PageShow) ActionContext.getContext().getSession().get("pagePhoto");
		List<Photo> photoList=photoService.findAllPhotosByUserid(page.getPageNow(),pageSize,user.getId());
		ActionContext.getContext().put("photoList", photoList);
		return "list";
	}
	
	
	/**
	 * 照片删除
	 */
	public String delete() throws Exception{
		System.out.println("PageNow:"+pageNow);
		photoService.delete(model.getId());
		getAllPhotos();
		return "list";
	}
	
	/**
	 * 照片查找
	 * @return
	 */
	public String findPhotos() throws Exception{

		User user=(User)ActionContext.getContext().getSession().get("user");
		List<Photo> photolist=photoService.findPhotoByUserid(user.getId());
		ActionContext.getContext().put("photoList", photolist);
		
		
		return "list";
	}
	
	
	
	/**
	 * 分页展示照片
	 * @return
	 */
	public String getAllPhotos() throws Exception{
		User user=(User) ActionContext.getContext().getSession().get("user");
		if(user!=null) {
			System.out.println("getAllBgps:dosign++++++++++++"+getDosign());
			System.out.println("getAllBgps:user++++++++++++"+user.getId());
			System.out.println("getAllBgps:page++++++++++++"+getPageNow());
	//		Long userid=(long)1;
			List<Photo> photoList=photoService.findAllPhotosByUserid(pageNow,pageSize,user.getId());
			if(photoList.size()>0) {   
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
	 * 操作页面中页数，展示照片
	 */
	public String getPhotos() throws Exception{
		User user=(User) ActionContext.getContext().getSession().get("user");
		if(user!=null)
		{
			PageShow page=(PageShow) ActionContext.getContext().getSession().get("pagePhoto");
			int operate=getDosign();
			switch (operate) {
			case 1:				//返回首页操作
				page.setPageNow(1);
				break;
			case 2:
				page.setPageNow(page.getPageNow()-1);
				break;
			case 3:
				page.setPageNow(page.getPageNow()+1);
				break;
			case 4:
				page.setPageNow(page.getTotalPage());
				break;
			default:
				break;
			}
			List<Photo> photoList=photoService.findAllPhotosByUserid(page.getPageNow(),pageSize,user.getId());
			if(photoList.size()>0) {   //bgp列表
				ActionContext.getContext().put("photoList", photoList);		
				ActionContext.getContext().put("currpage", pageNow);	
		
			}
		}
		
		return "list";
		
	}
	
	/**
	 * 操作页面中页数，展示照片
	 */
	public String getnPhotos() throws Exception{
		User user=(User) ActionContext.getContext().getSession().get("user");
		
			List<Photo> photoList=photoService.findAllPhotosByUserid(pageNow,pageSize,user.getId());
			if(photoList.size()>0) {   //bgp列表
				ActionContext.getContext().put("photoList", photoList);			
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
		List<Photo> photoList=photoService.findAllPhotosByUserid(pageNow,9999,user.getId());
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
	  * 用户添加照片
	  */
	public String add() throws Exception{
		return "addPhoto";
	}
	
	
	/**
	 * 管理员管理照片展示
	 * @return
	 */
	public String adminlist() throws Exception{
		List<Photo> adminphotos=photoService.findAll();
		ActionContext.getContext().put("adminphotos", adminphotos);
		return "adminlist";
	}
	
	
	/**
	 * 管理员对用户的照片删除
	 */
	public String admindelete() throws Exception{
		photoService.delete(model.getId());
		return "toadminList";
	}
	
	/**
	 * 管理员根据用户id进行照片查找
	 * 
	 * @return
	 */
	public String adminfindByUserid() throws Exception{
		//获取前台传送的数据
		List<Photo> adminphotos;
		if(getSearchId()==null)
			adminphotos=photoService.findAll();
		else
			adminphotos=photoService.findPhotoByUserid(getSearchId());
		ActionContext.getContext().put("adminphotos", adminphotos);
		return "adminlist";
	}
	
	
	
	
	//=================================================

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


	public int getDosign() {
		return dosign;
	}


	public void setDosign(int dosign) {
		this.dosign = dosign;
	}


	public Long getSearchId() {
		return searchId;
	}


	public void setSearchId(Long searchId) {
		this.searchId = searchId;
	}
		
	
}
