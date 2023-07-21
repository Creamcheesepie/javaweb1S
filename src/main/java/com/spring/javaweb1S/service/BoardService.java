package com.spring.javaweb1S.service;

import java.util.List;

import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.OffendListVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReplyVO;

public interface BoardService {

	public int getCategoryByName(String categoryName);

	public String getCategoryNameByCategory(int category);

	public List<CategoryVO> getCategoryList();

	public List<BoardVO> getboardList(int category, int sin, int pageSize);

	public void setBoardWriteInput(BoardVO vo);

	public BoardVO getboardRead(int boa_idx);

	public List<BoardVO> getCategorySearchList(String searchStr, String searchOption, int category, int sin,
			int pageSize);

	public void setViewCntUp(int boa_idx);

	public int setBoardUpdateCheck(int boa_idx, int m_idx);

	public int setReplyInput(ReplyVO vo);

	public List<ReplyVO> getboardReplyList(int boa_idx,PageVO repPageVO);

	public void setAnswerReplyInput(ReplyVO vo);

	public List<BoardVO> getPrevNextContentbyBoa_idx(BoardVO vo);

	public String getBoardReccomendCheck(int boa_idx,int user_m_idx);

	public BoardVO getboardUpdateForm(int boa_idx);

	public void setBoardUpdateInput(BoardVO vo);

	public void setBoardDeleteUpdate(int boa_idx);

	public List<BoardVO> getNewBoardList();

	public boolean getboardWriteAbused(int m_idx);

	public OffendListVO getBoardAbuseInfo(int rule_idx, int m_idx);

	public boolean getReplyBanInfo(int m_idx);

	public boolean getBoardBanInfo(int m_idx);

	public String getbanListByM_idx(int m_idx);

	public List<BoardVO> getboardList(int category, int sin, int pageSize, String ban_idx);

	public List<ReplyVO> getboardReplyList(int boa_idx, PageVO repPageVO, String ban_idx);

	public List<BoardVO> getPrevNextContentbyBoa_idx(BoardVO vo, String ban_idx);

	


	





}
