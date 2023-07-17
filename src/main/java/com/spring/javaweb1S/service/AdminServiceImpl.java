package com.spring.javaweb1S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.AdminDAO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.PointVO;
import com.spring.javaweb1S.vo.ReportCategoryVO;
import com.spring.javaweb1S.vo.ReportVO;

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

	@Override
	public List<ReportCategoryVO> getReportCategoryList() {
		return adminDAO.getReportCategoryList();
	}

	@Override
	public List<ReportVO> getReportList(String afterDate, String beforeDate, int rep_category, PageVO pageVO) {
		
		return adminDAO.getReportList(afterDate,beforeDate,rep_category,pageVO);
	}

	@Override
	public ReportVO getReportDetail(int rep_idx) {
		ReportVO vo = new ReportVO();
		vo = adminDAO.getReportByRep_idx(rep_idx);
		ReportCategoryVO rcVO = adminDAO.getReportCategoryByCategory(vo.getRep_category());
		ReportVO tempVO = adminDAO.getExtraInformation(rcVO,vo);
		vo.setReportedContent(tempVO.getReportedContent());
		vo.setReportednickName(tempVO.getReportednickName());
		vo.setReportedTitle(tempVO.getReportedTitle());
		
		return vo;
	}

}
