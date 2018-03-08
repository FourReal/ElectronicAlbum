package ea.domain;

import java.util.HashSet;
import java.util.Set;

public class Album implements java.io.Serializable{

	private Long id;			//相册id	
	private String albumName;	//相册名字
	private String description;	//相册描述
	
	private Set<Photo> photos=new HashSet<Photo>();   //相册中的照片
	private Set<User> users=new HashSet<User>();		//收藏该相册的用户
	
	private Set<AlbumBgp> bgps=new HashSet<AlbumBgp>();    //相册的组成成分
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getAlbumName() {
		return albumName;
	}
	public void setAlbumName(String albumName) {
		this.albumName = albumName;
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
	public Set<User> getUsers() {
		return users;
	}
	public void setUsers(Set<User> users) {
		this.users = users;
	}
	public Set<AlbumBgp> getBgps() {
		return bgps;
	}
	public void setBgps(Set<AlbumBgp> bgps) {
		this.bgps = bgps;
	}
	
	
	
}
