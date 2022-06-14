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
</body>
</html>