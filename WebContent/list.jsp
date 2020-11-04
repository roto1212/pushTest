<%@page import="com.koreait.service.SelectService"%>
<%@page import="com.koreait.vo.GuestbookList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

<!--  
	currentPage를 넘겨받아 currentPage에 해당되는 1페이지 분량의 글 목록을 테이블에서 얻어와서 request 영역에 저장한 후 1페이지 분량의 글을 브라우저 화면에 표시하는 페이지(listView.jsp)로 넘겨준다.
-->
<%
	request.setCharacterEncoding("UTF-8");
//	이전 페이지에서 넘어오는 화면에 표시할 페이지 번호(currentPage)를 받는다.
	
// 	게시판이 최초로 실행될 때, insertOK.jsp에서 list.jsp가 호출될 때는 currentPage가 넘어오지 않는다. => null이다.
//	null은 parseInt() 메소드를 실행했을 때 NumberFormatException이 발생되므로 예외 처리를 해야 한다.
//  이전 페이지에서 넘어오는 currentPage가 없으면 1로 초기화 시켜서 사용하고 넘어오는 currentPage가 있으면 넘어온 currentPage 값으로 초기화 시켜서 사용한다.
	int currentPage = 1;
    try {
		currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
	} catch (NumberFormatException e) {	}
//	카테고리와 검색어를 받는다.
    String category = request.getParameter("category");
    String item = request.getParameter("item");
    
//	넘어온 검색어가 있으면 카테고리와 검색어를 세션에 저장하고 검색어가 없으면 세션에 저장된 카테고리와 검색어를 읽어온다.
	if (item != null ) {
		session.setAttribute("category", category);
		item = item.trim().length() == 0 ? "" : item;//검색어에 공백을 입력햇을 경우 ""처럼 데이터가 없는 처리를 한다. 이처리를 안하면 공백은 모든 데이터에 있으므로 모든 데이터가 검색결과로 나온다.
		session.setAttribute("item", item);
	} else {
		category = (String) session.getAttribute("category");
		item = (String) session.getAttribute("item");
	}
	
//	1페이지 분량의 글목록과 페이지 작업에 사용할 8개의 변수가 초기화 된 객체를 request 영역에 저장한다.
	GuestbookList guestbookList = null;
	/*
	if (item == null || item.trim().length() == 0) {
		//검색어가 입력되지 않은 경우
		guestbookList = SelectService.getInstance().selectList(currentPage);
		
	} else if (category.trim().equals("내용")) {
		// 검색어가 입력되고 카테고리가 "내용"인 경우
		guestbookList = SelectService.getInstance().selectListMemo(currentPage, item);
	} else if (category.trim().equals("이름")) {
		// 검색어가 입력되고 카테고리가 "이름"인 경우
		guestbookList = SelectService.getInstance().selectListName(currentPage, item);
	} else if (category.trim().equals("내용 + 이름")) {
		// 검색어가 입력되고 카테고리가 "내용 + 이름"인 경우
		guestbookList = SelectService.getInstance().selectListMemoName(currentPage, item);
	}
	*/
	if (item == null || item.trim().length() == 0) {
		//검색어가 입력되지 않은 경우
		guestbookList = SelectService.getInstance().selectList(currentPage);
		
	} else  {
		// 검색어가 입력된 경우
		guestbookList = SelectService.getInstance().selectListMulti(currentPage, category, item);
	}
	
//	GuestbookList guestbookList = SelectService.getInstance().selectList(currentPage);

	request.setAttribute("guestbookList", guestbookList);

// 글을 입력할 때 엔터키를 눌러 줄을 바꿔서 입력한 경우 브라우저에 <br/> 태그로 바꿔 출력하기 위해 request 영역에 \r\n를 저장한다. jstl에서 사용한다.
	request.setAttribute("enter", "\r\n");

//	request영역에 저장된 데이터를 가지고 브라우저에 글을 출력하는 페이지(listView.jsp)로 넘겨준다.
	pageContext.forward("listView2.jsp");
	
	
%>


</body>
</html>