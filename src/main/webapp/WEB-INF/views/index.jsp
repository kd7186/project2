<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page import = "java.io.PrintWriter" %>
<%@ page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글 목록</title>
<style>
.controller {
	padding: 25px 0;
	margin : auto;
	width : 840px;
	text-align: center;
	}
table {
	width: 840px
	padding : 10px 0;
	border-collapse: collapse;
	}
	th {
	background-color : rgb(100,100,100);
	color : white;
	}
	button {
	margin : 4px 0;
	padding: 10px 0;
	width: 100px;
	background-color: #1595a3;
	color : white;
	border: none;
}
	a{
	text-decoration: none;
	color: black;
	}
	a:hover {
		color: #000000;
		text-decoration-line: underline;
		}
		
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
	<table>
	<tr>
	<th width="40px">#</th>
	<th width="510px">제목</th>
	<th width="120px">작성자</th>
	<th width="120px">날짜</th>
	<th width="50px">조회수</th>
	</tr>
		<c:forEach items="${list}" var="item">
			<tr style="border-bottom:1px solid gray;">
			<td>${item.bId}</td>
			<td>
				<c:if test="${item.bDepth > 0}">
					<c:forEach begin="1" end="${item.bDepth}">
					 	RE:
					 </c:forEach>
				</c:if>
				<b><a href="/article/${item.bId}">${item.bTitle}</a></b>
			</td>
			<td>${item.bWriter}</td>
			<td>${item.bDatetime}</td>
			<td>${item.bBrdhit}</td>
			</tr>
		</c:forEach>
	</table>
	</div>
	<div style="display:inline">
		<ul style="width:400px; height:50px; margin:10px auto;" >
				<c:choose>
					<c:when test="${pagination.prevPage > 0}">
						<c:if test="${pagination.search.search eq null}">
						<li style="list-style:none; width:50px; line-height:50px; border:1px solid #ededed; float:left; text-align:center; margin:0 5px; border-radius:5px;">
							<a style="text-decoration:none; color:#000; font-weight:700;" href="/${pagination.prevPage}">
								PREV
							</a>
						</li>
						</c:if>
						<c:if test="${pagination.search.search ne null}">
						<li style="list-style:none; width:50px; line-height:50px; border:1px solid #ededed; float:left; text-align:center; margin:0 5px; border-radius:5px;">
							<a style="text-decoration:none; color:#000; font-weight:700;" href="/${pagination.prevPage}?find=${pagination.search.find}&search=${pagination.search.search}">
								PREV
							</a>
						</li>
						</c:if>
					</c:when>
				</c:choose>
				<c:forEach var="i" begin="${pagination.startPage}" end="${pagination.endPage}" step="1">	
					<c:choose>
						<c:when test="${pagination.page eq i }">
							<li style="list-style:none; width:50px; line-height:50px; border:1px solid #ededed; float:left; text-align:center; margin:0 5px; border-radius:5px;">
								<span>${i}</span>
							</li>
						</c:when>
						<c:when test="${pagination.page ne i }">
							<c:if test="${pagination.search.search eq null}">
								<li style="list-style:none; width:50px; line-height:50px; border:1px solid #ededed; float:left; text-align:center; margin:0 5px; border-radius:5px;">	
									<a style="text-decoration:none; color:#000; font-weight:700;" href="/${i}">${i}</a>
								</li>
							</c:if>
							<c:if test="${pagination.search.search ne null}">
								<li style="list-style:none; width:50px; line-height:50px; border:1px solid #ededed; float:left; text-align:center; margin:0 5px; border-radius:5px;">	
									<a style="text-decoration:none; color:#000; font-weight:700;" href="/${i}?find=${pagination.search.find}&search=${pagination.search.search}">${i}</a>
								</li>
							</c:if>
						</c:when>
					</c:choose>
				</c:forEach>
				<c:choose>
					<c:when test="${pagination.nextPage <= pagination.lastPage }">
						<c:if test="${pagination.search.search eq null}">
							<li style="list-style:none; width:50px; line-height:50px; border:1px solid #ededed; float:left; text-align:center; margin:0 5px; border-radius:5px;">
								<a style="text-decoration:none; color:#000; font-weight:700;" href="/${pagination.nextPage}">NEXT</a>
							</li>
						</c:if>
						<c:if test="${pagination.search.search ne null}">
							<li style="list-style:none; width:50px; line-height:50px; border:1px solid #ededed; float:left; text-align:center; margin:0 5px; border-radius:5px;">
								<a style="text-decoration:none; color:#000; font-weight:700;" href="/${pagination.nextPage}?find=${pagination.search.find}&search=${pagination.search.search}">NEXT</a>
							</li>
					</c:if>
					</c:when>
				</c:choose>
			</ul>
		</div>
	<div align="center" style="width:100%; word-break:break-all; word-wrap:break-word;">
			<form name="sform" method="get" action="/1">
    			<select name="find">
        			<option value="b_writer">작성자</option>
        			<option value="b_title">제목</option>
       				<option value="b_content">내용</option>
    			</select>
    			<input name="search" type="text" class="form-control" size="20" placeholder="검색어를 입력하세요.">
    			<input type="submit" value="찾기">
			</form>
	</div>
	<div align="center">
		<p>
		  <a href="/write"><button style="background-color:#202020">글쓰기</button></a><br />
		</p>
	</div>
</body>
</html>
