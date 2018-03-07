package ea.domain;

import java.util.HashSet;
import java.util.Set;

public class AlbumBgp implements java.io.Serializable{
	private Long id;
	private String addr;
	private String remark;
	private Album album;
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public String getAddr() {
		return addr;
	}
	public void setAddr(String addr) {
		this.addr = addr;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public Album getAlbum() {
		return album;
	}
	public void setAlbum(Album album) {
		this.album = album;
	}

	
}
