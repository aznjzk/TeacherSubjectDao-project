package dao;

import java.sql.*;
import java.util.*;
import vo.*;
import util.DBUtil;

public class SubjectDao {
	// 1) 과목목록
	public ArrayList<Subject> selectSubjectListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<Subject> list = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt1 = null;
		ResultSet rs1 = null;
		// SQL 쿼리 준비
		String sql1 = "SELECT subject_no subjectNo, subject_name subjectName, subject_time subjectTime FROM subject LIMIT ?, ?";
		stmt1 = conn.prepareStatement(sql1);
		stmt1.setInt(1, beginRow);
		stmt1.setInt(2, rowPerPage);
		
		// 쿼리 실행 및 결과 처리
		rs1 = stmt1.executeQuery();
		while (rs1.next()) {
        	// Subject 객체 생성 및 정보 설정
        	Subject subject = new Subject();
			// ResultSet에서 과목 정보 추출
			subject.setSubjectNo(rs1.getInt("subjectNo"));
			subject.setSubjectName(rs1.getString("subjectName"));
			subject.setSubjectTime(rs1.getInt("subjectTime"));

		// 과목 객체를 리스트에 추가
		list.add(subject);
		}
	return list;
	}
	
	
	// 2) 과목추가
	public int insertSubject(Subject subject) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// PreparedStatement
		return row;
	}
	
	
	// 3) 과목삭제
	public int deleteSubject(int subjectNo) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// PreparedStatement
		return row;
	}
	
	
	// 4) 과목수정
	public int updateSubject(Subject subject) throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// PreparedStatement
		return row; 
	}
	
	
	// 5) 과목 하나 상세
	public Subject selectSubjectOne(int subjectNo) throws Exception {
		Subject subject = null;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement stmt5 = null;
		ResultSet rs5 = null;
		String sql5 = "SELECT subject_no subjectNo, subject_name subjectName, subject_time subjectTime, updatedate, createdate FROM subject WHERE subject_no = ?";
		stmt5 = conn.prepareStatement(sql5);
		stmt5.setInt(1, subjectNo);

		rs5 = stmt5.executeQuery();
		
		if(rs5.next()) {
	        // Subject 객체 생성 및 정보 설정
	        subject = new Subject();
	        // ResultSet에서 과목 정보 추출
	        subject.setSubjectNo(rs5.getInt("subjectNo"));
	        subject.setSubjectName(rs5.getString("subjectName"));
	        subject.setSubjectTime(rs5.getInt("subjectTime"));
	        subject.setCreatedate(rs5.getString("Createdate"));
	        subject.setUpdatedate(rs5.getString("Updatedate"));
        }
		return subject;
	}
		
	
	// 6) 과목전체row
	public int selectSubjectCnt() throws Exception {
		int row = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// PreparedStatement
		// ResultSet
		return row;
	}
}