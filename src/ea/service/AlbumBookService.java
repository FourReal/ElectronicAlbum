package ea.service;

import java.util.List;

import ea.base.DaoSupport;
import ea.domain.AlbumBook;
import ea.domain.Photo_pro;

public interface AlbumBookService extends DaoSupport<AlbumBook>{

	List<AlbumBook> getAlbumBooksByUserId(Long id);

	List<Photo_pro> getPhoto_prosByAbumBookId(Long id);

	List<AlbumBook> findAlbumBooksByUserid(int pageNow, int pageSize);

	int findAlbumBookSize();

}
