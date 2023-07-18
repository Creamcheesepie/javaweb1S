package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.PointVO;
import com.spring.javaweb1S.vo.ReportCategoryVO;
import com.spring.javaweb1S.vo.ReportVO;

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
	
}
