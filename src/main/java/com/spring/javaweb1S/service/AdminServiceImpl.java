package com.spring.javaweb1S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.AdminDAO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PointVO;

@Service
public class AdminServiceImpl implements AdminService {
	@Autowired
	AdminDAO adminDAO;
	
	@Override
	public List<PointVO> getPointList() {
		
		return adminDAO.getPointList();
	}

	@Override
	public int setPointSetterUpdate(PointVO vo) {
		return adminDAO.setPointSetterUpdate(vo);
	}

	@Override
	public List<CategoryVO> getcategoryList() {
		return adminDAO.getcategoryList();
	}

	@Override
	public int setCategoryInput(String categoryName) {
		int maxCategory = adminDAO.getMaxcategory()+1;
		
		return adminDAO.setCategoryInput(categoryName,maxCategory);
	}
	
}