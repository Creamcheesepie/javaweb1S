package com.spring.javaweb1S.pagination;

import com.spring.javaweb1S.vo.PageVO;

public interface PageProcess {
	public PageVO pageProcessor(String tableName, int pageSize,int nowPage,int blockSize);

	public PageVO pageProcessorWithCategory(String string, int nowPage, int pageSize, int blockSize, int category);
}
