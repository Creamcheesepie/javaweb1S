package com.spring.javaweb1S.service;

import java.util.List;

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


}
