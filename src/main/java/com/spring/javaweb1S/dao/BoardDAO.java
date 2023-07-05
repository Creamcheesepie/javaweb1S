package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.CategoryVO;

public interface BoardDAO {

	public int getCategoryByName(@Param("categoryName") String categoryName);

	public String getCategoryNameByCategory(@Param("category") int category);

	public List<CategoryVO> getCategoryList();

	public List<BoardVO> getboardList(@Param("category") int category,@Param("sin") int sin,@Param("pageSize") int pageSize);

	public void setBoardWriteInput(@Param("vo") BoardVO vo);

	public BoardVO getboardRead(@Param("boa_idx") int boa_idx);

	public List<BoardVO> getCategorySearchList(@Param("searchStr") String searchStr,@Param("searchOption") String searchOption,@Param("category") int category,@Param("sin") int sin,@Param("pageSize") int pageSize);

}
