<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
	<link rel="preconnect" href="https://fonts.googleapis.com">
	<link rel="preconnect" href="https://fonts.gstatic.com">
	<link href="https://fonts.googleapis.com/css2?family=IBM+Plex+Sans+KR:wght@400;600;700&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/galmuri/dist/galmuri.css">
	<style>
	body {
	  min-height: 100vh;
	  display: flex;
	  flex-direction: column;
	}
	.footer{
		margin-top: auto;
	}
	textarea {
    resize: none;
  }
	.mainTitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size: 32px;	
	}
	.mainTitle-dot{
		font-family:"Galmuri14", sans-serif;
		font-weight:400;
		font-size: 30px;	
	}
	.subTitle-dot{
		font-family:"Galmuri11", sans-serif;
		font-weight:400;
		font-size: 24px;	
	}
	.inactive{
		color: lightgray;	
	}
	.listTitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
	}
	.subTitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:600;
		font-size: 20px;
	}
	.material-symbols-outlined {
	  font-variation-settings:
	  'FILL' 0,
	  'wght' 500,
	  'GRAD' 0,
	  'opsz' 48
	}
	.galary-icon{
		font-size:37px;
		margin : 0;
		vertical-align:middle;
	}
	.write-icon{
		font-size:26px;
		margin : 0;
		vertical-align:middle;
	}
	.listTitle-icon{
		font-size: 26px;
		vertical-align:middle;
	}
	.subTitle-icon{
		font-size: 24px;
		vertical-align:middle;
	}
	hr{
		margin : 10px 0px 10px 0px;
	}
	.font-bold{
		font-weight: 800;
	}
	.button-font{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:18px;
	}
	.button-font-big{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:24px;
	}
	.fontdot-20{
		font-family: 'Galmuri9', sans-serif;
		font-weight:400;
		font-size:20px;
	}
	.fontdot-10{
		font-family: 'Galmuri9', sans-serif;
		font-weight:400;
		font-size:10px;
	}
	.fontdot-12{
		font-family: 'Galmuri11', sans-serif;
		font-weight:400;
		font-size:12px;
	}
	.fontdot-12-condensed{
		font-family: "Galmuri11", sans-serif;
		font-stretch: condensed;
		font-size:12px;
	}
	.statusContent{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:400;
		font-size:16px;
	}
	.navTitle{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:22px;
	}
	.navSubject{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:18px;
	}
	.mainfont-b-28{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:28px;
	}
	.mainfont-b-24{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:24px;
	}
	.mainfont-b-22{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:22px;
	}
	.mainfont-b-20{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:20px;
	}
	.mainfont-b-18{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:18px;
	}
	.mainfont-b-16{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:16px;
	}
	.mainfont-m-18{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:400;
		font-size:18px;
	}
	.mainfont-m-16{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:400;
		font-size:16px;
	}
	.mainfont-m-14{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:400;
		font-size:14px;
	}
	input{
		font-family: 'IBM Plex Sans KR', sans-serif;
	}
	.mainfont-b-20-inactive{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:20px;
		color: lightgray;
	}
	.mainfont-b-16-inactive{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:16px;
		color: lightgray;
	}
	.mainfont-b-18-inactive{
		font-family: 'IBM Plex Sans KR', sans-serif;
		font-weight:700;
		font-size:18px;
		color: lightgray;
	}
	.board_content{
		border-radius:5px;
		border-style:solid;
		border-color: lightgray;
		border-width: 1px;
	}
	.profile_img{
		width: 127px;
		height: 100px;
	}
	.inactive{
		color : lightgray;
	}
	.agro-b-16{
		font-family: 'SBAggroB';
		font-weight: 500;
		font-size: 16px;
	}
	.frontTitle{
		font-family: 'establishRoomNo703OTF';
		font-weight: 500;
		font-size: 55px;
	}
	
	@font-face {
    font-family: 'establishRoomNo703OTF';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2112@1.0/establishRoomNo703OTF.woff') format('woff');
    font-weight: normal;
    font-style: normal;
	}
	
	@font-face {
		font-family: 'SBAggroB';
    src: url('https://cdn.jsdelivr.net/gh/projectnoonnu/noonfonts_2108@1.1/SBAggroB.woff') format('woff');
		font-weight: normal;
    font-style: normal;
	}
	</style>
