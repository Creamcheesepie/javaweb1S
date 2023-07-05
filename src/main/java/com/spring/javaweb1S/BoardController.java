package com.spring.javaweb1S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaweb1S.common.JavaProvide;
import com.spring.javaweb1S.pagination.PageProcess;
import com.spring.javaweb1S.service.BoardService;
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.PageVO;

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
	
	@RequestMapping(value = "/newsRead/{boa_idx}/{category}",method=RequestMethod.GET)
	public String boardNewsReadGet(Model model,
			@PathVariable("boa_idx") int boa_idx,
			@PathVariable("category") String strCategory
			) {
		JavaProvide provide = new JavaProvide();
		int category = Integer.parseInt(strCategory);
		String categoryName = boardService.getCategoryNameByCategory(category);
		
		BoardVO vo = boardService.getboardRead(boa_idx);
		vo.setStrLevel(provide.levelToString(vo.getLevel()));
		
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("category", category);
		model.addAttribute("newsRead_vo", vo);
		return "board/newsBoardRead";
	}
	
	@RequestMapping(value = "/newsSearch/${category}", method=RequestMethod.POST)
	public String boardNewsSearchPost(Model model,
			@PathVariable("category") int category,
			@RequestParam(name="searchStr",defaultValue="",required=false)String SearchStr,
			@RequestParam(name="searchOption",defaultValue="",required=false) String SearchOption
			) {
		//검색기능 구현하기
		return "board/newsBoard";
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
	
	
}
