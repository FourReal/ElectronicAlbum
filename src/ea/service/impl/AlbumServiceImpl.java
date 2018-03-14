package ea.service.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;
import ea.base.DaoSupportImpl;

import ea.domain.Album;
import ea.domain.AlbumBgp;
import ea.domain.Photo;
import ea.domain.User;
import ea.service.AlbumService;

@Service
@Controller
@SuppressWarnings("unchecked")
public class AlbumServiceImpl extends DaoSupportImpl<Album> implements AlbumService{

	/**获取相册的所有背景图片*/
	public List<AlbumBgp> findAllbgByAlbumId(Long id) {
//		System.out.println("album++++++++++"+id);
		return (List<AlbumBgp>) getSession().createQuery(				
			    "FROM AlbumBgp a WHERE a.album.id=?")
				.setParameter(0, id)
				.list();
	}
	
	
	/**
	 * 通过相册模板的id分页展示相册模板
	 * @return
	 */
	public List<AlbumBgp> findAlbumBgpsByAlbumid(int pageNow, int pageSize,Long albumid) {
		Session session=getSession();
		System.out.println("findAlbumBgpsByAlbumid+++++++++++"+albumid);
		String hsql="FROM AlbumBgp a WHERE a.album.id=?";
		Query query=session.createQuery(hsql).setParameter(0, albumid);  //执行查询操作
		query.setFirstResult((pageNow-1)*pageSize);
		query.setMaxResults(pageSize);
		List<AlbumBgp> tList=query.list();
		if(tList.size()>0)
			return tList;
		return null;
	
	}
	
	
	/**
	 * 获取某个相册的Albumbgp数量
	 * @return
	 */
	public int findAlbumBgpSizeByAlbumid(Long albumid) {
		Session session=getSession();
		String hsql="FROM AlbumBgp a WHERE a.album.id=?";
		int size=session.createQuery(hsql).setParameter(0, albumid).list().size();
		return size;
	}
	
	
	
	
	
	/**
	 * 通过某个AlbumBgp 的id查找AlbumBgp
	 * return 获取到的AlbumBgp或者null
	 */
	public AlbumBgp findBgpByBgpId(Long id) {
		if(id==null)
			return null;
		else
			return (AlbumBgp)getSession().get(AlbumBgp.class,id);
	}
	
	/**
	 * 添加AlbumBgp，参数为某个AlbumBgp
	 */
	public String addBgp(AlbumBgp bgp) {
		if(bgp==null)
			return null;
		else
		{
			getSession().save(bgp);
			return "sucess";
		}
	}
	
	/** 根据AlbumBgp的id删除AlbumBgp*/
	public void deleteBgp(Long id)
	{
		AlbumBgp bgp=(AlbumBgp)getSession().get(AlbumBgp.class, id);
		getSession().delete(bgp);
	}
	
	/**
	 * 通过某个AlbumBgp查找获取到对应的Album
	 * return 返回某个Album
	 */
	public Album getAlbumByBgp(AlbumBgp bgp) {
		return bgp.getAlbum();
	}

	public List<AlbumBgp> findAllbgp() {
		
		return (List<AlbumBgp>) getSession().createQuery(				
			    "FROM AlbumBgp a ")
				.list();
	}


	/**
	 * 通过用户的id获取到该用户的相册
	 */
	public List<Album> findAlbumByUserid(Long id) {
//		return (List<Album>) getSession().createQuery(				
//			    "FROM Album a WHERE a.users.id=?")
//				.setParameter(0, id)
//				.list();
		return null;
	}
}
