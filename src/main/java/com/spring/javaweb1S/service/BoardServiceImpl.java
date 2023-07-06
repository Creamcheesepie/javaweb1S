package com.spring.javaweb1S.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.BoardDAO;
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReplyVO;

@Service
public class BoardServiceImpl implements BoardService {
	@Autowired
	BoardDAO boardDAO;

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





	
	
}
