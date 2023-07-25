package com.spring.javaweb1S.service;

import java.util.List;

import com.spring.javaweb1S.vo.GetherMemberVO;
import com.spring.javaweb1S.vo.GetherReviewVO;
import com.spring.javaweb1S.vo.GetherVO;
import com.spring.javaweb1S.vo.PageVO;

public interface GetherService {

	public void setGetherInsert(GetherVO getherVO);

	public List<GetherVO> getAfterGetherList(PageVO pageVO,int m_idx);

	public int getAvailableGetherCount();

	public GetherVO getGetherDetail(int get_idx);

	public List<GetherVO> getGetherJoinList(int get_idx);

	public boolean banUserCheck(int m_idx, int get_idx);

	public void setGetherJoin(int get_idx, int m_idx);

	public int getM_idxJoinCheck(int get_idx, int m_idx);

	public void setDeleteGether2_member(int get_idx, int m_idx);

	public List<GetherVO> getPastGetherList(PageVO pageVO, int m_idx);

	public String setQRCode(String link,String realPath);

	public void setGetherClearUpdate(GetherMemberVO getherMemberVO);

	public List<GetherVO> getMyClearList(int m_idx);

	public List<GetherMemberVO> getGetherClearList(int get_idx);

	public void setGetherClearCheck(int get_idx, int m_idx);

	public GetherMemberVO getGetherMemberDetail(int get_idx, int m_idx);

	public void setGetherReviewInsert(GetherReviewVO getherReviewVO);

	public List<GetherReviewVO> getGetherReviewList(PageVO pageVO);

	public GetherReviewVO getGetherReviewDetail(int ger_idx);


}
