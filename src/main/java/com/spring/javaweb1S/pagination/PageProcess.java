package com.spring.javaweb1S.pagination;

import com.spring.javaweb1S.vo.PageVO;

public interface PageProcess {
	public PageVO pageProcessor(String tableName, int pageSize,int nowPage,int blockSize);

	public PageVO pageProcessorWithCategory(String tableName, int nowPage, int pageSize, int blockSize, int category);

	public PageVO pageProcessorBoardSeach(String searchStr, String searchOption, int nowPage, int pageSize, int blockSize,
			int category);

	public PageVO pageProcessorByBoa_idx(String string, int repPageSize, int repNowPage, int blockSize, int boa_idx);
	
	public int pageFinderByBoa_idx(String tableName, int pageSize, int idx,String idxName);
	
	public int pageFinderByBoa_idxWithCategory(String tableName, int pageSize, int idx,String idxName,int category);
}
