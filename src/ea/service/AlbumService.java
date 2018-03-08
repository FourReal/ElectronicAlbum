package ea.service;

import java.util.List;

import ea.base.DaoSupport;
import ea.domain.Album;
import ea.domain.AlbumBgp;
import ea.domain.Photo;

public interface AlbumService extends DaoSupport<Album>{


	List<AlbumBgp> findAllbgByAlbumId(Long id);
	
	String addBgp(AlbumBgp bgp);
	
	void deleteBgp(Long id);
	
	AlbumBgp findBgpByBgpId(Long id);

	List<AlbumBgp> findAllbgp();
	
	
}
