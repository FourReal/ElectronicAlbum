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
	
	List<AlbumBgp> findAlbumBgpsByAlbumid(int pageNow, int pageSize,Long albumid);
	
	int findAlbumBgpSizeByAlbumid(Long albumid);

	List<Album> findAlbumByUserid(Long id);
}
