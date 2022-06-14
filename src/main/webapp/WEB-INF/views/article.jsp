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
<title>${article.bTitle}</title>
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
	border-collapse: separate;
	border-spacing:0 5px;
	}
	th {
	background-color : rgb(175,175,175);
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
				<h3><a href="/1">게시판</a></h3>
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
  <div class = "controller">
		<div class ="row">
		<div id = "bTitle">
			<table class="table table-striped" style="text-align:left; width:840px">
				<thead>
					<tr>
						<td style="height:50px; font-size:25px;"><STRONG>${article.bTitle}</STRONG>
					</tr>
					<tr>
						<th colspan="2" align="center" style="height: 1px"></th>
					</tr>
					<tr>
						<td style="width: 10%; height: 20px"><strong>작성자</strong></td>
						<td colspan="2">${article.bWriter}</td>
					</tr>
					<tr>
						<td style="width: 10%; height: 20px"><strong>작성일</strong></td>
						<td colspan="2">${article.bDatetime}</td>
					</tr>
					<tr>
						<td style="width: 10%; height: 20px"><strong>조회수</strong></td>
						<td colspan="2">${article.bBrdhit}</td>
					</tr>
					<tr>
						<th colspan="2" align="center" style="height: 1px"></th>
					</tr>
				</thead>
				<tbody>
			
					<tr>
						<th colspan="2" align="center" style="height: 20px; background-color : rgb(255,255,255); color:white;" ></th>
					</tr>
					<c:forEach items="${filelist}" var="item">
					<c:if test="${not empty item.bId}">
						<tr>
							<td><img src ="/img/${item.fileName}"/></td>
						</tr>
					</c:if>
					</c:forEach>
					<tr id="content" valign="top" style="border-top-color: rgb(100, 100, 100); border-top-width: 15px">
						<td colspan="3">${article.bContent }</td>
					</tr>
					<tr>
						<th colspan="2" align="center" style="height: 0.25px; background-color : rgb(0,0,0);"></th>
					</tr>
				</table>
				<div class="container">
				<div class="form-group">
					<form method="post">
						<input type="hidden" name="bId" value="${article.bId}">
						<table class="table table-striped" style="text-align: center; border: 1px solid #dddddd">
							<tr>
								<td align = "center" style = "border-bottom:none; text-align: center;">${user.u_name}</td>
								<td><input type="text" style="width:600px; height:25px;" class="form-control" placeholder="Comment" name="commentContent" id="commentContent"></td>
								<td><input type="button" style="width: 100px; height: 30px; background-color : #ffffff" class="btn-primary pull" value="댓글 등록" id="btnComment"></td>
							</tr>
						</table>
					</form>	
				</div>	
			</div>
				<div class="container" id="commentList">
				<div class="row">
					<table class="table table-striped" style="text-align :center; border: 1px solid #dddddd">
						<tbody>
							<tr>
								<td style="width: 20%" align="center"><strong>Comment</strong></td>
							</tr>
							<tr>
								<td>
									<div class = "container">
										<div class="row">
											<table class="table table-striped" style="text-align:center; border: 1px solid #dddddd">
												<c:forEach items="${list1}" var="item">
													<c:if test="${not empty list1}">
														<tbody>
															<tr>
																<td align="left" nowrap><strong>
																	<c:if test="${item.commentDepth > 0}">
																		<c:forEach begin="1" end="${item.commentDepth}">
										 									&nbsp; &nbsp; &nbsp; RE:
										 								</c:forEach>
																	</c:if>
																${item.commentWriter}</strong></td>
																<td colspan="2" nowrap></td>
																<td align="right" class="region" nowrap>
																	<a class="show">답글</a>
																	<c:if test="${uName == item.commentWriter || uAuth == 'ROLE_ADMIN'}">
																		<a class="show1">수정</a>
																	</c:if>
																	<c:if test="${uName == item.commentWriter || uAuth == 'ROLE_ADMIN'}">
																		<a class="commentDelete" cnum="${item.cNum }">삭제</a>
																	</c:if>
																</td>
															</tr>
															<tr style="display:none;">
																<td><input type="text" style="width:620px; height:25px;" class="commentReply" placeholder="Comment" name="commentReply"></td>
																<td><input type="button" style="width: 50px; height: 30px; background-color : #ffffff" class="btn-primary pull btnCommentReply" value="등록" cnum="${item.cNum }" group="${item.commentGroup}" order="${item.commentOrder }" depth="${item.commentDepth }"></td>
															</tr>
															<tr style="display:none;">
																<td><input type="text" style="width:620px; height:25px;" class="commentUpdate" value="${item.commentContent}" name="commentUpdate"></td>
																<td><input type="button" style="width: 50px; height: 30px; background-color : #ffffff" class="btn-primary pull btnCommentUpdate" value="수정" cnum="${item.cNum }"></td>
															</tr>
															<tr>
																<td colspan="5" align="left">
																	<c:if test="${item.commentDepth > 0}">
																		<c:forEach begin="1" end="${item.commentDepth}">
										 									 &nbsp; &nbsp; &nbsp;
										 								</c:forEach>
																	</c:if>
																${item.commentContent}</td>
															</tr>
														</tbody>
													</c:if>
												</c:forEach>
											</table>
										</div>
									</div>
								</td>
							</tr>
						</tbody>
					</table>
				</div>
			</div>
				    <div style="float: left">
					<c:if test="${uName == article.bWriter || uAuth == 'ROLE_ADMIN'}">
					<a href="/edit/${article.bId}"><button style="background-color : #696969" id="bUpdate">수정</button></a>
					</c:if>
					<c:if test="${uName == article.bWriter || uAuth == 'ROLE_ADMIN'}">
					<a href="/delete/${article.bId}"><button style="background-color : #911616" id="bDelete">삭제</button></a>
					</c:if>
					<a href="/reply/${article.bId}"><button style="background-color : #000000" id="bReply">답글</button></a>
   			    </div>
			</div>
		</div>
	</div>
	<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>
<script src="js/bootstrap.js"></script>
<script>
$(document).on('click', '#btnComment', function () {
	let content = $(this).parent().prev().find('input[name="commentContent"]').val();
	
	$.ajax({
		method: "POST",
		url: "/commentaction",
		data: { commentContent:$("#commentContent").val(), bId: '${article.bId}'}
	})
	.done(function( html ) {
		$('#commentList').html(html);
	});
});

$(document).on('click', '.btnCommentReply', function () {
	let cnum = $(this).attr('cnum');
	let group = $(this).attr('group');
	let order = $(this).attr('order');
	let depth = $(this).attr('depth');
	let content = $(this).parent().prev().find('input[name="commentReply"]').val();
	
	$.ajax({
		method: "POST",
		url: "/commentreplyaction",
		data: { commentContent : content, bId: '${article.bId}', cNum : cnum, commentGroup: group, commentOrder: order, commentDepth: depth}
	})
	.done(function( html ) {
		$('#commentList').html(html);
	});
	
	console.log(false == '0');
});
$(document).on('click', '.btnCommentUpdate', function () {
	let cnum = $(this).attr('cnum');
	let content = $(this).parent().prev().find('input[name="commentUpdate"]').val();
	
	$.ajax({
		method: "POST",
		url: "/commentupdateaction",
		data: { commentContent : content, bId: '${article.bId}', cNum: cnum}
	})
	.done(function( html ) {
		$('#commentList').html(html);
	});
	
	console.log(false == '0');
});

$(document).on('click', '.commentDelete', function () {
	let cnum = $(this).attr('cnum');
	$.ajax({
		method: "POST",
		url: "/commentdelete",
		data: {bId : '${article.bId}', cNum: cnum}
	})
	.done(function( html ) {
		$('#commentList').html(html);
	});
	
	console.log(false == '0');
});

$(document).on('click', '.show', function () {
	let $dis = $(this).parent().parent().next(); 
	
    if($dis.css('display') == 'none'){
        $dis.show();
    }else{
        $dis.hide();
    }
});
$(document).on('click', '.show1', function () {
	let $dis = $(this).parent().parent().next().next(); 
	
    if($dis.css('display') == 'none'){
        $dis.show();
    }else{
        $dis.hide();
    }
});
</script>
</body>
</html>
