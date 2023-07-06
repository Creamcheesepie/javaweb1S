package com.spring.javaweb1S;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb1S.common.JavaProvide;
import com.spring.javaweb1S.pagination.PageProcess;
import com.spring.javaweb1S.service.BoardService;
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.ReplyVO;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess page;

	
	//운영자가 쓸 수 있는 뉴스 게시판
	@RequestMapping(value = "/news/{category}",method=RequestMethod.GET)
	public String boardNewsGet(Model model,
			@PathVariable("category") String strCategory,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="20",required=false)int pageSize
			) {
		int category = Integer.parseInt(strCategory);
		int blockSize = 5;
		PageVO pageVO = page.pageProcessorWithCategory("board2",nowPage,pageSize,blockSize,category);
		
		List<BoardVO> newsList_vos = boardService.getboardList(category,pageVO.getSin(),pageVO.getPageSize());
		
		String categoryName = boardService.getCategoryNameByCategory(category);
		
		model.addAttribute("newsList_vos", newsList_vos);
		model.addAttribute("category_Name", categoryName);
		model.addAttribute("pageVO", pageVO);
		return "board/newsBoard";
	}
	
	
	@RequestMapping(value = "/newsWrite/{category}",method=RequestMethod.GET)
	public String boardNewsWriteGet(Model model,
			@PathVariable("category") String strCategory) {
		return "redirect:/unusualapproach";
	}
	
	@RequestMapping(value = "/newsWrite/{category}",method=RequestMethod.POST)
	public String boardNewsWritePost(Model model,
			@PathVariable("category") String strCategory,HttpSession session) {
		
		int category = Integer.parseInt(strCategory);
		String categoryName = boardService.getCategoryNameByCategory(category);
		
		model.addAttribute("category_Name", categoryName);
		return "board/newsBoardWrite";
	}
	
	//뉴스 게시판 개별글 조회
	@RequestMapping(value = "/newsRead/{boa_idx}/{category}",method=RequestMethod.GET)
	public String boardNewsReadGet(Model model,HttpSession session,
			@PathVariable("boa_idx") int boa_idx,
			@PathVariable("category") String strCategory,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="20",required=false)int pageSize,
			@RequestParam(name="repNowPage", defaultValue="1",required=false)int repNowPage,
			@RequestParam(name="repPageSize",defaultValue="20",required=false)int repPageSize
			) {
		JavaProvide provide = new JavaProvide();
		int category = Integer.parseInt(strCategory);
		String categoryName = boardService.getCategoryNameByCategory(category);
		
		BoardVO vo = boardService.getboardRead(boa_idx);
		vo.setStrLevel(provide.levelToString(vo.getLevel()));
		
		//조회수 처리
		ArrayList<String> contentIdx = (ArrayList<String>)session.getAttribute("sContentIdx");
		if(contentIdx == null) {
			contentIdx = new ArrayList<String>();
		}
		String tempContentIdx = "board"+boa_idx;
		if(!contentIdx.contains(tempContentIdx)) {
			contentIdx.add(tempContentIdx);
			boardService.setViewCntUp(vo.getBoa_idx());
		}
		session.setAttribute("sContentIdx", contentIdx);
		
		int blockSize=5;
		PageVO repPageVO = page.pageProcessorByBoa_idx("board2_reply", repPageSize, repNowPage, blockSize,boa_idx);		
		
		//댓글 목록 가져오기
		List<ReplyVO> replyVOS = boardService.getboardReplyList(boa_idx,repPageVO); 
		
		
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("category", category);
		model.addAttribute("replyVOS", replyVOS);
		model.addAttribute("newsRead_vo", vo);
		return "board/newsBoardRead";
	}
	
	@RequestMapping(value = "/news/{category}/search", method=RequestMethod.GET)
	public String boardNewsSearchGet(Model model,
			@PathVariable("category") int category,
			@RequestParam(name="searchStr",defaultValue="",required=false)String searchStr,
			@RequestParam(name="searchOption",defaultValue="",required=false) String searchOption,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="20",required=false)int pageSize
			) {
		int blockSize = 5; 
		PageVO pageVO = page.pageProcessorBoardSeach(searchStr,searchOption,nowPage, pageSize, blockSize, category);
		String categoryName = boardService.getCategoryNameByCategory(category);
		List<BoardVO> search_vos = boardService.getCategorySearchList(searchStr,searchOption,category,pageVO.getSin(),pageVO.getPageSize());
		
		JavaProvide provide  = new JavaProvide();
		searchOption = provide.searchOptionToKorean(searchOption);
		
		model.addAttribute("searchOption",searchOption);
		model.addAttribute("searchStr", searchStr);
		model.addAttribute("category_Name", categoryName);
		model.addAttribute("pageVO",pageVO);
		model.addAttribute("newsList_vos", search_vos);
		return "board/newsBoardSearch";
	}
	
	
	@RequestMapping(value = "/list/{category}",method=RequestMethod.GET)
	public String boardListGet(Model model,
			@PathVariable("category") String strCategory
			) {
		int category = Integer.parseInt(strCategory);
		//게시판 카테고리 처리 어떻게 할건지?
		String categoryName = boardService.getCategoryNameByCategory(category);
		model.addAttribute("category_Name", categoryName);
		return "board/boardList";
	}
	
	@RequestMapping(value = "/writeInput/{category}",method = RequestMethod.POST)
	public String boardWriteInputPost(HttpSession session,
			@PathVariable("category") String strCategory,
			@RequestParam(name="title",defaultValue="",required=false) String title,
			@RequestParam(name="content",defaultValue="",required=false) String content
			) {
		int category = Integer.parseInt(strCategory);
		int m_idx = (int)session.getAttribute("sM_idx");
		
		JavaProvide provide = new JavaProvide();
		String realPath=session.getServletContext().getRealPath("/resources/data/");
		//임시폴더에 저장된 이미지를 본 폴더에 저장
		provide.imageCheckCopy(content,realPath , "boardTemp/");
		//content 안의 경로를 본 폴더로 수정
		content = content.replace("/boardTemp/","/board/");
		
		BoardVO vo = new BoardVO();
		vo.setM_idx(m_idx);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setCategory(category);
		//내용을 DB에 저장
		boardService.setBoardWriteInput(vo);
		
		return "redirect:/board/news/"+strCategory;
	}
	
	@ResponseBody
	@RequestMapping(value = "/recommendCheck", method = RequestMethod.POST)
	public int boardRecommendCheckPost(HttpSession session,
			@RequestParam(name="boa_idx",defaultValue="",required=false)int boa_idx
			) {
		int res =0;
		int m_idx = (int)session.getAttribute("sM_idx");
		res = boardService.setBoardUpdateCheck(boa_idx,m_idx);
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/replyInput", method = RequestMethod.POST)
	public int boardReplyInputPost(ReplyVO vo) {
		int res=0;
		
		res = boardService.setReplyInput(vo);
		
		return res;
	}
	
	
}
