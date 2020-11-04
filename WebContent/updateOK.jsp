<%@page import="com.koreait.service.UpdateService"%>
<%@page import="com.koreait.service.SelectService"%>
<%@page import="com.koreait.vo.GuestbookVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<%
	request.setCharacterEncoding("UTF-8");
	// update.jsp에서 넘어오는 데이터를 받는다. => VO 클래스에 멤버로 존재하면 useBean으로 받고 나머지는 별도로 받는다.
	int currentPage = Integer.parseInt(request.getParameter("currentPage")); 
%>
<jsp:useBean id="vo" class="com.koreait.vo.GuestbookVO">
	<jsp:setProperty property="*" name="vo"/> 
</jsp:useBean>

<%
	// 수정할 글의 비밀번호와 수정하기 위해 입력한 비밀번호를 비교하기 위해 수정할 글을 테이블에서 얻어온다.
	GuestbookVO original = SelectService.getInstance().selectByIdx(vo.getIdx());

	// 수정할 글의 비밀번호와 수정하기 위해 입력한 비밀번호가 같으면 글을 수정한다.
	out.println("<script>");
	if (original.getPw().trim().equals(vo.getPw())) {
		//비밀번호가 일치하면
		
		UpdateService.getInstance().update(vo);
		
		out.println("alert('"+ vo.getIdx() + "번글 수정완료')");
		
	} else {
		//일치하지 않으면
		out.println("alert('비밀번호가 일치하지 않습니다.')");
		
	}
	out.println("location.href='list.jsp?currentPage=" + currentPage +"'" );
	out.println("</script>");
%>

</body>
</html>