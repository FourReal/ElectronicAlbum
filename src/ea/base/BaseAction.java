package ea.base;

import java.lang.reflect.ParameterizedType;

import javax.annotation.Resource;

import com.opensymphony.xwork2.ActionSupport;
import com.opensymphony.xwork2.ModelDriven;

import ea.service.AlbumBgpService;
import ea.service.AlbumService;
import ea.service.PhotoService;
import ea.service.UserService;

public class BaseAction<T> extends ActionSupport implements ModelDriven<T>{

	//============modelDriven的支持=============
	
	public T model;
	
	public BaseAction() {
		try {
			//通过反射获得model的真实类型
			ParameterizedType pt=(ParameterizedType) this.getClass().getGenericSuperclass();
			Class<T> clazz=(Class<T>) pt.getActualTypeArguments()[0];
			//通过反射创建model的实例
			model=clazz.newInstance();
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	
	
	public T getModel() {
		
		return model;
	}
	
	
	
	//===============Service实例申明============
	@Resource
	protected UserService userService;
	@Resource
	protected PhotoService photoService;
	@Resource
	protected AlbumService albumService;
	@Resource
	protected AlbumBgpService albumBgpService;
	
}
