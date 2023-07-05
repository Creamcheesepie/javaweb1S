package com.spring.javaweb1S.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.BoardDAO;
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.CategoryVO;

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





	
	
}
