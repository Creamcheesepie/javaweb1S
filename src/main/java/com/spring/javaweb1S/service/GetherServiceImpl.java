package com.spring.javaweb1S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.GetherDAO;
import com.spring.javaweb1S.vo.GetherVO;
import com.spring.javaweb1S.vo.PageVO;

@Service
public class GetherServiceImpl implements GetherService {
	@Autowired
	GetherDAO getherDAO;

	@Override
	public void setGetherInsert(GetherVO getherVO) {
		getherDAO.setGetherInsert(getherVO);
	}

	@Override
	public List<GetherVO> getAfterGetherList(PageVO pageVO) {
		return getherDAO.getAfterGetherList( pageVO);
		
	}

	@Override
	public int getAvailableGetherCount() {
		return getherDAO.getAvailableGetherCount();
	}
}
