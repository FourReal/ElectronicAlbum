package ea.base;

import java.lang.reflect.ParameterizedType;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.List;

import javax.annotation.Resource;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.transaction.annotation.Transactional;

//该注解可以被继承
//@Transactional对父类中的方法无效
@Transactional
@SuppressWarnings("unchecked")
public class DaoSupportImpl<T> implements DaoSupport<T>{

	@Resource
	private SessionFactory sessionFactory;
	private Class<T> clazz=null;   //待解决的问题
	
	public DaoSupportImpl() {
		//使用反射技术得到T的真实类型
		ParameterizedType pt=(ParameterizedType) this.getClass().getGenericSuperclass();
		this.clazz=(Class<T>) pt.getActualTypeArguments()[0];
//		System.out.println("clazz--->"+clazz);
	}
	
	
	/**
	 * 获取当前可用session
	 * @return
	 */
	protected Session getSession() {
		return sessionFactory.getCurrentSession();
	} 
	
	
	public void save(T entity) {
		getSession().save(entity);
	}

	
	public void delete(Long id) {
		Object obj=getById(id);
		if(obj!=null)
		{
			getSession().delete(obj);
		}
		
	}

	
	public void update(T entity) {
		getSession().update(entity);
		
	}

	
	public T getById(Long id) {
		if(id==null)
			return null;
		else
			return (T)getSession().get(clazz, id);
	}

	
	public List<T> getByIds(Long[] ids) {
		if(ids==null||ids.length==0)
			return Collections.EMPTY_LIST;
		else 
			return getSession().createQuery(
				"FROM "+clazz.getSimpleName()+" WHERE id IN (:ids)")//
				.setParameterList("ids", ids)
				.list();
	}


	
	public List<T> findAll() {

		return getSession().createQuery(//
				"FROM "+clazz.getSimpleName())//
				.list();
	}

}
