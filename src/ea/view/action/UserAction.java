package ea.view.action;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.codec.cli.Digest;
import org.apache.commons.codec.digest.DigestUtils;
import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import ea.base.BaseAction;
import ea.domain.Album;
import ea.domain.AlbumBgp;
import ea.domain.AlbumBook;
import ea.domain.Photo;
import ea.domain.Photo_pro;
import ea.domain.Role;
import ea.domain.Trolley;
import ea.domain.User;
import ea.util.ImgCompress;
import ea.util.PageShow;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


@Controller
@Scope("prototype")
public class UserAction extends BaseAction<User>{

	private static final long serialVersionUID = 1L;
	// 对应js里面的fileObjName，而不是input type ="text" 里面的name值,
	//这里也可以不用list，用File uploadify。因为虽然是批量上传，但还是一个一个的处理文件的
	//等一个文件处理完后才会处理第二个
	private File uploadify; 
	private String uploadifyFileName;
	private String uploadifyContentType;
	private static final String savePath = "imgs";// 文件上传后保存的路径
	private String mvUrl;
	private Long albumId = (long) 1; //用户请求的相册模板ID
	private Long userid;//标记哪个用户上传
	private Long[] roleIds;
	
	
	private int pageNow=1;   //动态改变 页面获取
    private int pageSize=5;    //固定不变
	
    private int BgppageNow=1;   //动态改变 页面获取
    private int BgppageSize=1;    //固定不变
    
    
    private File image; //上传的文件  
    private String imageFileName; //文件名称  
	
	
    private JSONObject jsonString;			//获取页面传过来的json数据
    
    
	/**
	 * ajax 上传图片并返回文件路径
	 * 
	 * @return
	 * @throws Exception
	 */
    public String upload() throws Exception {
		System.out.println("上传照片");
		List<String> mfiles = new ArrayList<String>();
	
		User user=(User)ActionContext.getContext().getSession().get("user");
	
		userid=user.getId();

		//文件重命名，文件保存
		String updatadate=new SimpleDateFormat("yyyyMMddHHmmss")
				.format(new Date());
		String fileName =updatadate+ "_" + uploadifyFileName;
		String sfileName = "s_"+fileName;
		ActionContext ac = ActionContext.getContext();
		ServletContext sc = (ServletContext) ac
				.get(ServletActionContext.SERVLET_CONTEXT);
		String realPath = sc.getRealPath("/");
		String dest = realPath + savePath + "/" + fileName;
		String sdest = realPath + savePath + "/" + sfileName;
		System.out.println("目标路径:"+dest);
		FileUtils.copyFile(uploadify, new File(dest));
		ImgCompress imgCom_m = new ImgCompress(dest,sdest);  
	    imgCom_m.resizeFix(650, 650);  

		mfiles.add(savePath + "/" + fileName);

		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		// 返回图片地址，这里我们实际用的时候可能返回实际图片和缩略图，
		//上传后真正显示的时候用缩略图,实际保存地址为原图片地址。那样加载更快
		out.write(mfiles.get(0));
		out.close();
		out.flush();
		
		Photo photo=new Photo();
		System.out.println("filename:"+fileName);
		photo.setPName(fileName);
		photo.setOwnerId(userid);
		photo.setPaddr(dest);
		photo.setUpdatetime(updatadate);
		photoService.save(photo);
		
		System.out.println("mfiles.get(0):"+mfiles.get(0));
		System.out.println("uploadify:"+uploadify);
		System.out.println("uploadifyFileName:"+uploadifyFileName);
		System.out.println("uploadifyContentType:"+uploadifyContentType);
		return "toPhotoList";
	}

	// 批量保存图片地址

	public String savePath() throws IOException {
		System.out.println("mvUrl:"+mvUrl);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setCharacterEncoding("utf-8");
		PrintWriter out = response.getWriter();
		out.write("保存成功");
		out.close();
		out.flush();
		return null;
	}
	
	
	/**
	 * 用户首页
	 */
	public String index() throws Exception{
		return "index";
	}
	
	
	/** 列表*/
	public String list() throws Exception{
		User user=(User) ActionContext.getContext().getSession().get("user");
		List<User> userList;
		if(user.isAdmin())
		{
			userList=userService.findAll();
		}
		else
		{
			userList=userService.getAllpublic();
		}
		
		ActionContext.getContext().put("userList", userList);
		return "list";
	}
	
	/** 删除*/
	public String delete() throws Exception{
		userService.delete(model.getId());
		return "toList";
	}
	
	/** 添加页面*/
	public String addUI() throws Exception{
		
		
		return "add";
	}
	
	/** 管理员添加页面*/
	public String AaddUI() throws Exception{
		
		
		return "Aadd";
	}
	
	/**添加*/
	public String add() throws Exception{
		User user=userService.findByLoginName(model.getLoginName());
		if(user!=null) {
			addFieldError("regist", "用户名已被注册！");
			return "add";
		}
		else if(model.getPassword().equals("")) 
		{
			addFieldError("regist", "密码不能为空！");
			return "add";
		}
		else{
			String md5Digest=DigestUtils.md5Hex(model.getPassword());
			model.setPassword(md5Digest);
			Long[] ids= {(long) 1};
			List<Role> roleList=roleService.getByIds(ids);
			model.setRoles(new HashSet<Role>(roleList));
			model.setSign("1");
			Trolley trolley=new Trolley();
			trolley.setUser(model);
			trolleyService.save(trolley);
			model.setTrolley(trolley);
			userService.save(model);
			return "loginUI";
		}
	}
	
	/**管理员添加用户*/
	public String Aadd() throws Exception{
//		System.out.println("Aadd+====="+model.getLoginName());
		User user=userService.findByLoginName(model.getLoginName());
		if(user!=null) {
			addFieldError("regist", "用户名已被注册！");
			return "Aadd";
		}
		String md5Digest=DigestUtils.md5Hex("1234");
		
		model.setPassword(md5Digest);
		model.setSign("1");
		Trolley trolley=new Trolley();
		trolley.setUser(model);
		trolleyService.save(trolley);
		model.setTrolley(trolley);
		userService.save(model);
		
		return "toList";
	}
	
	/** 修改页面*/
	public String editUI() throws Exception{
		User user=(User)ActionContext.getContext().getSession().get("user");
		ActionContext.getContext().getValueStack().push(user);
		showalbum();
		return "edit";
	}
	
	/** 修改*/
	public String edit() throws Exception{
		String updatadate=new SimpleDateFormat("yyyyMMddHHmmss")
				.format(new Date());
		String filename=updatadate+"_"+imageFileName;
		String realpath = ServletActionContext.getServletContext().getRealPath("/images");  
        System.out.println("realpath: "+realpath); 
        String saveaddr="/ElectronicAlbum/images/"+filename;
        System.out.println("--------"+saveaddr+"------------");
        if(image != null){  
        	System.out.println("useredit================"+image);
            File savefile = new File(new File(realpath), filename);   
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
		
		User user=(User)ActionContext.getContext().getSession().get("user");
		
		System.out.println("怎么还不成功啊！！！！________________________"+user);
		System.out.println("怎么还不成功啊！！！！________________________"+model);
		//设置修改的属性
		//设置修改的属性
		ActionContext context=ActionContext.getContext();
		Map<String, Object>map=context.getParameters();
		Set<String> keys=map.keySet();
		for(String key:keys) {
			Object[] obj=(Object[]) map.get(key);
			System.out.println(Arrays.toString(obj));
		}
		
		
		user.setTouxiang(saveaddr);
		user.setName(model.getName());
		user.setPhoneNumber(model.getPhoneNumber());
		user.setEmail(model.getEmail());
		//保存到数据库
		System.out.println("怎么还不成功啊！！！！________________________"+model.getName());
		userService.update(user);
		return "personal";
	}	
	
	
	/**管理员修改用户信息页面*/
	public String AeditUI() throws Exception{
		
		//准备回显数据
		User user=userService.getById(model.getId());
		ActionContext.getContext().getValueStack().push(user);
		//准备数据roleList
		List<Role> roleList=roleService.findAll();
		ActionContext.getContext().put("roleList", roleList);
		
		if(user.getRoles()!=null)
		{
			roleIds=new Long[user.getRoles().size()];
			int index=0;
			for(Role role:user.getRoles()) {
				roleIds[index++]=role.getId();
			}
		}
		
		return "Aedit";
	}
	
	/** 管理员修改*/
	public String Aedit() throws Exception{
		
		//从数据库获取原对象
		User user=userService.getById(model.getId());
		
//		System.out.println("怎么还不成功啊！！！！________________________"+user);
		//设置修改的属性
		user.setName(model.getName());
		user.setGender(model.getGender());
		user.setPhoneNumber(model.getPhoneNumber());
		user.setEmail(model.getEmail());
		user.setDescription(model.getDescription());
		//保存到数据库
		
		List<Role> roleList=roleService.getByIds(roleIds);
		if(roleIds.length>1)
			user.setSign("0");
		else
			user.setSign("1");
		user.setRoles(new HashSet<Role>(roleList));
//		System.out.println("怎么还不成功啊！！！！________________________"+model.getName());
		userService.update(user);
		return "toList";
	}
	
	
	/**初始化密码功能*/
	
	public String initPassword()throws Exception{
		//从数据库获取原对象
		User user=userService.getById(model.getId());
		
		//设置修改的属性
		String md5Digest=DigestUtils.md5Hex("1234");
		user.setPassword(md5Digest);
		
		//保存到数据库
		userService.update(user);
		
		return "toList";
	}

	
	
	/**登录页面*/
	public String loginUI() throws Exception{
		return "loginUI";
	}
	
	/**登录*/
	public String login() throws Exception{
		User user=userService.findByLoginNameAndPassword(model.getLoginName(),model.getPassword());
		if(user==null) {
			addFieldError("login", "用户名或密码不正确！");
			return "loginUI";
		}
		else {
			//登录用户
			ActionContext.getContext().getSession().put("user", user);
			return "toIndex";
		}		
		
	}
	
	
	
	/**注销*/
	public String logout() throws Exception{
		ActionContext.getContext().getSession().remove("user");
		return "logout";
	}
	
	
	/**
	 * 用户进入个人中心
	 */
	public String personal() throws Exception{
		User user=(User) ActionContext.getContext().getSession().get("user");
		System.out.println("getAllBgps:user++++++++++++"+user.getId());
		System.out.println("getAllBgps:page++++++++++++"+getPageNow());
		List<AlbumBook> albumBookList=albumBookService.getAlbumBooksByUserId(user.getId());//查找用户相册
		ActionContext.getContext().put("albumBookList", albumBookList);
		
		List<Photo> photoList=photoService.findAllPhotosByUserid(1,6,user.getId());//查找用户照片
		ActionContext.getContext().put("photoList", photoList);
		PageShow page=new PageShow(pageNow,photoService.findPhotoSizeByUserid(user.getId()),pageSize);

		ActionContext.getContext().getSession().put("pagePhoto", page);
		return "personal";
	}
	
	
	/**
	 * 收藏某个相册
	 * @return
	 */
	public String addalbum()throws Exception{
		User user=(User) ActionContext.getContext().getSession().get("user");

		Album album=albumService.getById(model.getId());

		Set<Album> albums=user.getAlbums();

		int sign=0;
		for(Album a:albums)
		{
			if(a.getId()==model.getId())
			{
				sign=1;
				break;
			}
		}
		if(sign!=1)
		{
			albums.add(album);
			user.setAlbums(albums);
			userService.update(user);
		}
		return "edit";
	} 
	
	/**
	 * 展示用户收藏的相册
	 * @return
	 */
	public String showalbum()throws Exception{
		User user=(User) ActionContext.getContext().getSession().get("user");	
		
		
		Set<Album> albums=user.getAlbums();
		List<Album> userAlbums=new ArrayList<Album>(albums);
		System.out.println("Showalbum:userAlbums++++++++++"+userAlbums);
		ActionContext.getContext().put("userAlbums", userAlbums);
		return "showalbumok";
	}
	
	/**
	 * 删除某个收藏的相册
	 * @return
	 * 
	 */
	public String delAlbum()throws Exception{
		User user=(User) ActionContext.getContext().getSession().get("user");
		Set<Album> albums=user.getAlbums();
		Album album=albumService.getById(model.getId());
		
		for(Album a:albums) {
			if(a.getId()==album.getId())
				albums.remove(a);
		}
		
		user.setAlbums(albums);
		userService.update(user);

		return "edit";
	}
	
	/**
	 * 分页展示照片
	 * @return
	 */
	public String getAllPhotos() {
		User user=(User) ActionContext.getContext().getSession().get("user");
		System.out.println("getAllBgps:user++++++++++++"+user.getId());
		System.out.println("getAllBgps:page++++++++++++"+getPageNow());

		List<Photo> photoList=photoService.findAllPhotosByUserid(pageNow,pageSize,user.getId());
		if(photoList.size()>0) {   //bgp列表
			ActionContext.getContext().put("photoList", photoList);
			PageShow page=new PageShow(pageNow,photoService.findPhotoSizeByUserid(user.getId()),pageSize);

			ActionContext.getContext().getSession().put("pagePhoto", page);
		
		}
		
		return "list";
	}
	
	
	/**
	 * 用户制作一个相册
	 * @return
	 */
	public String makeAlbum()throws Exception{

		System.out.println("MakeAlbum:model:================="+getAlbumId());
		List<AlbumBgp> modelBgps=albumService.findAllbgByAlbumId((long)this.getAlbumId());
		ActionContext.getContext().getSession().put("editAlbumBookid", null);
		ActionContext.getContext().put("modelBgps", modelBgps);
		ActionContext.getContext().getSession().put("editAlbumId", getAlbumId());
		Templist();

		return "makeAlbum";
		
	}
	
	
	/**
	 * 形成相册
	 */
	public String beAlbum() throws Exception{
		//获取页面传送过来的json数据
		User user=(User) ActionContext.getContext().getSession().get("user");		//获取用户
		HttpServletRequest request = ServletActionContext.getRequest();
		StringBuilder sb=new StringBuilder();
		try(BufferedReader reader = request.getReader();) {  
			char[]buff = new char[1024];  
			int len;  
		    while((len = reader.read(buff)) != -1) {  
		             sb.append(buff,0, len);  
		    }  
		}catch (IOException e) {  
		        e.printStackTrace();  
		}  
		String date = URLDecoder.decode(sb.toString(),"UTF-8");					//获取前台ajax传送过来的数据
		/*
		 * 解码前：mydata=%7B%22name%22%3A%22ji%22%2C%22age%22%3A20%7D 
		 * 解码后：mydata={"name":"ji","age":20}
		 */
		//       out(sb2); 
		Long editalbumid=(Long) ActionContext.getContext().getSession().get("editAlbumId");		//获取用户编辑的相册模板id
		System.out.println("bealbum:albumId++++"+editalbumid);
		
		Album albumModel=albumService.getById(editalbumid);										//获取相册模板
		
		Object object=ActionContext.getContext().getSession().get("editAlbumBookid");
		AlbumBook editAlbumBook;
		if(object==null) {
			editAlbumBook=new AlbumBook();													//形成用户制定的照片书AlbumBook
			editAlbumBook.setAlbum(albumModel);															
			editAlbumBook.setMadeuser(user);
			albumBookService.save(editAlbumBook);
			System.out.println("Bealbum:editAlbumBook======"+editAlbumBook.getId());						//打印照片书id；
			ActionContext.getContext().getSession().put("editAlbumBookid", editAlbumBook.getId());
		}
		else {
			editAlbumBook=albumBookService.getById(Long.valueOf(String.valueOf(object)));
			System.out.println("Bealbum:editAlbumBook======"+editAlbumBook.getId());
			//删除该相册书的所有照片信息
			Set<Photo_pro> photo_pros=editAlbumBook.getPhoto_pros();
			for(Photo_pro p:photo_pros)
			{
				photo_proService.delete(p.getId());
			}
		}
		System.out.println(date);
		JSONArray result=JSONArray.fromObject(date);
		System.out.println("size++++"+result.size());
		Set<Photo_pro> photo_pros=new HashSet<Photo_pro>();
		if(result.size()>0) {
			for(int i=0;i<result.size();i++) {//遍历page
				JSONArray pageobj=(JSONArray) result.get(i);
					if(pageobj.size()>0) {
						for(int j=0;j<pageobj.size();j++) {//遍历每个page中的照片
							JSONObject photoprojson = (JSONObject) pageobj.get(j);
							String src=photoprojson.getString("src");
							int page=Integer.parseInt(photoprojson.getString("page"));
							int x=Integer.parseInt(photoprojson.getString("x"));
							int y=Integer.parseInt(photoprojson.getString("y"));
							int w=Integer.parseInt(photoprojson.getString("w"));
							int h=Integer.parseInt(photoprojson.getString("h"));
							String filename= src.substring(src.lastIndexOf("/")+1);		//文件路径中获取到文件名；
//							System.out.println("filename==="+filename);
							Photo photo=photoService.findPhotoByPname(filename);		//photo_pro的photo属性准备
							
							Photo_pro photo_pro=new Photo_pro();
							photo_pro.setPhoto(photo);
							photo_pro.setPage(page);
							photo_pro.setHorizon(x);
							photo_pro.setOrdinate(y);
							photo_pro.setSize_x(w);
							photo_pro.setSize_y(h);
							
							System.out.println("beAlbum:photo_pro======"+editAlbumBook.getId());
							photo_pro.setAlbumBook(editAlbumBook);							//设置编辑的照片是属于哪个相册书
							
							System.out.println("beAlbum:photo_pro======="+photo_pro);		//存储制作中的照片信息
							photo_proService.save(photo_pro);
							
							photo_pros.add(photo_pro);
						}
					}
					
			}
		}
		
		System.out.println("beAlbum:photo_pros===="+photo_pros);
		editAlbumBook.setPhoto_pros(photo_pros);
		System.out.println("beAlbum:photo_pros===="+editAlbumBook.getPhoto_pros());
		return "success";
	}
	
	
	/**
	 * 展示相册模板
	 * @return
	 */
	/** 列表*/
	public String Templist() throws Exception{
		List<Album> albumList=albumService.findAll();
		ActionContext.getContext().put("albumList", albumList);
		return "list";
	}
	
	
	
	//----------------各属性set和get方法
	
	public File getUploadify() {
		return uploadify;
	}

	public void setUploadify(File uploadify) {
		this.uploadify = uploadify;
	}

	public String getUploadifyFileName() {
		return uploadifyFileName;
	}

	public void setUploadifyFileName(String uploadifyFileName) {
		this.uploadifyFileName = uploadifyFileName;
	}

	public String getUploadifyContentType() {
		return uploadifyContentType;
	}

	public void setUploadifyContentType(String uploadifyContentType) {
		this.uploadifyContentType = uploadifyContentType;
	}


	public String getMvUrl() {
		return mvUrl;
	}

	public void setMvUrl(String mvUrl) {
		this.mvUrl = mvUrl;
	}

	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public static long getSerialversionuid() {
		return serialVersionUID;
	}

	public static String getSavepath() {
		return savePath;
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

	public int getBgppageNow() {
		return BgppageNow;
	}

	public void setBgppageNow(int bgppageNow) {
		BgppageNow = bgppageNow;
	}

	public int getBgppageSize() {
		return BgppageSize;
	}

	public void setBgppageSize(int bgppageSize) {
		BgppageSize = bgppageSize;
	}

	

	public JSONObject getJsonString() {
		return jsonString;
	}

	public void setJsonString(JSONObject jsonString) {
		this.jsonString = jsonString;
	}

	public Long[] getRoleIds() {
		return roleIds;
	}

	public void setRoleIds(Long[] roleIds) {
		this.roleIds = roleIds;
	}

	public Long getAlbumId() {
		return albumId;
	}

	public void setAlbumId(Long albumId) {
		this.albumId = albumId;
	}

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

	
}
