package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.spring.javaweb1S.vo.GetherMemberVO;
import com.spring.javaweb1S.vo.GetherReviewVO;
import com.spring.javaweb1S.vo.GetherVO;
import com.spring.javaweb1S.vo.PageVO;

public interface GetherDAO {

	public void setGetherInsert(@Param("vo") GetherVO getherVO);

	public List<GetherVO> getAfterGetherList(@Param("vo")PageVO pageVO,@Param("m_idx") int m_idx);

	public int getAvailableGetherCount();

	public GetherVO getGetherDetail(@Param("get_idx") int get_idx);

	public List<GetherVO> getGetherJoinList(@Param("get_idx") int get_idx);

	public List<GetherVO> getBanUserList(@Param("m_idx") int m_idx);

	public void setGetherJoin(@Param("get_idx") int get_idx,@Param("m_idx") int m_idx);

	public List<GetherVO> getNaBanUserList(@Param("m_idx") int m_idx);

	public void setSendAlertMessage(@Param("m_idx") int m_idx);

	public void setUpdateNowMemberGether(@Param("get_idx")int get_idx,@Param("i") int i);

	public String getGetherDate(@Param("get_idx") int get_idx,@Param("m_idx") int m_idx);

	public void setDeleteGether2_member(@Param("get_idx") int get_idx,@Param("m_idx") int m_idx);

	public List<GetherVO> getPastGetherList(@Param("vo")PageVO pageVO,@Param("m_idx") int m_idx);

	public void setGetherClearUpdate(@Param("vo") GetherMemberVO getherMemberVO);

	public List<GetherVO> getMyClearList(@Param("m_idx") int m_idx);

	public int getGetherIdx(@Param("vo") GetherVO getherVO);

	public List<GetherMemberVO> getGetherClearList(@Param("get_idx") int get_idx);

	public void setGetherClearCheck(@Param("get_idx") int get_idx,@Param("m_idx") int m_idx);

	public GetherMemberVO getGetherMemberDetail(@Param("get_idx") int get_idx,@Param("m_idx") int m_idx);

	public void setGetherReviewInsert(@Param("vo") GetherReviewVO getherReviewVO);

	public List<GetherReviewVO> getGetherReviewList(@Param("vo") PageVO pageVO);

	public GetherReviewVO getGetherReviewDetail(@Param("ger_idx") int ger_idx);



	
	
	
	
}
