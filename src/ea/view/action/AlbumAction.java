package ea.view.action;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import ea.base.BaseAction;
import ea.domain.Album;
import ea.domain.AlbumBgp;
import ea.domain.Photo;
import ea.domain.User;
import ea.service.AlbumService;
import ea.util.PageShow;

@Controller
@Scope("prototype")
public class AlbumAction extends BaseAction<Album>{
	
	private static final long serialVersionUID = 1L;  
    
    private File image; //上传的文件  
    private String imageFileName; //文件名称  
    private String imageContentType; //文件类型
    
    private int pageNow=1;   //动态改变 页面获取
    private int pageSize=5;    //固定不变
    
    
    
	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	/** 列表*/
	public String list() throws Exception{
		List<Album> albumList=albumService.findAll();
		ActionContext.getContext().put("albumList", albumList);
		return "list";
	}
	
	/** 删除*/
	public String delete() throws Exception{
		albumService.delete(model.getId());
		return "toList";
	}
	
	/** 添加页面*/
	public String addUI() throws Exception{
		
		
		return "add";
	}
	
	/**添加相册*/
	public String add() throws Exception{
		albumService.save(model);
		return "toList";
	}
	
	/**修改相册*/
	public String editUI() throws Exception{
		//准备回显数据
		Album album=albumService.getById(model.getId());
		ActionContext.getContext().getValueStack().push(album);
		return "edit";
	}
	
	/** 修改*/
	public String edit() throws Exception{
		
		//从数据库获取原对象
		Album album=albumService.getById(model.getId());
		
		//设置修改的属性
		album.setAlbumName(model.getAlbumName());
		album.setDescription(model.getDescription());
		
		
		//保存到数据库
		albumService.update(album);
		
		
		return "toList";
	}
	
	/** 展示相册背景图*/
	public String show() throws Exception{
    	//System.out.println("show:album-------------------"+model.getId());
		//准备相册数据
		Album album=null;
		Object obj=ActionContext.getContext().getSession().get("bgpid");
		System.out.println("Show++++++++");
		if(obj!=null)
			album=(Album)albumService.getById(Long.parseLong(obj.toString()));
		else
			album=(Album) albumService.getById(model.getId());

      	System.err.println("album-------------------"+album.getId());
		List<AlbumBgp> bgpList=albumService.findAllbgByAlbumId(album.getId());
		ActionContext.getContext().getValueStack().push(album);
		
		//传递参数
		ActionContext.getContext().put("bgpList", bgpList);
				
		
		return "show";
	}
	
	/** 添加相册背景图*/
	public String addBgp() throws Exception{
//		System.out.println("ADDBGP++++++++++++"+model.getId());
		Album album=(Album)albumService.getById(model.getId());
		String updatadate=new SimpleDateFormat("yyyyMMddHHmmss")
				.format(new Date());
		String realpath = ServletActionContext.getServletContext().getRealPath("/images");  
        System.out.println("realpath: "+realpath); 
        String saveaddr="/Electronic/images/"+updatadate+"_"+imageFileName;
        System.out.println("--------"+saveaddr+"------------");
        if(image != null){  
            File savefile = new File(new File(realpath), imageFileName);  
            System.out.println(savefile);  
            System.out.println(savefile.getParentFile());  
            if(savefile.getParentFile().exists()){  
                try {  
                    savefile.getParentFile().mkdirs();  
                    FileUtils.copyFile(image, savefile);  
                } catch (IOException e) {  
                    e.printStackTrace();  
                }  
               
                ActionContext.getContext().put("message", "文件上传成功");  
            }  
        }  
		
       // System.out.println("albumid________________________________________"+album.getId());
        
		AlbumBgp bgp=new AlbumBgp();
		bgp.setAddr(saveaddr);
		bgp.setAlbum(album);
		albumService.addBgp(bgp);
//		System.out.println("addBgp()+=====id="+model.getId());
		ActionContext.getContext().getSession().put("bgpid", model.getId());
		return "toShow";
	}
	
	/**删除相册中的背景图*/
	public String deleteBgp()throws Exception{
//		System.out.println("DELETE===="+model.getId());
		AlbumBgp bgp=(AlbumBgp)albumService.findBgpByBgpId(model.getId());
		Album album=bgp.getAlbum();
//		System.out.println("albumBgp+++++++"+bgp.getId()+"+++++++"+bgp.getAddr());
		ActionContext.getContext().getSession().put("bgpid", album.getId());
		albumService.deleteBgp(bgp.getId());
	
		return "toShow";
	}
	
	
	/** 相册编辑*/
	public String make()throws Exception{
		
		return "make";
	}

	
	/**
	 * 展示相册全部背景图片
	 * @return
	 * @throws Exception
	 */
	public String bgpshow()throws Exception{
		List<AlbumBgp> bgpsList=albumBgpService.findAll();
		System.out.println("bgpshow:++++++++++++++++++"+bgpsList);
		for(AlbumBgp a:bgpsList)
		{
			System.out.println(a.getId()+"++++"+a.getAddr());
		}
		ActionContext.getContext().put("bgpsList", bgpsList);
		return "bgpsshow";
	}

	
	/**
	 * 分页展示背景图片
	 * @return
	 */
	public String getAllBgps() {
//		if(ActionContext.getContext().getSession().get("page")!=null)
//		{
//			PageShow page=(PageShow) ActionContext.getContext().getSession().get("page");
//			int pagenow=getPageNow();
//			System.out.println("getAllBgps:page++++++++++++"+page.getPageNow()+"+++"+pagenow);
//			pageNow=page.getPageNow();
//		}
		
		System.out.println("getAllBgps:page++++++++++++"+getPageNow());
		List<AlbumBgp> bgpsList=albumBgpService.findAllbgp(pageNow,pageSize);
		System.out.println("getAllBgps:page++++++++++");
		if(bgpsList.size()>0) {   //bgp列表
			ActionContext.getContext().put("bgpsList", bgpsList);
			PageShow page=new PageShow(pageNow,albumBgpService.findBgpSize(),pageSize);
//			Map request=(Map) ActionContext.getContext().get("request");
//			request.put("page", page);
			ActionContext.getContext().getSession().put("page", page);
			System.out.println("getAllBgps+++++++++"+page.getPageSize()+page.getPageNow());
			
		}
		
		return "bgpsshow";
	}
	
	
	//----------------------------------------
	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getImageContentType() {
		return imageContentType;
	}

	public void setImageContentType(String imageContentType) {
		this.imageContentType = imageContentType;
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
