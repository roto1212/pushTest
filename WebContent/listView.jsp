<%@page import="java.text.Format"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.koreait.vo.GuestbookVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.koreait.vo.GuestbookList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>방명록 보기</title>
<style type="text/css">
/* table:nth-child(even) {
	background-color: gray;
} */
</style>
</head>
<body>
	
<%-- ${guestbookList} --%>
<%
	request.setCharacterEncoding("UTF-8");
//	list.jsp에서 1페이지 분량의 글 목록과 페이지 작업에 사용할 8개의 변수를 초기화 시켜	request영역에 저장한 GuestbookList 클래스 객체를 받는다. =>request 영역에 저장된 데이터는 Object 타입이므로 반드시 얻어온 다음에 형변환을 시켜야 한다.
	GuestbookList guestbookList = (GuestbookList) request.getAttribute("guestbookList");
//	out.println(guestbookList);
//	out.println(guestbookList.getList());

//	브라우저에 출력할 1페이지 분량의 글목록(guestbookList.getList())만 꺼내서 별도로 배열목록에 저장시켜 사용한다.
	ArrayList<GuestbookVO> view = guestbookList.getList();
//	for (GuestbookVO vo : view) {
//		out.println(vo + "<br/>");
//	}
	
	
%>

<table width="1000" align="center" border="1" cellpadding="5" cellspacing="0">
	<tr>
		<th>방명록 보기 </th>
	</tr>
	<tr>
		<td align="right">
			<%= guestbookList.getTotalCount()%>개( <%=guestbookList.getCurrentPage()%> / <%=guestbookList.getTotalPage()%> )Page
		</td>
	</tr>
	<tr>
		<td >
		<%
			if (view.size() == 0) {
				out.println("테이블에 저장된 글이 없습니다.<br/>" );
			} else {
//				컴퓨터 시스템의 현재 날짜와 시간을 얻어온다. 
				Date date = new Date();
//				날짜 데이터에 적용할 서식을 만든다. 
				SimpleDateFormat sdf1 = new SimpleDateFormat("HH:mm");
				SimpleDateFormat sdf2 = new SimpleDateFormat("yyyy.MM.dd(E)");
			
				for (GuestbookVO vo: view) {
		%>
			<table width="99%" align="center" border="1" cellpadding="5" cellspacing="0" 
			<%
				if(vo.getIdx() % 2 == 0) {
					out.println("bgcolor='skyblue'");
				} else {
					out.println("bgcolor='cyan'");
					
				}
			%>
			>
				<tr>
					<td>
					<!-- 인덱스번호, 이름(태그안먹게 replace) -->
						<%=vo.getIdx()%>. <%=vo.getName().replace("<", "&lt").replace(">", "&gt")%>님(<%=vo.getIp()%>)이 
					<!-- 오늘 입력한 글은 시간만 나오게 하고 오늘 이전에 입력한 글은 날짜만 나오게 한다. -->
						<%
						if (date.getYear() == vo.getWriteDate().getYear()  &&
						date.getMonth() == vo.getWriteDate().getMonth() &&
						date.getDate() == vo.getWriteDate().getDate()) {
							out.println(sdf1.format(vo.getWriteDate()));
						} else {
							out.println(sdf2.format(vo.getWriteDate()));
						}
						%>
						에 남긴글 <br/> 
					<!-- 메모 출력(태그안먹게, 엔터 먹히게 replace) -->
						<%=vo.getMemo().replace("<", "&lt").replace(">", "&gt").replace("\r\n", "<br/>")%>
					</td>
				</tr>
			</table>		
		<%
				}
			}
		%>
		</td>
	</tr>
	
	<!-- 페이지 이동 버튼 -->
	<tr> 
		<td align="center">
		
		<%
		int currentPage = guestbookList.getCurrentPage();
		int startPage = guestbookList.getStartPage();
		int endPage = guestbookList.getEndPage() ;
		int totalPage = guestbookList.getTotalPage();
		
		if (currentPage > 1) {
		%>
			<input type="button" class="button button2" value="맨앞" onclick="location.href='?currentPage=1'" title="첫 페이지로 이동하기"/>
		<% 
	    } else {
	    %>
			<input type="button" class="button button3" value="맨앞" disabled="disabled" onclick="location.href='?currentPage=1'" title="첫 페이지 입니다."/>
		<%
	    }
		if (startPage > 1) {
		%>
			<input type="button" class="button button2" value="이전" onclick="location.href='?currentPage=<%=startPage -1 %>'" title="이전 페이지 목록으로 이동하기"/>
		<%
		} else {
		%>
			<input type="button" class="button button3" value="이전" disabled="disabled" title="이미 첫 페이지 목록 입니다."/>
		<%
		}
		
		
		for (int i = startPage; i <= endPage; i++ ){
			if (currentPage == i) {
		%>		
				<input type="button" class="button button1" value="<%=i %>" disabled="disabled">
		<%
			} else {
		%>
				<input type="button" class="button button2" value="<%=i %>" onclick="location.href='?currentPage=<%=i %>'" >
		<% 
			}
		}
//		10페이지 뒤로
		if (endPage < totalPage) {
		%>
		
			<input type="button" class="button button2" value="다음" onclick="location.href='?currentPage=<%=endPage + 1 %>'" title="다음 페이지 목록으로 이동하기"/>
		<%
		} else {
		%>
			<input type="button" class="button button3" value="다음" disabled="disabled" title="이미 마지막 페이지 목록 입니다."/>
		<%
		}
//		마지막 페이지로
	    if (currentPage < totalPage) {
		%>
			<input type="button" class="button button2" value="맨뒤" onclick="location.href='?currentPage=<%=totalPage%>'" title="마지막 페이지로 이동하기"/>
		<% 
	    } else {
	    	%>
			<input type="button" class="button button3" value="맨뒤" disabled="disabled"  title="이미 마지막 페이지 입니다."/>
			<%
	    }
		%>
			
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