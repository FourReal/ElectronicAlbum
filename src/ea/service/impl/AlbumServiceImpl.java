package ea.service.impl;

import org.springframework.stereotype.Controller;
import org.springframework.stereotype.Service;

import ea.base.DaoSupportImpl;
import ea.domain.Album;
import ea.service.AlbumService;

@Service
@Controller
@SuppressWarnings("unchecked")
public class AlbumServiceImpl extends DaoSupportImpl<Album> implements AlbumService{

}
