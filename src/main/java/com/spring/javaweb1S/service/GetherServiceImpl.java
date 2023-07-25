package com.spring.javaweb1S.service;

import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.rmi.server.UID;
import java.util.List;
import java.util.UUID;

import javax.imageio.ImageIO;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.google.zxing.BarcodeFormat;
import com.google.zxing.WriterException;
import com.google.zxing.client.j2se.MatrixToImageConfig;
import com.google.zxing.client.j2se.MatrixToImageWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.spring.javaweb1S.dao.GetherDAO;
import com.spring.javaweb1S.vo.GetherMemberVO;
import com.spring.javaweb1S.vo.GetherReviewVO;
import com.spring.javaweb1S.vo.GetherVO;
import com.spring.javaweb1S.vo.PageVO;

@Service
public class GetherServiceImpl implements GetherService {
	@Autowired
	GetherDAO getherDAO;

	@Override
	public void setGetherInsert(GetherVO getherVO) {
		getherDAO.setGetherInsert(getherVO);
		int get_idx = getherDAO.getGetherIdx(getherVO);
		getherDAO.setGetherJoin(get_idx, getherVO.getM_idx());
	}

	@Override
	public List<GetherVO> getAfterGetherList(PageVO pageVO, int m_idx) {
		return getherDAO.getAfterGetherList( pageVO,m_idx);
		
	}

	@Override
	public int getAvailableGetherCount() {
		return getherDAO.getAvailableGetherCount();
	}

	@Override
	public GetherVO getGetherDetail(int get_idx) {
		return getherDAO.getGetherDetail(get_idx);
	}

	@Override
	public List<GetherVO> getGetherJoinList(int get_idx) {
		return getherDAO.getGetherJoinList(get_idx);
	}

	@Override
	public boolean banUserCheck(int m_idx, int get_idx) {
		List<GetherVO> banListVOS = getherDAO.getBanUserList(m_idx);
		List<GetherVO> getherMemberListVOS = getherDAO.getGetherJoinList(get_idx);
		
		for(GetherVO banListVO : banListVOS) {
			for(GetherVO gmVO : getherMemberListVOS) {
				if(banListVO.getM_idx() == gmVO.getM_idx()) return true;
			}
		}
		
		return false;
	}

	@Override
	public void setGetherJoin(int get_idx, int m_idx) {
		List<GetherVO> naBanListVOS = getherDAO.getNaBanUserList(m_idx);
		List<GetherVO> getherMemberListVOS = getherDAO.getGetherJoinList(get_idx);
		
		for(GetherVO naBanVO : naBanListVOS) {
			for(GetherVO gmVO : getherMemberListVOS) {
				if(naBanVO.getM_idx() == gmVO.getM_idx()) {
					getherDAO.setSendAlertMessage(naBanVO.getM_idx());
				}
			}
		}

		getherDAO.setUpdateNowMemberGether(get_idx,1);
		getherDAO.setGetherJoin(get_idx,m_idx);
	}

	@Override
	public int getM_idxJoinCheck(int get_idx, int m_idx) {
		String joinDate = getherDAO.getGetherDate(get_idx,m_idx);
		if(joinDate!=null) return 1;
		else return 0;
	}

	@Override
	public void setDeleteGether2_member(int get_idx, int m_idx) {
		getherDAO.setDeleteGether2_member(get_idx,m_idx);
		getherDAO.setUpdateNowMemberGether(get_idx,-1);
	}

	@Override
	public List<GetherVO> getPastGetherList(PageVO pageVO, int m_idx) {
		return getherDAO.getPastGetherList( pageVO,m_idx);
	}

	@Override
	public String setQRCode(String link,String realPath) {
		String QRName = "";
		UUID uuid = UUID.randomUUID();
		String uid = uuid.toString().substring(0, 5);
		QRName = uid;
		try {
			File file = new File(realPath);
			if(!file.exists()) file.mkdirs();
			link = new String(link.getBytes("UTF-8"),"ISO-8859-1");
			
			int qrCodeColor = 0xFF000000;
			int	qrCodeBackColor = 0xFFFFFFFF;
			
			QRCodeWriter qrCodeWriter = new QRCodeWriter();
			
			BitMatrix bitMatrix = qrCodeWriter.encode(link, BarcodeFormat.QR_CODE, 200, 200);
			
			MatrixToImageConfig matrixToImageConfig = new MatrixToImageConfig(qrCodeColor, qrCodeBackColor);
			
			BufferedImage bufferedImage= MatrixToImageWriter.toBufferedImage(bitMatrix, matrixToImageConfig);
			
			ImageIO.write(bufferedImage, "png", new File(realPath+QRName+".png"));
		} catch (IOException e) {
			System.out.println("IO 오류 : " + e.getStackTrace());
		} catch (WriterException e) {
			System.out.println("라이터 오류 : "+ e.getStackTrace());
		}
		
		return QRName;
	}

	@Override
	public void setGetherClearUpdate(GetherMemberVO getherMemberVO) {
		getherDAO.setGetherClearUpdate(getherMemberVO);
		
	}

	@Override
	public List<GetherVO> getMyClearList(int m_idx) {
		return getherDAO.getMyClearList(m_idx);
	}

	@Override
	public List<GetherMemberVO> getGetherClearList(int get_idx) {
		return getherDAO.getGetherClearList(get_idx);
	}

	@Override
	public void setGetherClearCheck(int get_idx, int m_idx) {
		getherDAO.setGetherClearCheck(get_idx,m_idx);
	}

	@Override
	public GetherMemberVO getGetherMemberDetail(int get_idx, int m_idx) {
		return getherDAO.getGetherMemberDetail(get_idx,m_idx);
	}

	@Override
	public void setGetherReviewInsert(GetherReviewVO getherReviewVO) {
		getherDAO.setGetherReviewInsert(getherReviewVO);
	}

	@Override
	public List<GetherReviewVO> getGetherReviewList(PageVO pageVO) {
		return getherDAO.getGetherReviewList(pageVO);
	}

	@Override
	public GetherReviewVO getGetherReviewDetail(int ger_idx) {
		return getherDAO.getGetherReviewDetail(ger_idx);
	}
}
