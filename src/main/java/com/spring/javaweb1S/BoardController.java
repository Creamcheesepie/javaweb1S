package com.spring.javaweb1S;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import com.spring.javaweb1S.pagination.PageProcess;
import com.spring.javaweb1S.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {
	@Autowired
	BoardService boardService;
	
	@Autowired
	PageProcess page;
	
	
	@RequestMapping(value = "/list/{category}",method=RequestMethod.GET)
	public String boardListGet(Model model,
			@PathVariable String category,
			@RequestParam(name="nowPage",defaultValue="",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="",required=false)int pageSize
			) {
		//게시판 카테고리 처리 어떻게 할건지?
		
		return "board/boardList";
	}
	
}
