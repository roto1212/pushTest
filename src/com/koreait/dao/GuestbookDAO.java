package com.koreait.dao;

import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;

import com.ibatis.sqlmap.client.SqlMapClient;
import com.koreait.vo.GuestbookVO;
import com.koreait.vo.Param;

public class GuestbookDAO {
	
	private static GuestbookDAO instance = new GuestbookDAO();
	private GuestbookDAO() {}
	public static GuestbookDAO getInstance() { return instance;	}
	
//	insertService 클래스에서 mapper와  저장할 데이터가 저장된 객체를 넘겨받고 guestbook.xml 파일의 insert.sql명령을 실행하는 메소드
	public void insert(SqlMapClient mapper, GuestbookVO vo) throws SQLException {
		System.out.println("guestbookDAO 클래스 insert() 메소드 실행");
//		System.out.println(vo);
		
//		insert("실행할 sql 명령의 id"[, sql명령으로 전달할 데이터])
		mapper.insert("insert", vo );// throws: 예외미루기, 메서드를 호출한쪽으로 미룬다. 
	}
//	SelectService 클래스에서 mapper를 넘겨받고 테이블에 저장된 전체 글의 개수를 얻어오는 guestbook.xml 파일의 select sql명령을 실행하는 메소드
	public int selectCount(SqlMapClient mapper) throws SQLException {
		System.out.println("guestbookDAO 클래스 selectCount() 메소드 실행");
//		queryForObject(): select sql명령의 실행결과가 1건일 경우 사용한다.=> 얻어온 데이터의 타입이 Object이다.
//		queryForList(): select sql명령의 실행결과가  여러 건일 경우 사용한다.=> 얻어온 데이터의 타입이 List이다.
//		queryForObject(), queryForList() 메소드가 실행되서 얻어온 데이터의 타입과 현재 메소드의 리턴타입이 달라서 에러가 발생되므로 반드시 메소드의 타입으로 형변환시켜야 한다.
		
		return (int) mapper.queryForObject("selectCount") ;
	}
//	SelectService 클래스에서 mapper와 1페이지 분량의 글의 시작 인덱스와 끝 인덱스가 저장된 HashMap 객체를 넘겨받고 테이블에 저장된 전체 글 중에서 1페이지 분량의 글을 얻어오는 guestbook.xml 파일의 select sql명령을 실행하는 메소드
	public ArrayList<GuestbookVO> selectList(SqlMapClient mapper, HashMap<String, Integer> hmap) throws SQLException{
		System.out.println("guestbookDAO 클래스 selectList() 메소드 실행");
		return (ArrayList<GuestbookVO>) mapper.queryForList("selectList", hmap);
	}
//	SelectService 클래스에서 mapper와 검색어(memo의 item)을 넘겨받고 테이블에 저장된 전체 중에서 검색어를 포함하는 글의 개수를 얻어오는 guestbook.xml 파일의 select sql명령을 실행하는 메소드
	public int selectCountMemo(SqlMapClient mapper, String item) throws SQLException {
		System.out.println("guestbookDAO 클래스 selectCountMemo() 메소드 실행");
		return (int) mapper.queryForObject("selectCountMemo", item);
	}
	public ArrayList<GuestbookVO> selectListMemo(SqlMapClient mapper, Param param) throws SQLException {
//		SelectService 클래스에서 mapper와 1페이지 분량의 글의 시작 인덱스와 끝 인덱스, 검색어(내용)가 저장된 Param 객체를 넘겨받고 테이블에 저장된 전체 글 중에서 검색어를 포함하는 1페이지 분량의 글을 얻어오는 guestbook.xml 파일의 select sql명령을 실행하는 메소드
		System.out.println("guestbookDAO 클래스 selectListMemo() 메소드 실행");
		return (ArrayList<GuestbookVO>) mapper.queryForList("selectListMemo", param);
	}
//	SelectService 클래스에서 mapper와 검색어(name의 item)을 넘겨받고 테이블에 저장된 전체 중에서 검색어를 포함하는 글의 개수를 얻어오는 guestbook.xml 파일의 select sql명령을 실행하는 메소드
	public int selectCountName(SqlMapClient mapper, String item) throws SQLException {
		System.out.println("guestbookDAO 클래스 selectCountName() 메소드 실행");
		return (int) mapper.queryForObject("selectCountName", item);
	}
//	SelectService 클래스에서 mapper와 1페이지 분량의 글의 시작 인덱스와 끝 인덱스, 검색어(이름)가 저장된 Param 객체를 넘겨받고 테이블에 저장된 전체 글 중에서 검색어를 포함하는 1페이지 분량의 글을 얻어오는 guestbook.xml 파일의 select sql명령을 실행하는 메소드
	public ArrayList<GuestbookVO> selectListName(SqlMapClient mapper, Param param) throws SQLException {
		System.out.println("guestbookDAO 클래스 selectListName() 메소드 실행");
		
		return (ArrayList<GuestbookVO>) mapper.queryForList("selectListName", param);
	}
	public int selectCountMemoName(SqlMapClient mapper, String item) throws SQLException {
		System.out.println("guestbookDAO 클래스 selectCountMemoName() 메소드 실행");
		
		return (int) mapper.queryForObject("selectCountMemoName", item);
	}
	public ArrayList<GuestbookVO> selectListMemoName(SqlMapClient mapper, Param param) throws SQLException {
		System.out.println("guestbookDAO 클래스 selectListMemoName() 메소드 실행");
		return (ArrayList<GuestbookVO>) mapper.queryForList("selectListMemoName", param);
	}
//	SelectService 클래스에서 mapper와 카테고리, 검색어가 저장된 객체를 넘겨 받고 테이블에 저장된 전체 글 중에서 검색어를 포함하는 글의 개수를 얻어오는 guestbook.xml 파일의 select sql명령을 실행하는 메소드
	public int selectCountMulti(SqlMapClient mapper, Param param) throws SQLException {
		System.out.println("guestbookDAO 클래스 selectCountMulti() 메소드 실행");
		
		return (int) mapper.queryForObject("selectCountMulti", param);
	}
//	SelectService 클래스에서 mapper와 1페이지 분량의 글의 시작 인덱스와 끝 인덱스, 검색어(이름)가 저장된 Param 객체를 넘겨받고 테이블에 저장된 전체 글 중에서 검색어를 포함하는 1페이지 분량의 글을 얻어오는 guestbook.xml 파일의 select sql명령을 실행하는 메소드
	public ArrayList<GuestbookVO> selectListMulti(SqlMapClient mapper, Param param) throws SQLException {
		System.out.println("guestbookDAO 클래스 selectListMulti() 메소드 실행");
		
		return (ArrayList<GuestbookVO>) mapper.queryForList("selectListMulti", param);
	}
	
//	SelectService 클래스에서 mapper와 수정 또는 삭제할 글번호를 넘겨받고 테이블에 저장된 글 1건을 얻어오는 guestbook.xml 파일의 select sql명령을 실행하는 메소드
	public GuestbookVO selectByIdx(SqlMapClient mapper, int idx) throws SQLException {
		System.out.println("guestbookDAO 클래스 selectByIdx() 메소드 실행");
		return (GuestbookVO) mapper.queryForObject("selectByIdx", idx);
	}
//	DeleteService 클래스에서 mapper와 삭제할 글번호를 넘겨받고 테이블에 저장된 글 1건을 삭제하는 guest.xml 파일의 delete sql 명령을 실행하는 메소드
	public void delete(SqlMapClient mapper, int idx) throws SQLException {
		System.out.println("guestbookDAO 클래스 delete() 메소드 실행");
		mapper.update("delete", idx);
		
	}
//	UpdateService 클래스에서 mapper와 수정가 저장된 객체를 넘겨받고 테이블에 저장된 글 1건을 수정하는 guest.xml 파일의 update sql 명령을 실행하는 메소드
	public void update(SqlMapClient mapper, GuestbookVO vo) throws SQLException {
		System.out.println("guestbookDAO 클래스 update() 메소드 실행");
		mapper.update("update", vo);
	}
}
