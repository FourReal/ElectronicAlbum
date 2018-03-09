package ea.service;

import java.util.List;

import ea.base.DaoSupport;
import ea.domain.Photo;

public interface PhotoService extends DaoSupport<Photo>{

	List<Photo> findPhotoByUserid(Long userid);
	
	int findPhotoSizeByUserid(Long userid);

	List<Photo> findAllPhotosByUserid(int pageNow, int pageSize, Long userid);
}
