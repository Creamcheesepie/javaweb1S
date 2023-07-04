package com.spring.javaweb1S;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.javaweb1S.pagination.PageProcess;
import com.spring.javaweb1S.service.AttendanceService;
import com.spring.javaweb1S.vo.AttendanceVO;
import com.spring.javaweb1S.vo.PageVO;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {
	@Autowired
	AttendanceService attendanceService;
	
	@Autowired
	PageProcess page;
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String AttendanceListGet(Model model,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="15",required=false)int pageSize
			) {
		int blockSize = 5;//혹시 모를 블록사이즈 변동을 위한 변수
		PageVO pageVO =page.pageProcessor("attendance", pageSize, nowPage, blockSize); 
		List<AttendanceVO> att_vos = attendanceService.getAttendanceList(pageVO.getSin(),pageVO.getPageSize());
		
		model.addAttribute("att_vos", att_vos);
		model.addAttribute("pageVO", pageVO);
		return "attendance/attendanceList";
	}
	
	@ResponseBody
	@RequestMapping(value="/write", method=RequestMethod.POST)
	public int AttendanceWrite(Model model,HttpSession session,HttpServletRequest request,
			@RequestParam(name="nowPage", defaultValue="1",required=false)int nowPage,
			@RequestParam(name="pageSize",defaultValue="15",required=false)int pageSize,
			AttendanceVO vo
			) {
		int res = 0;
		
		vo.setM_idx((int)session.getAttribute("sM_idx"));
		res = attendanceService.setAttendanceWrite(vo);
		return  res;
	}
	
	@ResponseBody
	@RequestMapping(value="/update", method=RequestMethod.POST)
	public int AttendanceUpdatePost(
			@RequestParam(name="att_idx",defaultValue="0",required=false)int att_idx,
			@RequestParam(name="content",defaultValue="",required=false)String content
			) {
		int res =0;
		AttendanceVO attUp_VO = new AttendanceVO();
		attUp_VO.setAtt_idx(att_idx);
		attUp_VO.setContent(content);
		
		res = attendanceService.setAttendanceUpdate(attUp_VO);
		
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/delete", method=RequestMethod.POST)
	public int AttendanceDeletePost(
			@RequestParam(name="att_idx",defaultValue="0",required=false)int att_idx
			) {
		int res =0;
		res = attendanceService.setAttendanceDelete(att_idx);
		return res;
	}
	
	@ResponseBody
	@RequestMapping(value="/restore", method=RequestMethod.POST)
	public int AttendanceRestorePost(
			@RequestParam(name="att_idx",defaultValue="0",required=false)int att_idx
			) {
		int res =0;
		res = attendanceService.setAttendanceRestore(att_idx);
		return res;
	}
	
	
	
}
