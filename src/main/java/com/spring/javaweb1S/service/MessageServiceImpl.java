package com.spring.javaweb1S.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.MessageDAO;

@Service
public class MessageServiceImpl implements MessageService {
	@Autowired
	MessageDAO messageDAO;
	
	
}
