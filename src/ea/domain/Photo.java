package ea.domain;

public class Photo implements java.io.Serializable{
	private Long Id;
	private String PName;
	private String Paddr;
	private Long OwnerId;
	private String updatetime;
	
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
	
	
}
