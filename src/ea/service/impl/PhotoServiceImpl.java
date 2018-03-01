package ea.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ea.base.DaoSupportImpl;
import ea.domain.Photo;
import ea.service.PhotoService;

@Service
@Transactional
public class PhotoServiceImpl extends DaoSupportImpl<Photo> implements PhotoService{

}
