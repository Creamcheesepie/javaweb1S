package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReplyVO;

public interface BoardDAO {

	public int getCategoryByName(@Param("categoryName") String categoryName);

	public String getCategoryNameByCategory(@Param("category") int category);

	public List<CategoryVO> getCategoryList();

	public List<BoardVO> getboardList(@Param("category") int category,@Param("sin") int sin,@Param("pageSize") int pageSize);

	public void setBoardWriteInput(@Param("vo") BoardVO vo);

	public BoardVO getboardRead(@Param("boa_idx") int boa_idx);

	public List<BoardVO> getCategorySearchList(@Param("searchStr") String searchStr,@Param("searchOption") String searchOption,@Param("category") int category,@Param("sin") int sin,@Param("pageSize") int pageSize);

	public void setViewCntUp(@Param("boa_idx") int boa_idx);

	public String getRecommendDate(@Param("boa_idx") int boa_idx,@Param("m_idx") int m_idx);

	public void setBoardRecommendUpdate(@Param("boa_idx") int boa_idx,@Param("i") int i);

	public void setRecommendInformation(@Param("boa_idx") int boa_idx,@Param("m_idx") int m_idx);

	public void setRecommendDelete(@Param("boa_idx") int boa_idx,@Param("m_idx") int m_idx);

	public int setReplyInput(@Param("vo") ReplyVO vo);

	public String getMaxRep_group(@Param("vo") ReplyVO vo);

	public List<ReplyVO> getboardReplyList(@Param("boa_idx") int boa_idx,@Param("vo") PageVO repPageVO);

	public void setAnswerReplyInput(@Param("vo") ReplyVO vo);

	public List<BoardVO> getPrevNextContentbyBoa_idx(@Param("vo") BoardVO vo);

	public String getBoardReccomendCheck(@Param("boa_idx") int boa_idx,@Param("user_m_idx")  int user_m_idx);

	public BoardVO getboardUpdateForm(@Param("boa_idx") int boa_idx);

	public void setBoardUpdateInput(@Param("vo") BoardVO vo);

	public void setBoardDeleteUpdate(@Param("boa_idx") int boa_idx);

	public List<BoardVO> getNewBoardList();

	public int getBoardCntByIdxWithLimitTime(@Param("m_idx") int m_idx,@Param("limitTime") String limitTime);

	public int getBanCount(@Param("m_idx") int m_idx,@Param("banType") String banType);



	

}
