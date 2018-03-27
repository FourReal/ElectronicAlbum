package ea.service.impl;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import ea.base.DaoSupportImpl;
import ea.domain.AlbumBook;
import ea.domain.Photo_pro;
import ea.service.AlbumBookService;

@Service
@Controller
@SuppressWarnings("unchecked")
public class AlbumBookServiceImpl extends DaoSupportImpl<AlbumBook> implements AlbumBookService{

	/**
	 *根据用户id获取用户制作的相册书
	 */
	public List<AlbumBook> getAlbumBooksByUserId(Long id) {
		return (List<AlbumBook>)getSession().createQuery(
				"From AlbumBook a WHERE a.madeuser.id=?"
				).setParameter(0, id).list();
	}
	public AlbumBook getAlbumBookById(Long id) {
		return (AlbumBook)getSession().createQuery(
				"From AlbumBook a WHERE a.id=?"
				).setParameter(0, id);
	}
	/**
	 * 根据相册书的id获取相册书的照片信息
	 */
	public List<Photo_pro> getPhoto_prosByAbumBookId(Long id) {
		
		return (List<Photo_pro>)getSession().createQuery(
				"From Photo_pro p WHERE p.albumBook.id=?"
				).setParameter(0, id).list();
	}

}
