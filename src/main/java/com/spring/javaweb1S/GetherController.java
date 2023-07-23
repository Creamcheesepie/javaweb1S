package com.spring.javaweb1S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb1S.common.JavaProvide;
import com.spring.javaweb1S.pagination.PageProcess;
import com.spring.javaweb1S.service.GetherService;
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
	public String getherHomeGet(Model model) {
		int availableGether = getherService.getAvailableGetherCount();
		
		model.addAttribute("availableGether", availableGether);
		return "gether/getherHome";
	}
	
	@RequestMapping(value = "/afterList", method = RequestMethod.GET)
	public String getherAfterListGet(Model model,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="5",required=false)int pageSize
			) {
		int blockSize = 5;
		PageVO pageVO = pageProcess.afterGetherProcess(nowPage, pageSize, blockSize);
		List<GetherVO> getherVOS =  getherService.getAfterGetherList(pageVO);
		
		model.addAttribute("getherVOS", getherVOS);
		return "gether/afterGetherList";
	}
	
	@RequestMapping(value = "/reviewList",method = RequestMethod.GET)
	public String getherReviewGet() {
		
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
}
