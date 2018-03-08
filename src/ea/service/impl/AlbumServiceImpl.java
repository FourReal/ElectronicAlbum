package ea.service.impl;

import java.util.List;

import org.apache.catalina.Session;
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
}
