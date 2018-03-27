package ea.view.action;

import java.io.BufferedReader;
import java.io.IOException;
import java.net.URLDecoder;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.security.auth.message.callback.PrivateKeyCallback.Request;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;

import com.opensymphony.xwork2.ActionContext;

import ea.base.BaseAction;
import ea.domain.AlbumBook;
import ea.domain.Order;
import ea.domain.Photo_pro;
import ea.domain.Trolley;
import ea.domain.User;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

@Controller
@Scope("prototype")
public class TrolleyAction extends BaseAction<Trolley>{
	
	private Order orderget;		//用于接受页面传送过来的order对象
	private String count;			//获取页面传送过来的count数据
	private String remark;			//获取页面传送过来的remark数据	 
	
	/** 展示购物车未完成的订单*/
	public String list() throws Exception{
//		System.out.println("TrolleyAction:list===========================");
		User user=(User) ActionContext.getContext().getSession().get("user");
//		System.out.println("TrolleyAction:user======================="+user.getId());
//		System.out.println("TrolleyAction:user======================="+user.getTrolley().getId());
		List<Order> onOrderList=trolleyService.getonOrdersByUserId(user.getTrolley().getId());
		ActionContext.getContext().put("onOrderList", onOrderList);
		return "list";
	}
	
	/**
	 * 展示完成的历史订单
	 */
	public String oldlist() throws Exception{
		User user=(User) ActionContext.getContext().getSession().get("user");
		List<Order> oldOrderList=trolleyService.getoldOrdersByUserId(user.getTrolley().getId());
		ActionContext.getContext().put("oldOrderList", oldOrderList);
		return "oldlist";
	}
	/** 取消未完成的订单*/
	public String delete() throws Exception{
		System.out.println("TrolleyAction:delete======="+model.getId());
		orderService.delete(model.getId());
		return "toList";
	}
	
	/** 删除完成的订单*/
	public String olddelete() throws Exception{
		System.out.println("TrolleyAction:delete======="+model.getId());
		orderService.delete(model.getId());
		return "toOldList";
	}
	
	/**修改订单信息*/
	public String editUI() throws Exception{
		//准备回显数据
//		System.out.println("TrolleyAction:editUI===="+model.getId());
		Order order=orderService.getById(model.getId());
//		System.out.println("TrolleyAction:edit======="+order.getId());
		ActionContext.getContext().getValueStack().push(order);
		return "edit";
	}
	
	/** 修改订单*/
	public String edit() throws Exception{
		//从数据库获取原对象
		Order order=orderService.getById(model.getId());
		System.out.println("TrolleyAction:edit======="+model);
		System.out.println("TrolleyAction:edit======="+model.getId());
//		System.out.println("this:======"+getOrderget().getCount());
		//设置修改的属性

		ActionContext context=ActionContext.getContext();
		Map<String, Object>map=context.getParameters();
		int count1=Integer.parseInt(getCount());
		System.out.println(getCount());
		Long totalprice=count1*order.getAlbumBook().getAlbum().getPrice();
//		String[] remark=(String[]) map.get("remark");
//		System.out.println(this.remark);
		order.setCount(count1);
		order.setTotalprice(totalprice);
//		order.setRemark();
		orderService.update(order);
		//保存到数据库	
		return "toList";
	}
	
	
	/**
	 * 清空购物车
	 */
	public String clear() throws Exception{
		User user=(User)ActionContext.getContext().getSession().get("user");
		List<Order> orders=trolleyService.getonOrdersByUserId(user.getTrolley().getId());
		for(Order o:orders)
		{
			orderService.delete(o.getId());
		}
		return "toList";
	}
	
	
	
	/**
	 * 完成购物车中商品的购买
	 */
	public String done() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		StringBuilder sb=new StringBuilder();
		try(BufferedReader reader = request.getReader();) {  
			char[]buff = new char[1024];  
			int len;  
		    while((len = reader.read(buff)) != -1) {  
		             sb.append(buff,0, len);  
		    }  
		}catch (IOException e) {  
		        e.printStackTrace();  
		}  
		String data = URLDecoder.decode(sb.toString(),"UTF-8");					//获取前台ajax传送过来的数据
		System.out.println("Done========"+data);
		JSONArray result=JSONArray.fromObject(data);
		Long [] getids =new Long[result.size()];
		int j=0;
		if(result.size()>0) {
			for(int i=0;i<result.size();i++) {
				JSONObject orderobj=(JSONObject) result.get(i);
				getids[j++]=Long.parseLong(orderobj.getString("id"));
			}
		}
//		for(int i=0;i<getids.length;i++)
//		{
//			System.out.println(getids[i]);
//		}
		Long[] ids= {(long)12,(long)16,(long)17};
		String updatadate=new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
		List<Order> orders=orderService.getByIds(getids);
		for( Order o:orders)
		{
			o.setSign("1");
			o.setRemark(updatadate);
			orderService.update(o);
		}
		return "toList";
	}

	
	
	public Order getOrderget() {
		return orderget;
	}

	public void setOrderget(Order orderget) {
		this.orderget = orderget;
	}

	public String getCount() {
		return count;
	}

	public void setCount(String count) {
		this.count = count;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}	
	
}
