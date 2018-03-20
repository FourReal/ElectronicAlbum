package ea.domain;

import java.util.HashSet;
import java.util.Set;

public class Album implements java.io.Serializable{

	private Long id;			//相册id	
	private String albumName;	//相册名字
	private String description;	//相册描述
	
	private Long price;			//相册模板的价格
	
	private String sign;		//相册的类型：（0：相册模板；1：相册成品）
	
	private Set<User> users=new HashSet<User>();		//收藏该相册的用户
	
	private Set<AlbumBgp> bgps=new HashSet<AlbumBgp>();    //相册的组成成分
	
	private Set<AlbumBook> albumBooks=new HashSet<AlbumBook>();    //该模板生成的相册
	
	private String coverAddr;		//相册的封面路径
	
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
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public String getCoverAddr() {
		return coverAddr;
	}
	public void setCoverAddr(String coverAddr) {
		this.coverAddr = coverAddr;
	}
	public Set<AlbumBook> getAlbumBooks() {
		return albumBooks;
	}
	public void setAlbumBooks(Set<AlbumBook> albumBooks) {
		this.albumBooks = albumBooks;
	}
	public Long getPrice() {
		return price;
	}
	public void setPrice(Long price) {
		this.price = price;
	}
	
	
	
}
