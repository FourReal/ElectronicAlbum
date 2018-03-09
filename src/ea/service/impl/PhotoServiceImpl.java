package ea.service.impl;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ea.base.DaoSupportImpl;
import ea.domain.AlbumBgp;
import ea.domain.Photo;
import ea.domain.User;
import ea.service.PhotoService;

@Service
@Transactional
@SuppressWarnings("unchecked")
public class PhotoServiceImpl extends DaoSupportImpl<Photo> implements PhotoService{

	/**
	 * 通过用户id
	 * 获取用户上传的照片
	 */
	public List<Photo> findPhotoByUserid(Long userid) {
		return (List<Photo>) getSession().createQuery(
				"FROM Photo p WHERE p.OwnerId=?")
				.setParameter(0, userid)
				.list();
	}

	/**
	 * 通过用户id
	 * 分页形式查询Photo
	 */
	public List<Photo> findAllPhotosByUserid(int pageNow, int pageSize,Long userid) {
		Session session=getSession();
		String hsql="FROM Photo p WHERE p.OwnerId=?";
		Query query=session.createQuery(hsql).setParameter(0, userid);  //执行查询操作
		query.setFirstResult((pageNow-1)*pageSize);
		query.setMaxResults(pageSize);
		List<Photo> tList=query.list();
		if(tList.size()>0)
			return tList;
		return null;
	
	}
	
	
	/**
	 * 获取用户上传的照片数量
	 * @return
	 */
	public int findPhotoSizeByUserid(Long userid) {
		Session session=getSession();
		String hsql="FROM Photo p WHERE p.OwnerId=?";
		int size=session.createQuery(hsql).setParameter(0, userid).list().size();
		return size;
	}

}
