package ea.domain;

public class Photo implements java.io.Serializable{
	private Long PId;
	private String PName;
	private String Paddr;
	private Long OwnerId;
	private String updatetime;
	public Long getPId() {
		return PId;
	}
	public void setPId(Long pId) {
		PId = pId;
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
