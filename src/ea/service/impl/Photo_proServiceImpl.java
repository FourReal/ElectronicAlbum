package ea.service.impl;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import ea.base.DaoSupportImpl;
import ea.domain.Photo_pro;
import ea.service.Photo_proService;


@Service
@Transactional
@SuppressWarnings("unchecked")
public class Photo_proServiceImpl extends DaoSupportImpl<Photo_pro> implements Photo_proService{

}
