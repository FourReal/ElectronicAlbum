package ea.service;

import java.util.List;

import ea.base.DaoSupport;
import ea.domain.Order;
import ea.domain.Trolley;

public interface TrolleyService extends DaoSupport<Trolley>{

	List<Order> getonOrdersByUserId(Long id);

	List<Order> getoldOrdersByUserId(Long id);

}
