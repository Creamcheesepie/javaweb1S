package com.spring.javaweb1S.service;

import java.util.List;

import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PointVO;

public interface AdminService {

	public List<PointVO> getPointList();

	public int setPointSetterUpdate(PointVO vo);

	public List<CategoryVO> getcategoryList();

	public int setCategoryInput(String categoryName);

}
