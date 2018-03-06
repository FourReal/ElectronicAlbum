package ea.view.action;

import java.util.HashSet;
import java.util.List;

import org.apache.commons.codec.digest.DigestUtils;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import ea.base.BaseAction;
import ea.domain.Album;
import ea.domain.User;
import ea.service.AlbumService;

@Controller
@Scope("prototype")
public class AlbumAction extends BaseAction<Album>{
	
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
	
	/** 展示相册*/
	public String show() throws Exception{
		
		return "show";
	}
	
	/** 相册编辑*/
	public String make()throws Exception{
		
		return "make";
	}
	
	
}
