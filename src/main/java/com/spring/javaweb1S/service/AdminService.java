package com.spring.javaweb1S.service;

import java.util.List;

import com.spring.javaweb1S.vo.AskVO;
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.PointVO;
import com.spring.javaweb1S.vo.ReportCategoryVO;
import com.spring.javaweb1S.vo.ReportVO;

public interface AdminService {

	public List<PointVO> getPointList();

	public int setPointSetterUpdate(PointVO vo);

	public List<CategoryVO> getcategoryList();

	public int setCategoryInput(String categoryName);

	public List<ReportCategoryVO> getReportCategoryList();

	public List<ReportVO> getReportList(String afterDate, String beforeDate, int rep_category, PageVO pageVO);

	public ReportVO getReportDetail(int rep_idx);

	public void setDelete(String tableName, String idxName, int reported_idx);

	public void setBanList(int reported_m_idx, String banType, String penaltyTime, String takeContent);

	public void setReported_m_idx_Level(int reported_m_idx, String banType);

	public void setReportResultUpdate(int rep_idx, int takeSw, String takeContent);

	public List<AskVO> getAskCategoryList();

	public List<AskVO> getAskList(String afterDate, String beforeDate, int ask_category, PageVO pageVO);

	public AskVO getAskDetail(int ask_idx);

	public void setAskTake(int ask_idx, String takeContent);

	public int[] getBoardRuleInfo(int rule_idx);

	public void setUpdateRuleSetterLimitOption(int rule_idx, String strLimitTime, int actionLimit);

	public void setUpdateRuleSetterPenaltyOption(int rule_idx, String strPenaltyTime);

	public List<ReportVO> getBanList();

	public ReportVO getBandetail(int ban_idx);

	public void setBanOff(int ban_idx);

	public void setBanUpdate(int ban_idx, String banType, String cdate, String reason);

	public List<BoardVO> getAdminBoardList(PageVO pageVO);

	public void setBoardRestore(int boa_idx);

	public void setBoardDelete(int boa_idx);

	public void setDateBaseDelete(int boa_idx);

	



}
