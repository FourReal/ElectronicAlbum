package ea.domain;

public class Order implements java.io.Serializable{
	
	private Long id;		//用户的id信息
//	private User user;		//产生订单的用户
	private AlbumBook	albumBook;	//产生订单的照片书
	private Trolley	trolley;		//用户的购物车
	private int count;		//订单产品的数量
	private String sign;		//标记订单是否完成：（未完成：0；完成：1）
	private String remark;
	
	private Long totalprice;		//订单的总价
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
//	public User getUser() {
//		return user;
//	}
//	public void setUser(User user) {
//		this.user = user;
//	}
	public AlbumBook getAlbumBook() {
		return albumBook;
	}
	public void setAlbumBook(AlbumBook albumBook) {
		this.albumBook = albumBook;
	}
	public Trolley getTrolley() {
		return trolley;
	}
	public void setTrolley(Trolley trolley) {
		this.trolley = trolley;
	}
	public int getCount() {
		return count;
	}
	public void setCount(int count) {
		this.count = count;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	public String getSign() {
		return sign;
	}
	public void setSign(String sign) {
		this.sign = sign;
	}
	public Long getTotalprice() {
		return totalprice;
	}
	public void setTotalprice(Long totalprice) {
		this.totalprice = totalprice;
	}
	
}
