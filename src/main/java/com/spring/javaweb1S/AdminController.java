package com.spring.javaweb1S;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb1S.pagination.PageProcess;
import com.spring.javaweb1S.service.AdminService;
import com.spring.javaweb1S.vo.CategoryVO;
import com.spring.javaweb1S.vo.PageVO;
import com.spring.javaweb1S.vo.PointVO;
import com.spring.javaweb1S.vo.ReportCategoryVO;
import com.spring.javaweb1S.vo.ReportVO;

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
		System.out.println(vo);
		return vo;
	}
	
}
