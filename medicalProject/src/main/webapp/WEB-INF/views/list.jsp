<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap.min.css">
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.2/css/bootstrap-theme.min.css">
<script src="https://code.jquery.com/jquery-3.5.1.js" integrity="sha256-QWo7LDvxbWT2tbbQ97B53yJnYU3WhH/C8ycbRAkjPDc=" crossorigin="anonymous"></script>
<title>게시판</title>
<style type="text/css">
li {
	list-style: none;
	float: left;
	padding: 6px;
}

.container{
			margin-top:150px;
 		}
 		
 	.board-table{
 			border-spacing:10px;
 			border-collapse: separate;
 			width : 90%;
 			margin : 0 auto;
 		}
 		 #consult {
		float:right;
		right:-50px;
		position: absolute;
		height: 400px;
		top: 10px;
		cursor:pointer;
	}
 		
 		
</style>
<script>
//상담버튼 따라다니게 하는 제이쿼리
$(document).ready(function() {

	// 기존 css에서 플로팅 배너 위치(top)값을 가져와 저장한다.
	var floatPosition = parseInt($("#consult").css('top'));
	// 250px 이런식으로 가져오므로 여기서 숫자만 가져온다. parseInt( 값 );

	$(window).scroll(function() {
		// 현재 스크롤 위치를 가져온다.
		var scrollTop = $(window).scrollTop();
		var newPosition = scrollTop + floatPosition + "px";

		/* 애니메이션 없이 바로 따라감
		 $("#floatMenu").css('top', newPosition);
		 */

		$("#consult").stop().animate({
			"top" : newPosition
		}, 500);

	}).scroll();
});
</script>

</head>
<body>
	<div class="header">
		<%@ include file="./header.jsp"%>
	</div>
	
	<div class="content">
		<header>
			<h1 class="sub-title">게시판</h1>
		</header>
			<div class="navPosition">
				<%@include file="nav.jsp" %>
			</div>

		<section id="container">
			<form role="form" method="get" class="table table-bover"
				action="${pageContext.request.contextPath}/write">
				<table class="board-table">
					<tr>
						<td style="width:55px; text-align:center;">번호</td>
						<td style="width:800px; text-align:center;">제목</td>
						<td style="width:55px; text-align:center;">작성자</td>
						<td style="width:55px; text-align:center;">등록일</td>
					</tr>

					<c:forEach items="${list}" var="list">
						<tr>
							<td style="text-align:center;"><c:out value="${list.bno}" /></td>
							<td style="text-align:left;">
							<a href="${pageContext.request.contextPath}/readView?bno=${list.bno}&
										page=${scri.page}&
										perPageNum=${scri.perPageNum}&
										searchType=${scri.searchType}&
										keyword=${scri.keyword}"><c:out value="${list.title}"/></a>
							</td>
																				 				
							<td style="text-align:center;"><c:out value="${list.writer}" /></td>
							<td style="text-align:center;"><c:out value="${list.reg_date}" /></td>
						</tr>
					</c:forEach>

				</table>
				<div class="search row">
					<div class="col-xs-2 col-sm-2">
					<select name="searchType" class="form-control">
						  <option value="n"<c:out value="${scri.searchType == null ? 'selected' : ''}"/>>-----</option>
					      <option value="t"<c:out value="${scri.searchType eq 't' ? 'selected' : ''}"/>>제목</option>
					      <option value="c"<c:out value="${scri.searchType eq 'c' ? 'selected' : ''}"/>>내용</option>
					      <option value="w"<c:out value="${scri.searchType eq 'w' ? 'selected' : ''}"/>>작성자</option>
					      <option value="tc"<c:out value="${scri.searchType eq 'tc' ? 'selected' : ''}"/>>제목+내용</option>					
					 </select>
					</div>
					
					<div class="col-xs-10 col-sm-10">
						<div class="input-group">
							 <input type="text" name="keyword" id="keywordInput" value="${scri.keyword}" class="form-control"/>
							 <span class="input-group-btn">
							    <button id="searchBtn" type="button" class="btn btn-default">검색</button>
  						     </span>
  						 </div>
  					</div>
  					   
				    <script>
				      function searching(){
				        $('#searchBtn').click(function() {
				          self.location = "list" + '${pageMaker.makeQuery(1)}' + "&searchType=" + $("select option:selected").val() + "&keyword=" + encodeURIComponent($('#keywordInput').val());
				        });
				      }
				    </script>
				</div>
				<div>
					<ul style="height: 30px; margin: 10px 0 0 0; text-align: center;width: 300px;margin-left: auto;margin-right: auto;padding: 0;"`>
						<c:if test="${pageMaker.prev}">
							<li><a
								href="list${pageMaker.makeSearch(pageMaker.startPage - 1)}">이전</a></li>
						</c:if>

							<c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
								<li <c:out value="${pageMaker.cri.page == idx ? 'class=info' : ''}" />>
								<a href="list${pageMaker.makeSearch(idx)}">${idx}</a></li>
							</c:forEach>
						<c:if test="${pageMaker.next && pageMaker.endPage > 0}">
							<li><a
								href="list${pageMaker.makeSearch(pageMaker.endPage + 1)}">다음</a></li>
						</c:if>
					</ul>
				</div>
			</form>
			</section>
		<hr />
		<div class="chat-doot">
		<svg width="50px" height="50px" float="right" viewBox="0 0 16 16" id="consult" onclick="nwindow();" class="bi bi-chat-dots-fill" fill="currentColor" xmlns="http://www.w3.org/2000/svg">
	 		<path fill-rule="evenodd" d="M16 8c0 3.866-3.582 7-8 7a9.06 9.06 0 0 1-2.347-.306c-.584.296-1.925.864-4.181 1.234-.2.032-.352-.176-.273-.362.354-.836.674-1.95.77-2.966C.744 11.37 0 9.76 0 8c0-3.866 3.582-7 8-7s8 3.134 8 7zM5 8a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm4 0a1 1 0 1 1-2 0 1 1 0 0 1 2 0zm3 1a1 1 0 1 0 0-2 1 1 0 0 0 0 2z"/>
		</svg>
	</div>
		
	</div>
	
	<div class="footer">
		<%@ include file="./footer.jsp"%>
	</div>
	<style>         
      .footer-content ul{
         height: 30px;
      }
      
      .company{
          position: relative;
          left: 480px;
      }
      
      .content{
         margin-top:150px;
      }
   </style>   
	
</body>
</html>