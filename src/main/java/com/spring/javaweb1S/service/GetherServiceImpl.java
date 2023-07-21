package com.spring.javaweb1S.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.javaweb1S.dao.GetherDAO;

@Service
public class GetherServiceImpl implements GetherService {
	@Autowired
	GetherDAO getherDAO;
}
