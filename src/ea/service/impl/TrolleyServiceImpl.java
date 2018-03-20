package ea.service.impl;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import ea.base.DaoSupportImpl;
import ea.domain.Order;
import ea.domain.Trolley;
import ea.service.TrolleyService;

@Service
@Controller
@SuppressWarnings("unchecked")
public class TrolleyServiceImpl extends DaoSupportImpl<Trolley>	implements TrolleyService{

	/**
	 * 用户查看购物车中的未完成的订单信息
	 */
	public List<Order> getonOrdersByUserId(Long id) {
		
		return (List<Order>)getSession().createQuery(
				"From Order o WHERE o.trolley.id=? AND o.sign=?"
				).setParameter(0, id)
				.setParameter(1, "0")
				.list();
	}

	/**
	 * 用户查看购物车中的完成的历史订单信息
	 */
	public List<Order> getoldOrdersByUserId(Long id) {
		// TODO Auto-generated method stub
		return (List<Order>)getSession().createQuery(
				"From Order o WHERE o.trolley.id=? AND o.sign=?"
				).setParameter(0, id)
				.setParameter(1, "1")
				.list();
	}

}
