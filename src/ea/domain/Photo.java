package ea.domain;

import java.util.HashSet;
import java.util.Set;

public class Photo implements java.io.Serializable{
	private Long Id;				//照片id
	private String PName;			//照片name
	private String Paddr;			//照片地址
	private Long OwnerId;			//照片用户id
	private String updatetime;
//	private Set<Album> albumIds=new HashSet<Album>();
	
	private Set<Photo_pro> photo_pros=new HashSet<Photo_pro>();	//引用该照片的集合
	
	public Long getId() {
		return Id;
	}
	public void setId(Long id) {
		Id = id;
	}
	public String getPName() {
		return PName;
	}
	public void setPName(String pName) {
		PName = pName;
	}
	public String getPaddr() {
		return Paddr;
	}
	public void setPaddr(String paddr) {
		Paddr = paddr;
	}
	public Long getOwnerId() {
		return OwnerId;
	}
	public void setOwnerId(Long ownerId) {
		OwnerId = ownerId;
	}
	public String getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(String updatetime) {
		this.updatetime = updatetime;
	}
//	public Set<Album> getAlbumIds() {
//		return albumIds;
//	}
//	public void setAlbumIds(Set<Album> albumIds) {
//		this.albumIds = albumIds;
//	}
	public Set<Photo_pro> getPhoto_pros() {
		return photo_pros;
	}
	public void setPhoto_pros(Set<Photo_pro> photo_pros) {
		this.photo_pros = photo_pros;
	}
	
	
	
	
	
}
