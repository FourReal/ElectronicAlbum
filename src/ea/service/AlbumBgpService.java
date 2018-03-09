package ea.service;

import java.util.List;

import ea.base.DaoSupport;
import ea.domain.AlbumBgp;

public interface AlbumBgpService extends DaoSupport<AlbumBgp>{

	List<AlbumBgp> findAllbgp(int pageNow, int pageSize);

	int findBgpSize();
}
