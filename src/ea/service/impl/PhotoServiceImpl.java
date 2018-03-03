package ea.service.impl;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ea.base.DaoSupportImpl;
import ea.domain.Photo;
import ea.domain.User;
import ea.service.PhotoService;

@Service
@Transactional
@SuppressWarnings("unchecked")
public class PhotoServiceImpl extends DaoSupportImpl<Photo> implements PhotoService{

	
	public List<Photo> findPhotoByUserid(Long userid) {
		return (List<Photo>) getSession().createQuery(
				"FROM Photo p WHERE p.OwnerId=?")
				.setParameter(0, userid)
				.list();
	}

}
