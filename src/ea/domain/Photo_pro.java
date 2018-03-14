package ea.domain;

public class Photo_pro implements java.io.Serializable{
	
	private Long id;
	
	private Photo photo;				//标识该照片是从哪张照片来的；
	
	private int page;				//标识该照片在相册中的哪一页；
	private int horizon;			//标识该照片在相册背景图上的横纵坐标；
	private int ordinate;
	private int size_x;				//标识照片的大小；
	private int size_y; 			
	
	
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	
	
	
	public int getHorizon() {
		return horizon;
	}
	public void setHorizon(int horizon) {
		this.horizon = horizon;
	}
	public int getOrdinate() {
		return ordinate;
	}
	public void setOrdinate(int ordinate) {
		this.ordinate = ordinate;
	}
	public int getSize_x() {
		return size_x;
	}
	public void setSize_x(int size_x) {
		this.size_x = size_x;
	}
	public int getSize_y() {
		return size_y;
	}
	public void setSize_y(int size_y) {
		this.size_y = size_y;
	}
	public Photo getPhoto() {
		return photo;
	}
	public void setPhoto(Photo photo) {
		this.photo = photo;
	}
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	
	
	
	
	
	
	
}
