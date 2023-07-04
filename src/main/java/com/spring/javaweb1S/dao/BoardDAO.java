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

}
