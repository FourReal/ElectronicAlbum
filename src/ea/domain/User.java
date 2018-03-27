package ea.domain;

import java.util.Collection;
import java.util.HashSet;
import java.util.Set;

import com.opensymphony.xwork2.ActionContext;


public class User implements java.io.Serializable{

	private Long id;				//用户id
	private String loginName; 		//登录名
	private String password;		//密码
	private String name;			//真实姓名
	private String touxiang;        //用户的头像图片地址（设置相应的setget方法）
	private Set<Role> roles=new HashSet<Role>();	//用户角色
	private String gender;	
	private String phoneNumber;
	private String email;
	private String description;		
	private Set<Photo> photos=new HashSet<Photo>(); //用户拥有的照片
	private Set<Album> albums=new HashSet<Album>(); //用户收藏的相册		
	private Trolley trolley;		//用户的购物车
	
	private Set<AlbumBook> albumbooks=new HashSet<AlbumBook>();		//用户制作的相册
	
	
	/**
	 * 判断是否有权限
	 * @param name
	 * @return
	 */
	public boolean hasPrivilegeByName(String name) {
		//超级管理员有所有权限
		if(isAdmin()) {
			return true;
		}
		
		
		//普通用户判断是否含有这个权限
		for(Role role : roles) {
			for(Privilege priv: role.getPrivileges()) {
				if(priv.getName().equals(name))
					return true;
			}
		}
		return false;
	}
	
	/**
	 * 判断是否为超级管理员
	 * @return
	 */
	public boolean isAdmin() {
		return "admin".equals(loginName);
	}
	
	/**
	 * 根据url判断是否有权限
	 * @param name
	 * @return
	 */
	public boolean hasPrivilegeByUrl(String privUrl) {
		//超级管理员有所有权限
		if(isAdmin()) {
			return true;
		}
		
		
		//>>去掉后面的参数
		int pos=privUrl.indexOf("?");
		if(pos>-1)
		{
			privUrl=privUrl.substring(0,pos);
		}
		//>>去掉后面的UI后缀
		if(privUrl.endsWith("UI")) {
			privUrl=privUrl.substring(0,privUrl.length()-2);
		}
	
		//如果本UrL不需要控制，则本用户可以使用
		Collection<String> allPrivilegeUrls=(Collection<String>)ActionContext.getContext().getApplication().get("allPrivilegeUrls");
		if(!allPrivilegeUrls.contains(privUrl)) {
			return true;
		}else {
			//普通用户判断是否含有这个权限
			for(Role role : roles) {
				for(Privilege priv: role.getPrivileges()) {
					if(privUrl.equals(priv.getUrl()))
						return true;
				}
			}
			return false;
		}
	}
	

	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getGender() {
		return gender;
	}
	public void setGender(String gender) {
		this.gender = gender;
	}
	public String getPhoneNumber() {
		return phoneNumber;
	}
	public void setPhoneNumber(String phoneNumber) {
		this.phoneNumber = phoneNumber;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}


	public Set<Photo> getPhotos() {
		return photos;
	}


	public void setPhotos(Set<Photo> photos) {
		this.photos = photos;
	}


	public Set<Album> getAlbums() {
		return albums;
	}


	public void setAlbums(Set<Album> albums) {
		this.albums = albums;
	}


	public Set<Role> getRoles() {
		return roles;
	}


	public void setRoles(Set<Role> roles) {
		this.roles = roles;
	}

	public Set<AlbumBook> getAlbumbooks() {
		return albumbooks;
	}

	public void setAlbumbooks(Set<AlbumBook> albumbooks) {
		this.albumbooks = albumbooks;
	}

	public Trolley getTrolley() {
		return trolley;
	}

	public void setTrolley(Trolley trolley) {
		this.trolley = trolley;
	}

	public String getTouxiang() {
		return touxiang;
	}

	public void setTouxiang(String touxiang) {
		this.touxiang = touxiang;
	}
	
	
	
}
