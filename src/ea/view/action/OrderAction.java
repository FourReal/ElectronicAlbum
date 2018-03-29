package ea.view.action;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import ea.base.BaseAction;
import ea.domain.AlbumBook;
import ea.domain.Order;
import ea.domain.User;

@Controller
@Scope("prototype")
public class OrderAction extends BaseAction<Order>{
	
	private Long albumBookid;
	
	
	/**
	 * 添加订单
	 */
	public String add() throws Exception{
		User user=(User)ActionContext.getContext().getSession().get("user");
		AlbumBook albumBook=albumBookService.getById(albumBookid);
		System.out.println("OrderAction:add======"+albumBookid);
		Order order=new Order();					//准备订单数据
		//设置订单属性
		order.setAlbumBook(albumBook);
		order.setCount(1);
		order.setSign("0");
		order.setTotalprice(albumBook.getAlbum().getPrice());
		order.setTrolley(user.getTrolley());
		
		//保存订单
		orderService.save(order);
		return "success";
	}
	
	
	//================================
	public Long getAlbumBookid() {
		return albumBookid;
	}


	public void setAlbumBookid(Long albumBookid) {
		this.albumBookid = albumBookid;
	}
	
	
	
}
