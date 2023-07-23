package com.spring.javaweb1S.service;

import java.util.List;

import com.spring.javaweb1S.vo.GetherVO;
import com.spring.javaweb1S.vo.PageVO;

public interface GetherService {

	public void setGetherInsert(GetherVO getherVO);

	public List<GetherVO> getAfterGetherList(PageVO pageVO);

	public int getAvailableGetherCount();


}
