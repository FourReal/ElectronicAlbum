package ea.domain;

import java.util.HashSet;
import java.util.Set;

public class Trolley implements java.io.Serializable{

	private Long id;	//购物车id
	private User user;	//该购物车的主人
	
	private Set<Order>	orders=new HashSet<Order>();		//购物车的订单
	private String remark;
	
	
	public Long getId() {
		return id;
	}
	public void setId(Long id) {
		this.id = id;
	}
	public User getUser() {
		return user;
	}
	public void setUser(User user) {
		this.user = user;
	}
	public Set<Order> getOrders() {
		return orders;
	}
	public void setOrders(Set<Order> orders) {
		this.orders = orders;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = remark;
	}
	
	
	
}
