package service.model;


import java.sql.SQLException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import main.model.FAQtableVO;
import main.model.NoticeVO;
import main.model.OneInquiryVO;
import main.model.OrderVO;

public interface InterServiceDAO {

	// 공지사항 테이블 조회
	List<NoticeVO> selectPagingMember(HashMap<String, String> paraMap) throws SQLException;

	// 공지사항 총 게시글 수 조회
	int getTotalPage(HashMap<String, String> paraMap) throws SQLException;


	// 자주하는 질문 테이블 조회
	List<FAQtableVO> selectFAQ(HashMap<String, String> paraMap) throws SQLException;

	// 자주하는 질문 총 게시글 수 조회
	int getTotalPageFAQ(HashMap<String, String> paraMap) throws SQLException;

	// 자주하는 질문 카테고리 조회
	List<Map<String, String>> getFAQcategory() throws SQLException;

	// 1:1문의 테이블 조회
	List<OneInquiryVO> selectOneInquiry(Map<String, Integer> paraMap) throws SQLException;

	// 공지사항, 자주하는 질문 게시글 추가
	int managerWrite(Map<String, String> paraMap) throws SQLException;

	// 수정 페이지로 갖고 갈 데이터 조회
	FAQtableVO selectOneFAQ(String faq_num) throws SQLException;

	// 자주하는 질문 게시판 특정 글 수정
	int FAQUpdate(Map<String, String> paraMap)throws SQLException;

	// 자주하는 질문 게시판 특정 글 삭제
	int FAQDelete(String faq_num)throws SQLException;

	// 공지사항 게시판 특정 글 상세보기
	List<NoticeVO> boardDetail(String notice_num)throws SQLException;

	// 공지사항 게시판 조회수 증가(일반회원이 공지사항 상세보기 기능 사용했을 경우)
	int boardHitUp(String notice_num)throws SQLException;

	// 공지사항 특정 글 수정페이지 이동
	NoticeVO selectOneNotice(String notice_num)throws SQLException;

	// 공지사항 특정 글 수정
	int boardUpdate(Map<String, String> paraMap)throws SQLException;

	// 공지사항 특정 글 삭제
	int boardDelete(String notice_num)throws SQLException;


}
