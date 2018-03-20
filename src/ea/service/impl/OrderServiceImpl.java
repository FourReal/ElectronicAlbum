package ea.service.impl;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import ea.base.DaoSupportImpl;
import ea.domain.Order;
import ea.service.OrderService;


@Service
@Controller
@SuppressWarnings("unchecked")
public class OrderServiceImpl extends DaoSupportImpl<Order> implements OrderService{

}
