<%@page import="com.koreait.vo.GuestbookList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
<!-- jstl:  (Jsp Standard Tag Library) 자바서버 페이지 표준 태그 라이브러리 -->  
<!-- jstl을 이용해 대입문, 제어문, 서식, 함수를 사용하기 위해 아래의 내용을 코딩한다. -->
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> <!-- 대입문, 제어문 사용 -->
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <!-- 서식 -->
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%> <!-- 함수 -->

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>

<style type="text/css">
	span {
		color: red;
		font-weight: bold;
	}
</style>
</head>
<body>

<!-- jstl을 사용하는 post 방식 한글 깨짐 방지 -->
<!-- request.setCharacterEncoding("UTF-8"); -->
<fmt:requestEncoding value="UTF-8"/>

<%--
	EL을 사용하면 request 영역에 저장된 데이터를 받는 처리 없이 이 영역에 저장된 객체를 사용할 수 있다.
	${guestbookList}
	
	jstl 대입문 => c:set 
	<c:set var="변수이름" value="변수에 저장할 데이터"></c:set>
	
	jstl if문 => c:if=> else를 사용할 수 없다. => else처리가 필요하면 조건을 반대로 해서 별도의 if를 만들어 사용해야 한다.
	<c:if test="${condition}>
		조건식이 참일경우 실행할 문장
	</c:if>
	
	jstl 향상된 for
	<c:forEach var="변수이름" items="${배열 || 목록 객체}> 
		반복할 문장
	</c:forEach>
	jstl 일반 for => 초기치 부터 증가치만큼 증가하며 최종치까지 반복한다. => 증가치의 기본값은 1이고 생략하면 기본값으로 적용된다. 증가치는 음수 사용이 불가능하다.
	<c:forEach var="변수이름" begin="초기치" end="최종치" [step="증가치"]> 
		반복할 문장
	</c:forEach>
	
	jstl 날짜 서식 => 자바와 같다.
	<fmt:formatDate value="${날짜데이터} pattern="자바 날짜 서식"/>
	
	jstl 함수 사용하기
	${fn:함수이름(인수)}
--%>

<!-- 브라우저에 출력할 1페이지 분량의 글 목록(guestbookList.list)만 꺼내서 별도로 배열목록에 저장시켜 저장한다. 
	EL을 사용할 때 객체 이름 뒤에 "."을 찍고 멤버이름을 적으면 그 멤버의 getter메소드가 실행된다.
	ArrayList<GuestbookVO> view = guestbookList.getList();와 같은 기능이 실행된다.
-->
<c:set var="view" value="${guestbookList.list}"></c:set>

<table width="1000" align="center" border="1" cellpadding="5" cellspacing="0">
	<tr>
		<th>방명록 보기 </th>
	</tr>
	<tr>
		<td align="right">
			<%-- <%= guestbookList.getTotalCount()%>개( <%=guestbookList.getCurrentPage()%> / <%=guestbookList.getTotalPage()%> )Page --%>
			${guestbookList.totalCount}개(${guestbookList.currentPage} / ${guestbookList.totalPage}) Page
		</td>
	</tr>
	<tr>
		<td>
			<!-- 테이블에 저장된 글이 없으면 브라우저에 글이 없다고 출력한다. -->
			<c:if test="${view.size() == 0}">
				<b>테이블에 저장된 글이 없습니다.</b><br/>
			</c:if>
			
			<!-- 테이블에 저장된 글이 있으면 글 목록을 출력한다. -->
			<c:if test="${view.size() != 0}">
				<!-- useBean 액션태그를 이요해 오늘 날짜를 기억하는 Date 클래스 객체를 선언한다.
				Date date = new Date();와 같은 기능이 실행된다.			 -->
				<jsp:useBean id="date" class="java.util.Date"/>
				<!-- sdf는 따로 설정하지 않고 fmt로 대체가능 -->

				<!-- for (GuestbookVO vo: view) -->
				<c:forEach var="vo" items="${view}">
					<table width="99%" align="center" border="1" cellpadding="5" cellspacing="0" 
						
						<c:if test="${vo.idx % 2 == 0 }">
							bgcolor='#00ffbf'
						</c:if>
						<c:if test="${vo.idx % 2 != 0 }">
							bgcolor='cyan'
						</c:if>
					>
					<tr>
						<td> 
							${vo.idx}.
							<%-- <%=vo.getName().replace("<", "&lt").replace(">", "&gt")%>님 --%>
							<c:set var="name" value="${fn:replace(vo.name,'<','&lt;') }"/>
							<c:set var="name" value="${fn:replace(name,'>','&gt;') }"/>
							<c:if test="${category == null || category == '내용'}">
								${name}
							</c:if>
							<c:if test="${category == '이름' || category == '내용 + 이름'}">
								<c:set var="search" value="<span>${item}</span>"/>
								${fn:replace(name, item, search)}
								
							</c:if>
							(${vo.ip})님이
							<!-- 오늘 입력한 글은 시간만 나오게 하고 오늘 이전에 입력한 글은 날짜만 나오게 한다. -->
							<c:if test="${date.year == vo.writeDate.year 
							&& date.month == vo.writeDate.month && date.date == vo.writeDate.date}">
								<fmt:formatDate value="${vo.writeDate}" pattern="HH:mm"/>
							</c:if>	
							<c:if test="${date.year != vo.writeDate.year || date.month != vo.writeDate.month || date.date != vo.writeDate.date}">
								<fmt:formatDate value="${vo.writeDate}"/>
								
							</c:if>	
							에 남긴글 
							
							<!-- 수정 또는 삭제 버튼이 클릭되면 수정 또는 삭제할 글 1건을 얻어오는 페이지로 수정또는 삭제할 글번호와 수정 또는 삭제 후 돌아갈 페이지 번호와 어떤 버튼이 클릭되었나를 의미하는  식별자를 넘겨준다. -->
							<input type="button" value="수정" 
							onclick="location.href='selectByIdx.jsp?idx=${vo.idx}&currentPage=${guestbookList.currentPage}&job=update'"/>
							<input type="button" value="삭제" 
							onclick="location.href='selectByIdx.jsp?idx=${vo.idx}&currentPage=${guestbookList.currentPage}&job=delete'"/>
							<br/>
							<%-- <%=vo.getMemo().replace("<", "&lt").replace(">", "&gt").replace("\r\n", "<br/>")%> --%>
							<c:set var="memo" value="${fn:replace(vo.memo,'<','&lt') }"/>
							<c:set var="memo" value="${fn:replace(memo,'>','&gt') }"/>
							<c:set var="memo" value="${fn:replace(memo, enter,'<br/>') }"/> 
							
							<!-- 내용에 포함된 검색어를 강조해서 표시한다. -->
							<c:if test="${category == null || category == '이름'}">
								${memo}
							</c:if>
							<c:if test="${category == '내용' || category == '내용 + 이름'}">
								<c:set var="search" value="<span>${item}</span>"/>
								${fn:replace(memo, item, search)}
								
							</c:if>
						</td>
					</tr> 
					</table>
				
				</c:forEach>								
			</c:if>
		</td>
	</tr>
	<!-- 페이지 이동버튼 -->
	<tr>
		<td align="center">
		
			
		<!-- 처음으로 -->
			<c:if test="${guestbookList.currentPage > 1}">
				<input type="button" class="button button2" value="맨앞" onclick="location.href='?currentPage=1'" title="첫 페이지로 이동하기"/>
			</c:if>	
			<c:if test="${guestbookList.currentPage <= 1}">
				<input type="button" class="button button3" value="맨앞" disabled="disabled" onclick="location.href='?currentPage=1'" title="첫 페이지 입니다."/>
			</c:if>	
		<!-- 10페이지 앞으로 -->
			<c:if test="${guestbookList.startPage > 1 }">
				<input type="button" class="button button2" value="이전" onclick="location.href='?currentPage=${guestbookList.startPage - 1 }'" title="이전 페이지 목록으로 이동하기"/>
			</c:if>
			<c:if test="${guestbookList.startPage <= 1 }">
				<input type="button" class="button button3" value="이전" disabled="disabled" title="이미 첫 페이지 목록 입니다."/>
			</c:if>
		<!-- 페이지 이동버튼 출력 -->
		
		<c:forEach var="i" begin="${guestbookList.startPage}" end="${guestbookList.endPage}">
			<c:if test="${guestbookList.currentPage == i}">
				<input type="button" class="button button1" value="${i}" disabled="disabled" title="현재 페이지입니다.">
			</c:if>
			
			<c:if test="${guestbookList.currentPage != i}">
				<input type="button" class="button button2" value="${i}" onclick="location.href='?currentPage=${i}'"
				title="${i} 페이지로 이동하기" >
			</c:if>
		</c:forEach>
			
		<!-- 10페이지 뒤로 -->
			<c:if test="${guestbookList.endPage < guestbookList.totalPage }">
				<input type="button" class="button button2" value="다음" onclick="location.href='?currentPage=${guestbookList.endPage + 1 }'" title="다음 페이지 목록으로 이동하기"/>
			</c:if>
			<c:if test="${guestbookList.endPage >= guestbookList.totalPage }">
				<input type="button" class="button button3" value="다음" disabled="disabled" title="이미 마지막 페이지 목록 입니다."/>
			</c:if>
		
		<!-- 마지막 페이지로 -->
			<c:if test="${guestbookList.currentPage < guestbookList.totalPage }">
				<input type="button" class="button button2" value="맨뒤" onclick="location.href='?currentPage=${ guestbookList.totalPage }'" title="마지막 페이지로 이동하기"/>
			</c:if>
			<c:if test="${guestbookList.currentPage >= guestbookList.totalPage }">
				<input type="button" class="button button3" value="맨뒤" disabled="disabled"  title="이미 마지막 페이지 입니다."/>
			</c:if>
		</td>
	</tr>
	
	<!-- 카테고리별 검색어를 입력받는다. -->
	<tr> 
		<td align="center">
			<form action="list.jsp" method="post">
				<select name="category">
					<option>내용</option>
					<option>이름</option>
					<option>내용 + 이름</option>
					
				</select>
				<input type="text" name="item"/>
				<input type="submit" value="검색">
			</form>
		</td>
		
	</tr>
	
	<!-- 글쓰기 버튼 -->
	<tr>
		<td align="right">
			<input type="button" value="글쓰기" onclick="location.href='insert.jsp'"/>
		</td> 
	</tr>
</table>





</body>
</html>