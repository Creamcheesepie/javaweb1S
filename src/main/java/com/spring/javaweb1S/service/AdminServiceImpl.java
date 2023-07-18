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
		vo.setTableName(rcVO.getTableName());
		vo.setIdxName(rcVO.getIdxName());
		vo.setReported_m_idx(tempVO.getReported_m_idx());
		vo.setReportedContent(tempVO.getReportedContent());
		vo.setReportednickName(tempVO.getReportednickName());
		vo.setReportedTitle(tempVO.getReportedTitle());
		
		return vo;
	}

	@Override
	public void setDelete(String tableName, String idxName, int reported_idx) {
		adminDAO.setDelete( tableName, idxName, reported_idx);
	}

	@Override
	public void setBanList(int reported_m_idx, String banType, String penaltyTime, String takeContent) {
		takeContent = "신고사항 처리로 인한 제제입니다.<hr>" + takeContent;
		adminDAO.setBanList(reported_m_idx,banType,penaltyTime,takeContent);
	}

	@Override
	public void setReported_m_idx_Level(int reported_m_idx, String banType) {
		String[] arrBanType = banType.split("_");
		
		if(arrBanType[0].equals("3")) {
			adminDAO.setMemberLevel(reported_m_idx,5);
		}
		else if(arrBanType[0].equals("4")) {
			adminDAO.setMemberLevel(reported_m_idx,6);
		}
	}

	@Override
	public void setReportResultUpdate(int rep_idx, int takeSw, String takeContent) {
		adminDAO.setReportResultUpdate( rep_idx, takeSw, takeContent);
	}

}
