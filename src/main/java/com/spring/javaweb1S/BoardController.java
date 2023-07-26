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
			@RequestParam(name="pageSize",defaultValue="15",required=false)int pageSize
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
	
	//사용자 전체가 사용 가능한 일반 게시판
	@RequestMapping(value = "/list/{category}",method=RequestMethod.GET)
	public String boardListGet(Model model,HttpSession session,
			@PathVariable("category") String strCategory,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="11",required=false)int pageSize
			) {
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		//카테고리 처리
		int category = Integer.parseInt(strCategory);
		String categoryName = boardService.getCategoryNameByCategory(category);
		model.addAttribute("category_Name", categoryName);
		
		int blockSize = 5;
		if(m_idx==0) {
			//페이지처리
			PageVO pageVO = page.pageProcessorWithCategory("board2",nowPage,pageSize,blockSize,category);
			model.addAttribute("pageVO", pageVO);
			//리스트 가져오기
			List<BoardVO> boardList_vos = boardService.getboardList(category,pageVO.getSin(),pageVO.getPageSize());
			model.addAttribute("boardList_vos", boardList_vos);
		}
		else {
			//차단된 사람들의 m_idx를 가공 후 저장
			String ban_idx = boardService.getbanListByM_idx(m_idx);
			//페이지처리
			PageVO pageVO = page.pageProcessorWithCategory("board2",nowPage,pageSize,blockSize,category,ban_idx);
			model.addAttribute("pageVO", pageVO);
			//리스트 가져오기
			List<BoardVO> boardList_vos = boardService.getboardList(category,pageVO.getSin(),pageVO.getPageSize(),ban_idx);
			System.out.println(ban_idx);
			model.addAttribute("boardList_vos", boardList_vos);
		}
		
		List<BoardVO> noticeVOS = boardService.getNoticeList();
		model.addAttribute("noticeVOS", noticeVOS);
		return "board/boardList";
	}
	
	//사용자 전체가 사용 가능한 일반 게시판
	@RequestMapping(value = "/listAll",method=RequestMethod.GET)
	public String boardAllListGet(Model model,HttpSession session,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="15",required=false)int pageSize
			) {
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		
		int blockSize = 5;
		if(m_idx==0) {
			//페이지처리
			PageVO pageVO = page.pageProcessor("board2",pageSize,nowPage,blockSize);
			model.addAttribute("pageVO", pageVO);
			//리스트 가져오기
			List<BoardVO> boardList_vos = boardService.getAllBoardList(pageVO.getSin(),pageVO.getPageSize());
			model.addAttribute("boardList_vos", boardList_vos);
		}
		else {
			//차단된 사람들의 m_idx를 가공 후 저장
			String ban_idx = boardService.getbanListByM_idx(m_idx);
			//페이지처리
			PageVO pageVO = page.pageProcessor("board2",nowPage,pageSize,blockSize,ban_idx);
			model.addAttribute("pageVO", pageVO);
			//리스트 가져오기
			List<BoardVO> boardList_vos = boardService.getAllboardList(pageVO.getSin(),pageVO.getPageSize(),ban_idx);
			System.out.println(ban_idx);
			model.addAttribute("boardList_vos", boardList_vos);
		}
		
		List<BoardVO> noticeVOS = boardService.getNoticeList();
		model.addAttribute("noticeVOS", noticeVOS);
		return "board/AllboardList";
	}
	
	//뉴스 게시판 작성
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

	//일반 게시판 작성 >> 인터셉터에 의해 접근권한이 달라 따로 만듬.
	@RequestMapping(value = "/write/{category}",method=RequestMethod.GET)
	public String boardwriteGet(Model model,
			@PathVariable("category") String strCategory) {
		return "redirect:/unusualapproach";
	}
	
	@RequestMapping(value = "/write/{category}",method=RequestMethod.POST)
	public String boardwritePost(Model model,
			@PathVariable("category") String strCategory,HttpSession session) {
		int category = Integer.parseInt(strCategory);
		String categoryName = boardService.getCategoryNameByCategory(category);
		
		int m_idx = (int)session.getAttribute("sM_idx");
		
		boolean abuseSw = boardService.getBoardBanInfo(m_idx);
		if(abuseSw) return "redirect:/boardAbuseUser/2"; 
		abuseSw = boardService.getboardWriteAbused(m_idx);
		if(abuseSw) return "redirect:/boardAbuseUser/2";
		
		model.addAttribute("category_Name", categoryName);
		return "board/boardWrite";
	}
	
	
	
	//뉴스 게시판 개별글 조회
	@RequestMapping(value = "/newsRead/{boa_idx}/{category}",method=RequestMethod.GET)
	public String boardNewsReadGet(Model model,HttpSession session,
			@PathVariable("boa_idx") int boa_idx,
			@PathVariable("category") String strCategory,
			@RequestParam(name="pageSize",defaultValue="5",required=false)int pageSize,
			@RequestParam(name="repNowPage", defaultValue="1",required=false)int repNowPage,
			@RequestParam(name="repPageSize",defaultValue="20",required=false)int repPageSize
			) {
		JavaProvide provide = new JavaProvide();
		int category = Integer.parseInt(strCategory);
		String categoryName = boardService.getCategoryNameByCategory(category);
		
		//게시글 정보 가져오기
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
		
		//추천여부확인
		int user_m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		String RecommendCheck = boardService.getBoardReccomendCheck(boa_idx,user_m_idx); 
		System.out.println(RecommendCheck);
		//null값 여부 확인 위해서는 String이 어쩔 수 없이 요구됨...>>다른 방법이 없는지 고민하기
    
		//댓글 목록 가져오기
		int blockSize=5;
		if(user_m_idx==0) {
			PageVO repPageVO = page.pageProcessorByBoa_idx("board2_reply", repPageSize, repNowPage, blockSize,boa_idx);
			List<ReplyVO> replyVOS = boardService.getboardReplyList(boa_idx,repPageVO); 
			model.addAttribute("repPageVO", repPageVO);
			model.addAttribute("replyVOS", replyVOS);
		}
		else {
			String ban_idx = boardService.getbanListByM_idx(user_m_idx);
			PageVO repPageVO = page.pageProcessorByBoa_idx("board2_reply", repPageSize, repNowPage, blockSize,boa_idx,ban_idx);
			List<ReplyVO> replyVOS = boardService.getboardReplyList(boa_idx,repPageVO,ban_idx); 
			model.addAttribute("repPageVO", repPageVO);
			model.addAttribute("replyVOS", replyVOS);
		}
		
		//이전글 다음글 처리
		List<BoardVO> prevNextContentVOS = boardService.getPrevNextContentbyBoa_idx(vo);
		
		//현재 페이지 가져오기
		int nowPage = page.pageFinderByBoa_idxWithCategory("board2", pageSize, boa_idx, "boa_idx", category);
		System.out.println(nowPage);
		
		System.out.println(prevNextContentVOS);
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("rec_check", RecommendCheck);
		model.addAttribute("prevNextContentVOS", prevNextContentVOS);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("category", category);
		model.addAttribute("newsRead_vo", vo);
		return "board/newsBoardRead";
	}
	
	
	//일반게시판 게시판 개별글 조회
	@RequestMapping(value = "/read/{boa_idx}/{category}",method=RequestMethod.GET)
	public String boardReadGet(Model model,HttpSession session,
			@PathVariable("boa_idx") int boa_idx,
			@PathVariable("category") String strCategory,
			@RequestParam(name="pageSize",defaultValue="5",required=false)int pageSize,
			@RequestParam(name="repNowPage", defaultValue="1",required=false)int repNowPage,
			@RequestParam(name="repPageSize",defaultValue="20",required=false)int repPageSize
			) {
		JavaProvide provide = new JavaProvide();
		int category = Integer.parseInt(strCategory);
		String categoryName = boardService.getCategoryNameByCategory(category);
		
		//게시글 정보 가져오기
		BoardVO vo = boardService.getboardRead(boa_idx);
		System.out.println(vo);
		System.out.println("test");
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
		
		//추천여부확인
		int user_m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		String RecommendCheck = boardService.getBoardReccomendCheck(boa_idx,user_m_idx); 
		System.out.println(RecommendCheck);
		//null값 여부 확인 위해서는 String이 어쩔 수 없이 요구됨...>>다른 방법이 없는지 고민하기
		
		//댓글 목록 가져오기, 이전글 다음글 처리
		String ban_idx = boardService.getbanListByM_idx(user_m_idx);
		int blockSize=5;
		if(user_m_idx==0) {
			PageVO repPageVO = page.pageProcessorByBoa_idx("board2_reply", repPageSize, repNowPage, blockSize,boa_idx);
			List<ReplyVO> replyVOS = boardService.getboardReplyList(boa_idx,repPageVO); 
			List<BoardVO> prevNextContentVOS = boardService.getPrevNextContentbyBoa_idx(vo);
			model.addAttribute("repPageVO", repPageVO);
			model.addAttribute("replyVOS", replyVOS);
			model.addAttribute("prevNextContentVOS", prevNextContentVOS);
		}
		else {
			PageVO repPageVO = page.pageProcessorByBoa_idx("board2_reply", repPageSize, repNowPage, blockSize,boa_idx,ban_idx);
			List<ReplyVO> replyVOS = boardService.getboardReplyList(boa_idx,repPageVO,ban_idx); 
			List<BoardVO> prevNextContentVOS = boardService.getPrevNextContentbyBoa_idx(vo,ban_idx);
			model.addAttribute("repPageVO", repPageVO);
			model.addAttribute("replyVOS", replyVOS);
			model.addAttribute("prevNextContentVOS", prevNextContentVOS);
		}
		
		//현재 페이지 가져오기
		int nowPage = page.pageFinderByBoa_idxWithCategory("board2", pageSize, boa_idx, "boa_idx", category);
		System.out.println(nowPage);
		
		model.addAttribute("nowPage", nowPage);
		model.addAttribute("rec_check", RecommendCheck);
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("category", category);
		model.addAttribute("boardRead_vo", vo);
		return "board/boardRead";
	}
	
	//뉴스 검색하기
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
	
	//게시판 검색하기
	@RequestMapping(value = "/list/{category}/search", method=RequestMethod.GET)
	public String boardSearchGet(Model model,
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
		model.addAttribute("boardList_vos", search_vos);
		return "board/boardSearch";
	}
	
	//게시글 작성
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
		
		if(category>2) {
			return "redirect:/board/list/"+strCategory;
		}
		else {
			return "redirect:/board/news/"+strCategory;
		}
	}
	
	//추천하기
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
	
	//댓글달기
	@ResponseBody
	@RequestMapping(value = "/replyInput", method = RequestMethod.POST)
	public int boardReplyInputPost(ReplyVO vo) {
		int res=0;
		boolean banSw =boardService.getReplyBanInfo(vo.getM_idx());
		if(!banSw) res = boardService.setReplyInput(vo);
		else res = 99;
		return res;
	}
	
	//대댓글 달기
	@ResponseBody
	@RequestMapping(value = "/answerReply", method = RequestMethod.POST)
	public int boardAnswerReplyInputPost(
			@RequestParam(name="content",defaultValue="",required=false)String content,
			@RequestParam(name="boa_idx",defaultValue="0",required=false)int boa_idx,
			@RequestParam(name="rep_group",defaultValue="0",required=false)int rep_group,
			@RequestParam(name="m_idx",defaultValue="",required=false)int m_idx,
			@RequestParam(name="t_nickName",defaultValue="",required=false)String t_nickName,
			@RequestParam(name="rep_level",defaultValue="",required=false)int rep_level
			) {
		ReplyVO vo = new ReplyVO();
		vo.setBoa_idx(boa_idx);
		vo.setRep_group(rep_group);
		vo.setM_idx(m_idx);
		vo.setRep_level(rep_level+1);
		vo.setContent("<p>@"+t_nickName+"</p>"+content);
		int res = 0;
		
		boolean banSw =boardService.getReplyBanInfo(vo.getM_idx());
		if(!banSw) boardService.setAnswerReplyInput(vo);
		else res = 99;
		return res;
	};
	
	//뉴스글 수정처리 폼 출력
	@RequestMapping(value = "/newsUpdateForm/{boa_idx}/{category}",method= RequestMethod.POST)
	public String newsUpdateFormPost(Model model, HttpSession session,
			@PathVariable("boa_idx") int boa_idx,
			@PathVariable("category") int category
			) {
		JavaProvide provide = new JavaProvide();
		BoardVO updateForm_vo = boardService.getboardUpdateForm(boa_idx);
		String categoryName = boardService.getCategoryNameByCategory(category);
		
		String realPath=session.getServletContext().getRealPath("/resources/data/");
		provide.contentImageDelete(updateForm_vo.getContent(), realPath,"board/" );
		updateForm_vo.setContent(updateForm_vo.getContent().replace("/board/","/boardTemp/"));
		
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("category",category);
		model.addAttribute("updateForm_vo", updateForm_vo);
		return "board/newsBoardUpdate";
	}
	
	//주소창을 통한 직접입력 접근 차단 위한 메소드
	@RequestMapping(value = "/newsUpdateForm/{boa_idx}/{category}",method= RequestMethod.GET)
	public String newsUpdateFormPost() {
		return "redirect:/unusualapproach";
	}
	
	
	//본문글 수정처리 폼 출력
	@RequestMapping(value = "/updateForm/{boa_idx}/{category}",method= RequestMethod.POST)
	public String boardUpdateFormPost(Model model, HttpSession session,
			@PathVariable("boa_idx") int boa_idx,
			@PathVariable("category") int category
			) {
		JavaProvide provide = new JavaProvide();
		BoardVO updateForm_vo = boardService.getboardUpdateForm(boa_idx);
		String categoryName = boardService.getCategoryNameByCategory(category);
		
		String realPath=session.getServletContext().getRealPath("/resources/data/");
		provide.contentImageDelete(updateForm_vo.getContent(), realPath,"board/" );
		updateForm_vo.setContent(updateForm_vo.getContent().replace("/board/","/boardTemp/"));
		
		model.addAttribute("categoryName", categoryName);
		model.addAttribute("category",category);
		model.addAttribute("updateForm_vo", updateForm_vo);
		return "board/boardUpdate";
	}
	
	//주소창을 통한 직접입력 접근 차단 위한 메소드
	@RequestMapping(value = "/updateForm/{boa_idx}/{category}",method= RequestMethod.GET)
	public String boardUpdateFormPost() {
		return "redirect:/unusualapproach";
	}
	
	//수정한 글을 DB에 반영하기
	@RequestMapping(value = "/newsUpateSet/{boa_idx}/{category}")
	public String newsUpdateSet(HttpSession session,
			@PathVariable("boa_idx") int boa_idx,
			@PathVariable("category") int category,
			@RequestParam(name="title",defaultValue="",required=false) String title,
			@RequestParam(name="content",defaultValue="",required=false) String content
			) {
		int m_idx = (int)session.getAttribute("sM_idx");
		
		JavaProvide provide = new JavaProvide();
		String realPath=session.getServletContext().getRealPath("/resources/data/");
		//임시폴더에 저장된 이미지를 본 폴더에 저장
		provide.imageCheckCopy(content,realPath , "boardTemp/");
		//content 안의 경로를 본 폴더로 수정
		content = content.replace("/boardTemp/","/board/");
		
		BoardVO vo = new BoardVO();
		vo.setBoa_idx(boa_idx);
		vo.setM_idx(m_idx);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setCategory(category);
		//내용을 DB에 저장
		boardService.setBoardUpdateInput(vo);
		
		return "redirect:/board/newsRead/"+boa_idx+"/"+category+"/";
	}
	
	//수정한 글을 DB에 반영하기
	@RequestMapping(value = "/upateSet/{boa_idx}/{category}")
	public String boardUpdateSet(HttpSession session,
			@PathVariable("boa_idx") int boa_idx,
			@PathVariable("category") int category,
			@RequestParam(name="title",defaultValue="",required=false) String title,
			@RequestParam(name="content",defaultValue="",required=false) String content
			) {
		int m_idx = (int)session.getAttribute("sM_idx");
		
		JavaProvide provide = new JavaProvide();
		String realPath=session.getServletContext().getRealPath("/resources/data/");
		//임시폴더에 저장된 이미지를 본 폴더에 저장
		provide.imageCheckCopy(content,realPath , "boardTemp/");
		//content 안의 경로를 본 폴더로 수정
		content = content.replace("/boardTemp/","/board/");
		
		BoardVO vo = new BoardVO();
		vo.setBoa_idx(boa_idx);
		vo.setM_idx(m_idx);
		vo.setTitle(title);
		vo.setContent(content);
		vo.setCategory(category);
		//내용을 DB에 저장
		boardService.setBoardUpdateInput(vo);
		
		return "redirect:/board/read/"+boa_idx+"/"+category+"/";
	}
	
	@ResponseBody
	@RequestMapping(value = "/deleteForm/{boa_idx}/{category}",method = RequestMethod.POST)
	public String newsDeleteForm(HttpSession session,
			@PathVariable("boa_idx") int boa_idx,
			@PathVariable("category") int category,
			@RequestParam(name="delM_idx",defaultValue="0",required=false)int m_idx
			) {
		String res="";
		int sM_idx = (int)session.getAttribute("sM_idx");//세션에 저장된 정보와 글의 원 작성자가 맞는지 비교
		
		if(m_idx!=sM_idx) res="2";
		else {
			boardService.setBoardDeleteUpdate(boa_idx);
			res="1";
		}
		return res;
	}
	
	//주소창을 통한 직접입력 접근 차단 위한 메소드
	@RequestMapping(value = "/deleteForm/{boa_idx}/{category}",method= RequestMethod.GET)
	public String newsDeleteFormGet() {
		return "redirect:/unusualapproach";
	}
	
	
}
