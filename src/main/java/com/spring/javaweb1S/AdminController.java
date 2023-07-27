package com.spring.javaweb1S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.spring.javaweb1S.common.JavaProvide;
import com.spring.javaweb1S.pagination.PageProcess;
import com.spring.javaweb1S.service.AdminService;
import com.spring.javaweb1S.vo.AskVO;
import com.spring.javaweb1S.vo.BoardVO;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.PointVO;
import com.spring.javaweb1S.vo.ReportCategoryVO;
import com.spring.javaweb1S.vo.ReportVO;
import com.spring.javaweb1S.vo.RuleSetterVO;

@Controller
@RequestMapping("/admin")
public class AdminController {
	@Autowired
	AdminService adminService;
	
	@Autowired
	PageProcess pageProcess;
	
	
	@RequestMapping(value = "/home",method = RequestMethod.POST)
	public String adminHomePost(HttpSession session) {
		int level =session.getAttribute("sLevel")==null?99:(int)session.getAttribute("sLevel");
		if(level<2) {
			return "admin/adminHome";
		}
		else return "redirect:/unusualapproach";
	}
	
	@RequestMapping(value = "/home",method = RequestMethod.GET)
	public String adminHomeGet() {
		 return "redirect:/unusualapproach";
	}
	
	@RequestMapping(value = "/ruleUpdateForm",method=RequestMethod.POST)
	public String adminRuleUpdateFormPost(HttpSession session, Model model) {
		int level =session.getAttribute("sLevel")==null?99:(int)session.getAttribute("sLevel");
		if(level<2) {
			List<PointVO> point_vos= adminService.getPointList();
			List<CategoryVO> category_vos = adminService.getcategoryList();
			int[] BoardRuleInfo = adminService.getBoardRuleInfo(2);
			int[] replyRuleInfo = adminService.getBoardRuleInfo(3);
			
			model.addAttribute("replyRuleInfo", replyRuleInfo);
			model.addAttribute("boardRuleInfo", BoardRuleInfo);
			model.addAttribute("point_vos", point_vos);
			model.addAttribute("category_vos", category_vos);
			return "admin/ruleUpdateForm";
		}
		else return "redirect:/unusualapproach";
	}
	
	@RequestMapping(value = "/ruleUpdateForm",method=RequestMethod.GET)
	public String adminRuleUpdateFormGet() {
		 return "redirect:/unusualapproach";
	}
	
	@ResponseBody
	@RequestMapping(value = "/pointChangeOk",method=RequestMethod.POST)
	public int adminPointChangeOkPost(HttpSession session, Model model,
			@RequestParam(name="point",defaultValue="0",required=false) int point,
			@RequestParam(name="part",defaultValue="1",required=false)int part,
			@RequestParam(name="c_reason",defaultValue="",required=false)String c_reason
			) {
		
		PointVO vo = new PointVO();
		vo.setPart(part);
		vo.setPoint(point);
		vo.setC_reason(c_reason);
		System.out.println(vo);
		 int res = adminService.setPointSetterUpdate(vo);
		
		return res	;
	}
	
	@ResponseBody
	@RequestMapping(value = "/categoryInput", method=RequestMethod.POST)
	public int adminCategryInput(
			@RequestParam(name="categoryName",defaultValue="",required=false) String categoryName
			) {
		System.out.println(categoryName);
		int res = 0;
		if(!categoryName.equals("")) {
			res = adminService.setCategoryInput(categoryName);
		}
		
		return res;
	}
	
	@RequestMapping(value = "/adminReportForm", method=RequestMethod.POST)
	public String adminReportFormPost(Model model,
			@RequestParam(name="afterDate",defaultValue="",required=false)String afterDate,
			@RequestParam(name="beforeDate",defaultValue="",required=false)String beforeDate,
			@RequestParam(name="rep_category",defaultValue="0",required=false)int rep_category,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="20",required=false)int pageSize
			) {
		int blockSize = 5;
		List<ReportCategoryVO> repcVOS = adminService.getReportCategoryList();
		model.addAttribute("repcVOS", repcVOS);

		PageVO pageVO = pageProcess.pageProcessorForAdminReport(rep_category,afterDate,beforeDate, pageSize, nowPage, blockSize);
		List<ReportVO> reportVOS = adminService.getReportList(afterDate,beforeDate,rep_category,pageVO); 
		model.addAttribute("repVOS", reportVOS);
		
		return "admin/reportList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getReportDetail",method = RequestMethod.POST)
	public ReportVO adminGetReportDetailPost(
			@RequestParam(name="rep_idx",defaultValue="0",required=false) int rep_idx
			) {
		ReportVO vo = adminService.getReportDetail(rep_idx);
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/reportTakeInput",method = RequestMethod.POST)
	public void adminReportTakeInputPost(
			@RequestParam(name="rep_idx",defaultValue="0",required=false)int rep_idx,
			@RequestParam(name="reported_idx",defaultValue="0",required=false)int reported_idx,
			@RequestParam(name="reported_m_idx",defaultValue="0",required=false)int reported_m_idx, 
			@RequestParam(name="banType",defaultValue="",required=false)String banType,
			@RequestParam(name="takeSw",defaultValue="0",required=false)int takeSw,
			@RequestParam(name="deleteValue",defaultValue="0",required=false)int deleteValue,
			@RequestParam(name="penaltyTime",defaultValue="",required=false)String penaltyTime,
			@RequestParam(name="takeContent",defaultValue="",required=false)String takeContent,
			@RequestParam(name="tableName",defaultValue="",required=false)String tableName,
			@RequestParam(name="idxName",defaultValue="",required=false)String idxName
			) {
		if(deleteValue==1) {
			adminService.setDelete(tableName,idxName,reported_idx);
		}
		adminService.setBanList(reported_m_idx,banType,penaltyTime,takeContent);
		adminService.setReported_m_idx_Level(reported_m_idx,banType);
		adminService.setReportResultUpdate(rep_idx,takeSw,takeContent);
	}
	
	@RequestMapping(value = "/adminAskForm", method = RequestMethod.POST)
	public String adminAskFormPost(Model model,
			@RequestParam(name="afterDate",defaultValue="",required=false)String afterDate,
			@RequestParam(name="beforeDate",defaultValue="",required=false)String beforeDate,
			@RequestParam(name="ask_category",defaultValue="0",required=false)int ask_category,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="20",required=false)int pageSize
			) {
		int blockSize = 5;
		List<AskVO> askcVOS = adminService.getAskCategoryList();
		model.addAttribute("askcVOS", askcVOS);
		
		PageVO pageVO = pageProcess.pageProcessorForAdminAsk(ask_category, afterDate, beforeDate, pageSize, nowPage,blockSize);
		List<AskVO> askVOS = adminService.getAskList(afterDate,beforeDate,ask_category,pageVO);
		model.addAttribute("askVOS", askVOS);
		
		return "admin/askList";
	}
	
	@RequestMapping(value = "/adminAskForm", method = RequestMethod.GET)
	public String adminAskFormGet() {
		return "redirect:/unusualapproach";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getAskDetail",method = RequestMethod.POST)
	public AskVO adminAskDetailPost(
			@RequestParam(name="ask_idx",defaultValue="0",required=false)int ask_idx
			) {
		AskVO vo = adminService.getAskDetail(ask_idx);
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/askTakeSet", method = RequestMethod.POST)
	public void adminAskTakeSetPost(
			@RequestParam(name="ask_idx",defaultValue="0",required=false)int ask_idx,
			@RequestParam(name="takeContent",defaultValue="",required=false)String takeContent
			) {
		adminService.setAskTake(ask_idx,takeContent);
	}
	
	@ResponseBody
	@RequestMapping(value = "/autoLimitChange", method = RequestMethod.POST)
	public void adminLimitChange(
			@RequestParam(name="strLimitTime",defaultValue="",required = false)String strLimitTime,
			@RequestParam(name="actionLimit",defaultValue="0",required = false)int actionLimit,
			@RequestParam(name="rule_idx",defaultValue="0",required=false)int rule_idx
			) {
		adminService.setUpdateRuleSetterLimitOption(rule_idx,strLimitTime,actionLimit);
	}
	
	@ResponseBody
	@RequestMapping(value = "autoPenaltyChange", method = RequestMethod.POST)
	public void adminPenaltyChange(
			@RequestParam(name="strPenaltyTime",defaultValue="",required = false)String strPenaltyTime,
			@RequestParam(name="rule_idx",defaultValue="0",required=false)int rule_idx
			) {
		adminService.setUpdateRuleSetterPenaltyOption(rule_idx,strPenaltyTime);
	}
	
	@RequestMapping(value = "/MainImageUpload/{category}", method = RequestMethod.POST)
	public String adminBoardImageUpload(HttpSession session,MultipartFile fName,
			@PathVariable("category") int category
			) {
		JavaProvide provide = new JavaProvide();
		category = category+3;
		String realPath = session.getServletContext().getRealPath("/resources/data/mainCategory/");
		String reName = category+".jpg";
		provide.fileUploadRename(fName, realPath,reName);
		return "redirect:/admin/ruleUpdateForm";
	}
	
	@RequestMapping(value = "/adminBanListForm", method = RequestMethod.POST)
	public String adminBanListFormPost(Model model) {
		List<ReportVO> banListVOS = adminService.getBanList();
		System.out.println(banListVOS);
		model.addAttribute("BLVOS", banListVOS);
		return "admin/banUserList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/getBanDetail", method = RequestMethod.POST)
	public ReportVO adminGetBanDetailPost(
			@RequestParam(name="ban_idx",defaultValue="0",required=false)int ban_idx
			) {
		ReportVO vo = adminService.getBandetail(ban_idx);
		return vo;
	}
	
	@ResponseBody
	@RequestMapping(value = "/banOff", method = RequestMethod.POST)
	public void adminBanOffPost(
			@RequestParam(name="ban_idx",defaultValue="0",required=false) int ban_idx
			) {
		adminService.setBanOff(ban_idx);
	}
	
	@ResponseBody
	@RequestMapping(value = "/banUpdateSet", method = RequestMethod.POST)
	public void adminBanUpdateSetPost(
			@RequestParam(name="ban_idx",defaultValue="0",required = false)int ban_idx,
			@RequestParam(name="banType",defaultValue="",required = false)String banType,
			@RequestParam(name="cdate",defaultValue="",required = false)String cdate,
			@RequestParam(name="reasonInput",defaultValue="",required = false) String reason,
			@RequestParam(name="originalContent",defaultValue="",required = false) String originalContent
			) {
		reason = originalContent+"<hr>제재내용수정<br>"+reason;
		adminService.setBanUpdate(ban_idx,banType,cdate,reason);
	}
	
	@RequestMapping(value = "/adminBoardList", method = RequestMethod.GET)
	public String adminBoardListGet(Model model,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="15",required=false)int pageSize
			) {
		int blockSize = 5;
		PageVO pageVO = pageProcess.pageProcessorWithOutNews("board", pageSize, nowPage, blockSize);
		List<BoardVO> boardVOS = adminService.getAdminBoardList(pageVO);
		System.out.println(boardVOS);
		model.addAttribute("boardVOS", boardVOS);
		return "admin/adminBoardList";
	}
	
	@ResponseBody
	@RequestMapping(value = "/boardRestore", method = RequestMethod.POST)
	public void adminBoradRestoreGet(
			@RequestParam(name="boa_idx",defaultValue="0",required = false) int boa_idx
			) {
		adminService.setBoardRestore(boa_idx);
	}
	
	@ResponseBody
	@RequestMapping(value = "/boardDelete", method = RequestMethod.POST)
	public void adminBoradDeleteGet(
			@RequestParam(name="boa_idx",defaultValue="0",required = false) int boa_idx
			) {
		adminService.setBoardDelete(boa_idx);
	}
	
	@ResponseBody
	@RequestMapping(value = "/dateBaseDelete", method = RequestMethod.POST)
	public void admindateBaseDeleteGet(
			@RequestParam(name="boa_idx",defaultValue="0",required = false) int boa_idx
			) {
		adminService.setDateBaseDelete(boa_idx);
	}
	
	

}
