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
	private String gender;	
	private String phoneNumber;
	private String email;
	private String description;		
	private Set<Photo> photos=new HashSet<Photo>(); //用户拥有的照片
	private Set<Album> albums=new HashSet<Album>(); //用户收藏的相册		
	
	/**
	 * 判断是否为超级管理员
	 * @return
	 */
	public boolean isAdmin() {
		return "admin".equals(loginName);
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


	
	
	
}
