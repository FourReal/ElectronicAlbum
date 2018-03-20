package ea.view.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Set;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import ea.base.BaseAction;
import ea.domain.Album;
import ea.domain.AlbumBgp;
import ea.domain.AlbumBook;
import ea.domain.Photo_pro;
import ea.domain.User;

@Controller
@Scope("prototype")
public class AlbumBookAction extends BaseAction<AlbumBook>{

	/** 相册书列表*/
	public String list() throws Exception{
		User user=(User)ActionContext.getContext().getSession().get("user");
		System.out.println("AlbumBooklist:userid========"+user.getId());
		List<AlbumBook> albumBookList=albumBookService.getAlbumBooksByUserId(user.getId());
		ActionContext.getContext().put("albumBookList", albumBookList);
		return "list";
	}
	
	/** 删除相册书*/
	public String delete() throws Exception{
		AlbumBook albumBook=albumBookService.getById(model.getId());
		Set<Photo_pro> photo_pros=albumBook.getPhoto_pros();
		for(Photo_pro p:photo_pros)
		{
			photo_proService.delete(p.getId());
		}
		albumBookService.delete(model.getId());
		return "toList";
	}
	
	/**修改相册书*/
	public String editUI() throws Exception{
		//准备回显数据
		AlbumBook albumBook=albumBookService.getById(model.getId());
		ActionContext.getContext().getValueStack().push(albumBook);
		return "edit";
	}
	
	/** 修改相册书页面*/
	public String edit() throws Exception{
		//从数据库获取原对象
		AlbumBook albumBook=albumBookService.getById(model.getId());
		
		//设置修改的属性
		albumBook.setName(model.getName());
		albumBook.setDescription(model.getDescription());
		
		//保存到数据库
		albumBookService.update(albumBook);	
		return "toList";
	}
	
	
	/**
	 * 展示相册书的内容（相册展示）
	 */
	public String show() throws Exception{
		
		System.out.println("show:albumbookid-------------------"+model.getId());
		//准备相册数据
		
		AlbumBook albumBook=albumBookService.getById(model.getId());
		
		List<Photo_pro> photo_proList=albumBookService.getPhoto_prosByAbumBookId(albumBook.getId());
		
		//传递参数
		ActionContext.getContext().put("photo_proList", photo_proList);		//传递相册书中的照片信息
		ActionContext.getContext().getSession().put("albumBook", albumBook);
//		ActionContext.getContext().getSession().put("bgpid", null);
		
		return "show";
	}
	
	/**
	 * 重新编辑相册
	 * @return
	 * @throws Exception
	 */
	public String reedit() throws Exception{
		
		System.out.println("show:albumbookid-------------------"+model.getId());
		//准备相册数据
		
		AlbumBook albumBook=albumBookService.getById(model.getId());
		
		//List<Photo_pro> photo_proList=albumBookService.getPhoto_prosByAbumBookId(albumBook.getId());
		
		//传递参数
		ActionContext.getContext().put("photo_proList", albumBook.getPhoto_pros());
//		ActionContext.getContext().getSession().put("bgpid", null);
		ActionContext.getContext().put("albumid", albumBook.getAlbum().getId());
		List<AlbumBgp> modelBgps=albumService.findAllbgByAlbumId(albumBook.getAlbum().getId());
		ActionContext.getContext().getSession().put("editAlbumBookid", albumBook.getId());
		ActionContext.getContext().put("modelBgps", modelBgps);
		ActionContext.getContext().getSession().put("editAlbumId", albumBook.getAlbum().getId());
		List<Album> albumList=albumService.findAll();
		
		ActionContext.getContext().put("albumList", albumList);
		return "make";
		//return "show";
	}
	
}
