package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.GetherVO;
import com.spring.javaweb1S.vo.PageVO;

public interface GetherDAO {

	public void setGetherInsert(@Param("vo") GetherVO getherVO);

	public List<GetherVO> getAfterGetherList(@Param("vo")PageVO pageVO);

	public int getAvailableGetherCount();

	
	
	
	
}
