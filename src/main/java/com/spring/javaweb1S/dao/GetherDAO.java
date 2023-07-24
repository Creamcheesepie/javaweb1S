package com.spring.javaweb1S.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

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



	
	
	
	
}
