package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.AskVO;
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.PointVO;
import com.spring.javaweb1S.vo.ReportCategoryVO;
import com.spring.javaweb1S.vo.ReportVO;
import com.spring.javaweb1S.vo.RuleSetterVO;

public interface AdminDAO {

	public List<PointVO> getPointList();

	public int setPointSetterUpdate(@Param("vo") PointVO vo);

	public List<CategoryVO> getcategoryList();

	public int setCategoryInput(@Param("categoryName") String categoryName,@Param("maxCategory") int maxCategory);

	public int getMaxcategory();

	public List<ReportCategoryVO> getReportCategoryList();

	public List<ReportVO> getReportList(@Param("afterDate") String afterDate,@Param("beforeDate") String beforeDate,@Param("rep_category") int rep_category,@Param("pageVO") PageVO pageVO);

	public ReportVO getReportByRep_idx(@Param("rep_idx") int rep_idx);

	public ReportCategoryVO getReportCategoryByCategory(@Param("rep_category") int rep_category);
	
	public ReportVO getExtraInformation(@Param("rcVO") ReportCategoryVO rcVO,@Param("vo") ReportVO vo);
	
	public void setDelete(@Param("tableName") String tableName,@Param("idxName") String idxName,@Param("idx") int reported_idx);
	
	public void setBanList(@Param("m_idx") int reported_m_idx,@Param("banType") String banType,@Param("cdate") String paneltyTime,@Param("reason") String takeContent);

	public void setMemberLevel(@Param("m_idx") int reported_m_idx,@Param("level") int i);

	public void setReportResultUpdate(@Param("rep_idx") int rep_idx,@Param("takeSw") int takeSw,@Param("takeContent") String takeContent);

	public List<AskVO> getAskCategoryList();

	public List<AskVO> getAskList(@Param("afterDate") String afterDate,@Param("beforeDate") String beforeDate,@Param("ask_category") int ask_category,@Param("pageVO") PageVO pageVO);

	public AskVO getAskDetail(@Param("ask_idx")int ask_idx);

	public void setAskTake(@Param("ask_idx") int ask_idx,@Param("takeContent") String takeContent);

	public RuleSetterVO getRuleInfo(@Param("rule_idx")int rule_idx);

	public void setUpdateRuleSetterLimitOption(@Param("rule_idx") int rule_idx,@Param("strLimitTime") String strLimitTime,@Param("actionLimit") int actionLimit);

	public void setUpdateRuleSetterPenaltyOption(@Param("rule_idx") int rule_idx,@Param("strPenaltyTime") String strLimitTime);

	public List<ReportVO> getBanList();

	public ReportVO getBandetail(@Param("ban_idx") int ban_idx);

	public void setBanOff(@Param("ban_idx") int ban_idx);

	public void setBanUpdate(@Param("ban_idx")int ban_idx,@Param("banType") String banType,@Param("cdate") String cdate,@Param("reason") String reason);

	public List<BoardVO> getAdminBoardList(@Param("vo") PageVO pageVO);

	public void setBoardRestore(@Param("boa_idx") int boa_idx);

	public void setBoardDelete(@Param("boa_idx") int boa_idx);

	public void setDateBaseDelete(@Param("boa_idx") int boa_idx);
	
}
