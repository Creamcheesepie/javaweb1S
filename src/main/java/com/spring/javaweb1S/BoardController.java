package com.spring.javaweb1S;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
	
}
