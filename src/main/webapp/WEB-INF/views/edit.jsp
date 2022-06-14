<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.Enumeration" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
<meta name="viewport" content="text/html;charset=UTF-8">
<link rel="stylesheet" href="css/bootstrap.css">
<title>글 작성</title>
<style>
*{margin 4px 0;}
.controller { padding:25px 0; margin: auto; width:840px;}
#wriTitle{text-align: center; background-color: #2b2b2b; width:850px; height: 25px; padding:12px 0; color: white;}
table { width:840px; margin:25px 0; padding:25px; border-collapse:collapse;}
#title{width : 840px; height: 24px;}
textarea{width: 840px; height: 650px;}
.button {margin : 4px 0; padding: 10px 0; width: 100px; background-color: #000000; color : white; border: none;}
button {align: center; margin : 4px 0; padding: 10px 0; width: 100px; background-color: #a34654; color : white; border: none;}
textarea {resize:none;}
	nav {
  display: flex;
 justify-content: space-around;
  align-items: center;
  background-color: #404040;
  color: white;
  margin : 0;
  padding : 0;
}

	nav ul li{
		display : inline-block;
	}
	
	.logo {
	letter-spacing:2px;
	font-size : 15px;
	text-align : left;
	float : center;
	}
	
	.logo a {
	color:white;
	padding : 16px 16px;
	}
	
	.dropdown {
		position : relative;
	}
	
	.dropdown-menu {
		color : white;
		font-size: 16px;
	}
	
	.dropdown-content {
			position: absolute;
   			 background-color: #f9f9f9;
    		min-width: 160px;
    		box-shadow: 0px 8px 24px 0px rgba(0,0,0,0.2);
    		display: none;
	}
	
	.dropdown-content a {
    color: black;
    padding: 12px 16px;
    text-decoration: none;
    display: block;
}   

	.dropdown-menu:hover:not(.home){
    background-color:#7a7a7a ;
    color: white;
}

	.dropdown:hover .dropdown-content {
    display: block;
}

	.dropdown-content a:hover {background-color: #f1f1f1}
</style>
</head>
<body>
		<nav>
			<div class="logo">
				<h3><a href="/">게시판</a></h3>
			</div>
				<sec:authorize access="isAnonymous()">
				<ul>
					<li class="dropdown">
						<div class="dropdown-menu">메뉴</div>
						<div class="dropdown-content">
							<a href="/login">로그인</a>
							<a href="/beforeSignUp">회원가입</a>
						</div>
					</li>
				</ul>
			   </sec:authorize>
			   <sec:authorize access="isAuthenticated()">
			   <ul>
					<li class="dropdown">
						<div class="dropdown-menu">${ uName}님</div>
						<div class="dropdown-content">
			   				<a href="/logout">로그아웃</a>
			   				<a href="/user/info">내 정보</a>
               				<a href="/admin">관리자</a>
			   			</div>
			   		</li>
			   	</ul>
			   </sec:authorize>
		</nav>
	<div class="controller">
		<div id="wriTitle" ><b>글 작성</b></div>
	<form action="/editaction" method="post" enctype="multipart/form-data">
		<input type="hidden" name="bId" value="${article.bId }">
		<table>
			<tr>
				<td><input type="text" name="bTitle" value="${article.bTitle}" required id = "title" />
				</td>
			</tr>
			<tr>
				<td colspan="2"><textarea rows="12" cols="50" name="bContent" required>${article.bContent}</textarea></td>
			</tr>
			<tr>
				<td align="center"><input type="submit" value="수정" class="button"></td>
			</tr>
	</table>
	</form>
	</div>
</body>
</html>