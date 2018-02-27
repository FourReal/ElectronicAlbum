package ea.base;

import java.util.List;

public interface DaoSupport <T>{

	void save(T entity);
	
	void delete(Long id);
	
	void update(T entity);
	
	T getById(Long id);
	
	/**
	 * 按id查询某些
	 * @param ids
	 * @return
	 */
	List<T> getByIds(Long[] ids);
	
	/**
	 * 查询所有
	 * @return
	 */
	List<T> findAll();
}
