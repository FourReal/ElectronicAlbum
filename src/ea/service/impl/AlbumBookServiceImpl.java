package ea.service.impl;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import ea.base.DaoSupportImpl;
import ea.domain.AlbumBook;
import ea.service.AlbumBookService;

@Service
@Controller
@SuppressWarnings("unchecked")
public class AlbumBookServiceImpl extends DaoSupportImpl<AlbumBook> implements AlbumBookService{

}
