package com.spring.javaweb1S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.AdminDAO;
import com.spring.javaweb1S.vo.AskVO;
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.PointVO;
import com.spring.javaweb1S.vo.ReportCategoryVO;
import com.spring.javaweb1S.vo.ReportVO;
import com.spring.javaweb1S.vo.RuleSetterVO;

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

	@Override
	public List<AskVO> getAskCategoryList() {
		return adminDAO.getAskCategoryList();
	}

	@Override
	public List<AskVO> getAskList(String afterDate, String beforeDate, int ask_category, PageVO pageVO) {
		return adminDAO.getAskList(afterDate,beforeDate,ask_category,pageVO);
	}

	@Override
	public AskVO getAskDetail(int ask_idx) {
		return adminDAO.getAskDetail(ask_idx);
	}

	@Override
	public void setAskTake(int ask_idx, String takeContent) {
		adminDAO.setAskTake(ask_idx,takeContent);
	}

	@Override
	public int[] getBoardRuleInfo(int rule_idx) {
		int[] res = new int[5];	
		RuleSetterVO tempVO = adminDAO.getRuleInfo(rule_idx);
		System.out.println(tempVO);
		res[0] = Integer.parseInt(tempVO.getLimitTime().substring(0,2));
		res[1] = Integer.parseInt(tempVO.getLimitTime().substring(3,tempVO.getLimitTime().length()));
		res[2] = Integer.parseInt(tempVO.getPenaltyTime().substring(0,2));
		res[3] = Integer.parseInt(tempVO.getPenaltyTime().substring(3,tempVO.getPenaltyTime().length()));
		res[4] = tempVO.getActionLimit();
		return res;
	}

	@Override
	public void setUpdateRuleSetterLimitOption(int rule_idx, String strLimitTime, int actionLimit) {
		adminDAO.setUpdateRuleSetterLimitOption(rule_idx,strLimitTime,actionLimit);
	}

	@Override
	public void setUpdateRuleSetterPenaltyOption(int rule_idx, String strPenaltyTime) {
		adminDAO.setUpdateRuleSetterPenaltyOption(rule_idx,strPenaltyTime);
	}

	@Override
	public List<ReportVO> getBanList() {
		return adminDAO.getBanList();
	}

	@Override
	public ReportVO getBandetail(int ban_idx) {
		return adminDAO.getBandetail(ban_idx);
	}

	@Override
	public void setBanOff(int ban_idx) {
		adminDAO.setBanOff(ban_idx);
	}

	@Override
	public void setBanUpdate(int ban_idx, String banType, String cdate, String reason) {
		adminDAO.setBanUpdate(ban_idx,banType,cdate,reason);
	}

	@Override
	public List<BoardVO> getAdminBoardList(PageVO pageVO) {
		return adminDAO.getAdminBoardList(pageVO);
	}

	@Override
	public void setBoardRestore(int boa_idx) {
		adminDAO.setBoardRestore(boa_idx);
	}

	@Override
	public void setBoardDelete(int boa_idx) {
		adminDAO.setBoardDelete(boa_idx);
	}

	@Override
	public void setDateBaseDelete(int boa_idx) {
		adminDAO.setDateBaseDelete(boa_idx);
	}

}
