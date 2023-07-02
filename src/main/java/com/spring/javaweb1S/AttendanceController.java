package com.spring.javaweb1S;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

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
			@RequestParam(name="PageSize",defaultValue="15",required=false)int pageSize
			) {
		int blockSize = 5;//혹시 모를 블록사이즈 변동을 위한 변수
		PageVO pageVO =page.pageProcessor("attendance", pageSize, nowPage, blockSize); 
		List<AttendanceVO> att_vos = attendanceService.getAttendanceList(pageVO.getSin(),pageVO.getPageSize());
		
		model.addAttribute("att_vos", att_vos);
		model.addAttribute("pageVO", pageVO);
		return "attendance/attendanceList";
	}
	
	
	
}
