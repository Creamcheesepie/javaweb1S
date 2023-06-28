package com.spring.javaweb1S;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.javaweb1S.service.AttendanceService;

@Controller
@RequestMapping("/attendance")
public class AttendanceController {
	@Autowired
	AttendanceService attendanceService;
	
	@RequestMapping(value="/list",method=RequestMethod.GET)
	public String AttendanceListGet() {
		
		
		return "attendance/attendanceList";
	}
	
	
	
}
