package com.spring.javaweb1S;

import java.util.List;

import javax.mail.Session;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb1S.common.JavaProvide;
import com.spring.javaweb1S.pagination.PageProcess;
import com.spring.javaweb1S.service.GetherService;
import com.spring.javaweb1S.vo.GetherMemberVO;
import com.spring.javaweb1S.vo.GetherReviewVO;
import com.spring.javaweb1S.vo.GetherVO;
import com.spring.javaweb1S.vo.PageVO;

@Controller
@RequestMapping("/gether")
public class GetherController {
	@Autowired
	GetherService getherService;
	
	@Autowired
	PageProcess pageProcess;
	
	@RequestMapping(value = "/home", method = RequestMethod.GET)
	public String getherHomeGet(Model model,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="5",required=false)int pageSize
			) {
		int availableGether = getherService.getAvailableGetherCount();
		int blockSize = 5;
		
		PageVO pageVO = pageProcess.pageProcessor("gether2_review", pageSize, nowPage, blockSize);
		List<GetherReviewVO> grVOS = getherService.getGetherReviewList(pageVO);
		
		model.addAttribute("grVOS", grVOS);
		model.addAttribute("availableGether", availableGether);
		return "gether/getherHome";
	}
	
	@RequestMapping(value = "/afterList", method = RequestMethod.GET)
	public String getherAfterListGet(Model model,HttpSession session,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="5",required=false)int pageSize
			) {
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		int blockSize = 5;
		PageVO pageVO = pageProcess.afterGetherProcess(nowPage, pageSize, blockSize);
		List<GetherVO> getherVOS =  getherService.getAfterGetherList(pageVO,m_idx);
		
		System.out.println(getherVOS);
		model.addAttribute("getherVOS", getherVOS);
		return "gether/afterGetherList";
	}
	
	@RequestMapping(value = "/pastList", method = RequestMethod.GET)
	public String getherPastListGet(Model model,HttpSession session,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="5",required=false)int pageSize
			) {
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		int blockSize = 5;
		PageVO pageVO = pageProcess.pastGetherProcess(nowPage, pageSize, blockSize);
		List<GetherVO> getherVOS =  getherService.getPastGetherList(pageVO,m_idx);
		System.out.println(pageVO);
		System.out.println(getherVOS);
		model.addAttribute("getherVOS", getherVOS);
		return "gether/pastGetherList";
	}
	
	@RequestMapping(value = "/reviewList",method = RequestMethod.GET)
	public String getherReviewGet(Model model,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="5",required=false)int pageSize
			) {
		int blockSize = 5;
		PageVO pageVO = pageProcess.pageProcessor("gether2_review", pageSize, nowPage, blockSize);
		List<GetherReviewVO> grVOS = getherService.getGetherReviewList(pageVO);
		
		model.addAttribute("grVOS", grVOS);
		return "gether/getherReviewList";
	}
	
	@RequestMapping(value = "/makeGether",method = RequestMethod.GET)
	public String getherMakeGet() {
		return "gether/getherMake";
	}
	
	@RequestMapping(value = "/getherInsert", method = RequestMethod.POST)
	public String getherInsertPost(HttpSession session,MultipartFile fName,
			GetherVO getherVO
			) {
		JavaProvide provide = new JavaProvide();
		
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		getherVO.setM_idx(m_idx);
		 
		String realPath = session.getServletContext().getRealPath("/resources/data/");
		provide.imageCheckCopyGether(getherVO.getContent(), realPath , "getherTemp/");
		getherVO.setContent(getherVO.getContent().replace("/getherTemp/","/gether/"));
		
		realPath = session.getServletContext().getRealPath("/resources/data/gpxFiles/");
		getherVO.setGpxFile(provide.fileUpload(fName, realPath));
		
		getherService.setGetherInsert(getherVO);
		
		System.out.println(getherVO);
		return "redirect:/gether/afterList";
	}
	
	@RequestMapping(value = "/getherDetail/{get_idx}", method = RequestMethod.GET)
	public String getherDetailGet(Model model,HttpSession session,
			@PathVariable("get_idx") int get_idx
			) {
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		GetherVO getherVO = getherService.getGetherDetail(get_idx);
		List<GetherVO> joinListVOS = getherService.getGetherJoinList(get_idx);
		int joinChecker = getherService.getM_idxJoinCheck(get_idx,m_idx);
		
		model.addAttribute("joinChecker", joinChecker);
		model.addAttribute("joinListVOS", joinListVOS);
		model.addAttribute("getherVO", getherVO);
		return "gether/getherDetail";
	}
	
	@ResponseBody
	@RequestMapping(value = "/joinGether", method = RequestMethod.POST)
	public int joinGetherPost(HttpSession session,
			@RequestParam(name="get_idx",defaultValue="0",required=false)int get_idx,
			@RequestParam(name="joinSw",defaultValue="0",required=false)int joinSw
			) {
		int res = 0 ;
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		
		GetherVO getherVO = getherService.getGetherDetail(get_idx);
		if(getherVO.getNowMember() == getherVO.getTotalMember()) return 0;
		
		if(joinSw != 1) {
			boolean banCheck = getherService.banUserCheck(m_idx,get_idx);
			if(banCheck) {
				res = 2;
			}
			else {
				getherService.setGetherJoin(get_idx,m_idx);
				res=1;
			}
		}
		else {
			getherService.setGetherJoin(get_idx,m_idx);
			res=1;
		}
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value = "/cancleGether", method = RequestMethod.POST)
	public void cancleGetherPost(HttpSession session,
			@RequestParam(name="get_idx",defaultValue="0",required=false)int get_idx
			) {
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		getherService.setDeleteGether2_member(get_idx,m_idx);
	}
	
	@RequestMapping(value = "/getherSaveQR",method = RequestMethod.POST)
	public String getherSaveQRPost(HttpServletRequest request,Model model,
			@RequestParam(name="link",defaultValue="",required=false)String link
			) {
		String  realPath = request.getSession().getServletContext().getRealPath("/resources/data/QR/");
		String QRName = getherService.setQRCode(link,realPath);
		System.out.println(QRName);
		model.addAttribute("link", link);
		model.addAttribute("QRCode", QRName);
		return "gether/saveQROut";
	}
	
	@RequestMapping(value = "/getherClearSave/{get_idx}",method = RequestMethod.GET)
	public String getherClearSaveGet(HttpSession session,Model model,
			@PathVariable("get_idx")int get_idx
			) {
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		GetherVO getherVO = getherService.getGetherDetail(get_idx);
		
		model.addAttribute("m_idx", m_idx);
		model.addAttribute("getherVO", getherVO);
		if(m_idx == 0)return "redirect:/member/login?from=getherClear&extra="+get_idx;
		return "gether/getherClearSave";
	}
	
	@RequestMapping(value = "/getherClearSave",method = RequestMethod.POST)
	public String getherClearSavePost(HttpSession session,
			GetherMemberVO getherMemberVO
			) {
		getherMemberVO.setM_idx((int)session.getAttribute("sM_idx"));
		
		getherService.setGetherClearUpdate(getherMemberVO);
		System.out.println(getherMemberVO);
		return "redirect:/gether/myclearList";
	}
	
	@RequestMapping(value = "/myclearList", method = RequestMethod.GET)
	public String getherMyClearList(HttpSession session,Model model) {
		int m_idx = (int)session.getAttribute("sM_idx");
		List<GetherVO> getherVOS = getherService.getMyClearList(m_idx);
		System.out.println(getherVOS);
		model.addAttribute("getherVOS", getherVOS);
		return "gether/myClearList";
	}
	
	@RequestMapping(value = "/getherClearList/{get_idx}",method = RequestMethod.GET)
	public String getherClearListGet(Model model,HttpSession Session,
			@PathVariable("get_idx") int get_idx
			) {
		List<GetherMemberVO> getherMemberVOS = getherService.getGetherClearList(get_idx);
		
		
		model.addAttribute("getherMemberVOS", getherMemberVOS);
		return "gether/getherClearList";
	}
	
	@ResponseBody
	@RequestMapping(value = "getherClearCheck", method = RequestMethod.POST)
	public void getherClearCheckPost(
			@RequestParam(name="get_idx",defaultValue="0",required=false) int get_idx,
			@RequestParam(name="m_idx",defaultValue="0",required=false)	int m_idx
			) {
		getherService.setGetherClearCheck(get_idx,m_idx);
	}
	
	@RequestMapping(value = "/reviewWrite", method = RequestMethod.POST)
	public String getherReviewWritePost(Model model, HttpSession session,
			@RequestParam(name="rv_get_idx",defaultValue="0",required=false) int get_idx
			){
		int m_idx = (int)session.getAttribute("sM_idx");
		GetherVO getherVO = getherService.getGetherDetail(get_idx);
		GetherMemberVO gmVO = getherService.getGetherMemberDetail(get_idx,m_idx);
		System.out.println(gmVO);
		model.addAttribute("getherVO", getherVO);
		model.addAttribute("gmVO", gmVO);
		return "gether/getherReviewWrite";
	}
	
	@RequestMapping(value = "/getherReviewInput",method = RequestMethod.POST)
	public String getherReviewInputPost(HttpSession session,MultipartFile fName,
			GetherReviewVO getherReviewVO) {
		JavaProvide provide = new JavaProvide();
		
		int m_idx = session.getAttribute("sM_idx")==null?0:(int)session.getAttribute("sM_idx");
		getherReviewVO.setM_idx(m_idx);
		 
		String realPath = session.getServletContext().getRealPath("/resources/data/");
		provide.imageCheckCopyGether(getherReviewVO.getContent(), realPath , "getherTemp/");
		getherReviewVO.setContent(getherReviewVO.getContent().replace("/getherTemp/","/gether/"));
		
		realPath = session.getServletContext().getRealPath("/resources/data/reviewMain/");
		getherReviewVO.setMainImage(provide.fileUpload(fName, realPath));
		
		getherService.setGetherReviewInsert(getherReviewVO);
		getherService.setGetherClearCheck(getherReviewVO.getGet_idx(), m_idx);
		System.out.println(getherReviewVO);
		
		return "redirect:/gether/reviewList";
	}
	
	@RequestMapping(value = "/reviewDetail/{ger_idx}",method = RequestMethod.GET)
	public String getherReviewDetailGet(Model model,
			@PathVariable("ger_idx") int ger_idx
			) {
		GetherReviewVO grVO = getherService.getGetherReviewDetail(ger_idx);
		
		model.addAttribute("grVO", grVO);
		return "gether/getherReviewDetail";
	}
}
