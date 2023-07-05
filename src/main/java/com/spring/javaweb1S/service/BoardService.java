package com.spring.javaweb1S.service;

import java.util.List;

import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.CategoryVO;

public interface BoardService {

	public int getCategoryByName(String categoryName);

	public String getCategoryNameByCategory(int category);

	public List<CategoryVO> getCategoryList();

	public List<BoardVO> getboardList(int category, int sin, int pageSize);

	public void setBoardWriteInput(BoardVO vo);

	public BoardVO getboardRead(int boa_idx);

	public List<BoardVO> getCategorySearchList(String searchStr, String searchOption, int category, int sin,
			int pageSize);

	





}
