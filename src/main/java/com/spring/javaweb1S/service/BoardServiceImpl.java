package com.spring.javaweb1S.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.common.JavaProvide;
import com.spring.javaweb1S.dao.BoardDAO;
import com.spring.javaweb1S.dao.OffenderListDAO;
import com.spring.javaweb1S.dao.RuleSetterDAO;
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.OffendListVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReplyVO;
import com.spring.javaweb1S.vo.RuleSetterVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO boardDAO;
	
	@Autowired
	RuleSetterDAO ruleSetterDAO;
	
	@Autowired
	OffenderListDAO offenderListDAO;

	@Override
	public int getCategoryByName(String categoryName) {
		return boardDAO.getCategoryByName(categoryName);
	}

	@Override
	public String getCategoryNameByCategory(int category) {
		return boardDAO.getCategoryNameByCategory(category);
	}

	@Override
	public List<CategoryVO> getCategoryList() {
		return boardDAO.getCategoryList();
	}

	@Override
	public List<BoardVO> getboardList(int category, int sin, int pageSize) {
		return boardDAO.getboardList(category,sin,pageSize);
	}

	@Override
	public void setBoardWriteInput(BoardVO vo) {
		
		
		boardDAO.setBoardWriteInput(vo);
	}

	@Override
	public BoardVO getboardRead(int boa_idx) {
		return boardDAO.getboardRead(boa_idx);
	}

	@Override
	public List<BoardVO> getCategorySearchList(String searchStr, String searchOption, int category, int sin,int pageSize) {
		
		return  boardDAO.getCategorySearchList(searchStr,searchOption,category,sin,pageSize);
	}

	@Override
	public void setViewCntUp(int boa_idx) {
		boardDAO.setViewCntUp(boa_idx);
	}

	@Override
	public int setBoardUpdateCheck(int boa_idx, int m_idx) {
		int res = 0;
		String recommendDate = boardDAO.getRecommendDate(boa_idx,m_idx);
		if(recommendDate == null) {
			boardDAO.setBoardRecommendUpdate(boa_idx,1);
			boardDAO.setRecommendInformation(boa_idx,m_idx);
			res=1;
		}
		else if(recommendDate!=null) {
			boardDAO.setBoardRecommendUpdate(boa_idx,-1);
			boardDAO.setRecommendDelete(boa_idx,m_idx);
			res=2;
		}
		return res;
	}

	@Override
	public int setReplyInput(ReplyVO vo) {
		String rep_group = boardDAO.getMaxRep_group(vo);
		
		vo.setRep_level(0);
		
		if(rep_group != null) vo.setRep_group(Integer.parseInt(rep_group)+1);
		else vo.setRep_group(0);
			
		return boardDAO.setReplyInput(vo);
	}


	@Override
	public List<ReplyVO> getboardReplyList(int boa_idx, PageVO repPageVO) {
		
		return boardDAO.getboardReplyList(boa_idx,repPageVO);
	}

	@Override
	public void setAnswerReplyInput(ReplyVO vo) {
		boardDAO.setAnswerReplyInput(vo);
	}

	@Override
	public List<BoardVO> getPrevNextContentbyBoa_idx(BoardVO vo) {
		return boardDAO.getPrevNextContentbyBoa_idx(vo);
	}

	@Override
	public String getBoardReccomendCheck(int boa_idx,int user_m_idx) {
		return boardDAO.getBoardReccomendCheck(boa_idx,user_m_idx);
	}

	@Override
	public BoardVO getboardUpdateForm(int boa_idx) {
		return boardDAO.getboardUpdateForm(boa_idx);
	}

	@Override
	public void setBoardUpdateInput(BoardVO vo) {
		boardDAO.setBoardUpdateInput(vo);
	}

	@Override
	public void setBoardDeleteUpdate(int boa_idx) {
		boardDAO.setBoardDeleteUpdate(boa_idx);
	}

	@Override
	public List<BoardVO> getNewBoardList() {
		return boardDAO.getNewBoardList();
	}

	@Override
	public boolean getboardWriteAbused(int m_idx) {
		boolean abuseSw = false;
		JavaProvide javaProvide = new JavaProvide();
		RuleSetterVO BoardAbuseRuleVO = ruleSetterDAO.getRuleByRule_idx(2);
		
		String cdate = javaProvide.nowTimePlusInputTime(BoardAbuseRuleVO.getPenaltyTime());
		
		int[] offenderArray = offenderListDAO.getOffenderArray(cdate);
		for(int i : offenderArray) {
			if(i == m_idx) return true;
		}
		
		String limitTime = javaProvide.nowTimeMinusInputTime(BoardAbuseRuleVO.getLimitTime());
		int boardCnt = boardDAO.getBoardCntByIdxWithLimitTime(m_idx,limitTime);
		
		if (boardCnt>BoardAbuseRuleVO.getActionLimit()) {
			offenderListDAO.setOffenderUser(m_idx,BoardAbuseRuleVO,cdate);
			abuseSw = true;
		}
		System.out.println(boardCnt);
		return abuseSw;
	}

	@Override
	public OffendListVO getBoardAbuseInfo(int rule_idx, int m_idx) {
		JavaProvide javaProvide = new JavaProvide();
		RuleSetterVO BoardAbuseRuleVO = ruleSetterDAO.getRuleByRule_idx(rule_idx);
		String cdate = javaProvide.nowTimePlusInputTime(BoardAbuseRuleVO.getPenaltyTime());
		return offenderListDAO.getOffendInfoByM_idx(cdate,m_idx,rule_idx);
	}

	@Override
	public boolean getReplyBanInfo(int m_idx) {
		boolean res = false;
		int banCount= boardDAO.getBanCount(m_idx,"1_replyBan");
		if(banCount>0)res = true;
		return res;
	}

	@Override
	public boolean getBoardBanInfo(int m_idx) {
		boolean res = false;
		int banCount= boardDAO.getBanCount(m_idx,"2_boardBan");
		if(banCount>0)res = true;
		return res;
	}

	@Override
	public String getbanListByM_idx(int m_idx) {
		String temp  = "(";
		List<BoardVO> banVOS = boardDAO.getBanListByM_idx(m_idx);
		for(BoardVO tempVO : banVOS) {
			temp+= "\'"+tempVO.getM_idx()+"\',";
		}
		
		if(temp.lastIndexOf(",")>0) temp = temp.substring(0,temp.length()-1);
		else temp+="\'\'";
		temp+=")";
		return temp;
	}

	@Override
	public List<BoardVO> getboardList(int category, int sin, int pageSize, String ban_idx) {
		return boardDAO.getboardListWithBan_idx(category,sin,pageSize, ban_idx);
	}

	@Override
	public List<ReplyVO> getboardReplyList(int boa_idx, PageVO repPageVO, String ban_idx) {
		return boardDAO.getboardReplyListWithBan_idx(boa_idx,repPageVO,ban_idx);
	}

	

	





	
	
}
