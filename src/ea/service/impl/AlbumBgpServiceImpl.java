package ea.service.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import ea.base.DaoSupportImpl;
import ea.domain.AlbumBgp;
import ea.service.AlbumBgpService;

@Service
@Controller
@SuppressWarnings("unchecked")
public class AlbumBgpServiceImpl extends DaoSupportImpl<AlbumBgp> implements AlbumBgpService{
	
	/**
	 * 分页形式查询AlbumBgp
	 * @param pageNow
	 * @param pageSize
	 * @return
	 */
	
	public List<AlbumBgp> findAllbgp(int pageNow,int pageSize){  //查询所有AlbumBgp，实现分页 
		Session session=getSession();
		String hsql="FROM AlbumBgp";
		Query query=session.createQuery(hsql);  //执行查询操作
		query.setFirstResult((pageNow-1)*pageSize);
		query.setMaxResults(pageSize);
		List<AlbumBgp> tList=query.list();
		if(tList.size()>0)
			return tList;
		return null;
	}
	
	
	/**
	 * 获取所有相册背景图的s数量
	 * @return
	 */
	public int findBgpSize() {
		Session session=getSession();
		String hsql="FROM AlbumBgp";
		int size=session.createQuery(hsql).list().size();
		return size;
	}

}
