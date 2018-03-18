package ea.domain;

import java.util.HashSet;
import java.util.Set;

public class AlbumBook implements java.io.Serializable{
	private Long id;			//相册id
	private	String name;		//相册名字
	private String description;	//相册描述
	
	private Album album;		//使用的相册模板
	private User madeuser;	//制作人信息；
	
	private Set<Photo_pro> photo_pros=new HashSet<Photo_pro>();		//相册中的照片

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

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public Album getAlbum() {
		return album;
	}

	public void setAlbum(Album album) {
		this.album = album;
	}

	public User getMadeuser() {
		return madeuser;
	}

	public void setMadeuser(User madeuser) {
		this.madeuser = madeuser;
	}

	public Set<Photo_pro> getPhoto_pros() {
		return photo_pros;
	}

	public void setPhoto_pros(Set<Photo_pro> photo_pros) {
		this.photo_pros = photo_pros;
	}
	
	
	
}
