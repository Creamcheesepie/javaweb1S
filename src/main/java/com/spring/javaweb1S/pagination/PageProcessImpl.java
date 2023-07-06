package com.spring.javaweb1S.pagination;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.spring.javaweb1S.dao.PageDAO;
import com.spring.javaweb1S.vo.PageVO;

@Controller
public class PageProcessImpl implements PageProcess {
	@Autowired
	PageDAO pageDAO;
	
	@Override
	public PageVO pageProcessor(String tableName, int pageSize, int nowPage,int blockSize) {
		PageVO vo = new PageVO();
		
		vo.setNowPage(nowPage);
		vo.setPageSize(pageSize);
		vo.setTRC(pageDAO.getTRC(tableName));
		int totalPage =(vo.getTRC()%pageSize)==0?(vo.getTRC()/pageSize) : (vo.getTRC()/pageSize)+1;
		vo.setTotalPage(totalPage);
		vo.setSin((nowPage-1)*pageSize);
		vo.setCssn(vo.getTRC()-vo.getSin());
		vo.setBlockSize(blockSize);
		vo.setCurBlock((vo.getNowPage()-1)/vo.getBlockSize());
		vo.setLastBlock((vo.getTRC()-1)/vo.getBlockSize());
	
		return vo;
	}

	@Override
	public PageVO pageProcessorWithCategory(String tableName, int nowPage, int pageSize, int blockSize, int category) {
		PageVO vo = new PageVO();
		vo.setNowPage(nowPage);
		vo.setPageSize(pageSize);
		vo.setTRC(pageDAO.getTRCwithCategory(tableName,category));
		int totalPage =(vo.getTRC()%pageSize)==0?(vo.getTRC()/pageSize) : (vo.getTRC()/pageSize)+1;
		vo.setTotalPage(totalPage);
		vo.setSin((nowPage-1)*pageSize);
		vo.setCssn(vo.getTRC()-vo.getSin());
		vo.setBlockSize(blockSize);
		vo.setCurBlock((vo.getNowPage()-1)/vo.getBlockSize());
		vo.setLastBlock((vo.getTRC()-1)/vo.getBlockSize());
		
		return vo;
	}

	@Override
	public PageVO pageProcessorBoardSeach(String searchStr, String searchOption, int nowPage, int pageSize, int blockSize,int category) {
		PageVO vo = new PageVO();
		vo.setNowPage(nowPage);
		vo.setPageSize(pageSize);
		vo.setTRC(pageDAO.getTRCbyBoardSearch(searchOption,searchStr,category));
		int totalPage =(vo.getTRC()%pageSize)==0?(vo.getTRC()/pageSize) : (vo.getTRC()/pageSize)+1;
		vo.setTotalPage(totalPage);
		vo.setSin((nowPage-1)*pageSize);
		vo.setCssn(vo.getTRC()-vo.getSin());
		vo.setBlockSize(blockSize);
		vo.setCurBlock((vo.getNowPage()-1)/vo.getBlockSize());
		vo.setLastBlock((vo.getTRC()-1)/vo.getBlockSize());
		
		return vo;
	}

	@Override
	public PageVO pageProcessorByBoa_idx(String tableName, int pageSize, int nowPage, int blockSize, int boa_idx) {
		PageVO vo = new PageVO();
		vo.setNowPage(nowPage);
		vo.setPageSize(pageSize);
		vo.setTRC(pageDAO.getTRCbyBoa_idx(tableName,boa_idx));
		int totalPage =(vo.getTRC()%pageSize)==0?(vo.getTRC()/pageSize) : (vo.getTRC()/pageSize)+1;
		vo.setTotalPage(totalPage);
		vo.setSin((nowPage-1)*pageSize);
		vo.setCssn(vo.getTRC()-vo.getSin());
		vo.setBlockSize(blockSize);
		vo.setCurBlock((vo.getNowPage()-1)/vo.getBlockSize());
		vo.setLastBlock((vo.getTRC()-1)/vo.getBlockSize());
		
		return vo;
	}
	
	
}
