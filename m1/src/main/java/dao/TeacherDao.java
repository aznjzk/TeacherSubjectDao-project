package dao;

import vo.*;
import java.sql.*;
import java.util.*;
import util.DBUtil;

public class TeacherDao {
	/* teacherList 강사 리스트 */
	// 교과목이 연결되지 않은 강사도 출력되도록
	public ArrayList<HashMap<String, Object>> selectTeacherListByPage(int beginRow, int rowPerPage) throws Exception {
		ArrayList<HashMap<String, Object>> teacherList = new ArrayList<>();
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		PreparedStatement teacherStmt = null;
		ResultSet teacherRs = null;
		
		String teacherSql = "SELECT t.teacher_no teacherNo, t.teacher_id teacherId, t.teacher_name teacherName,\r\n"
						  + "		GROUP_CONCAT(s.subject_name) subjectName\r\n"
						  + "FROM teacher t LEFT OUTER JOIN teacher_subject ts\r\n"
						  + "						ON t.teacher_no = ts.teacher_no\r\n"
						  + " 					LEFT OUTER join subject s\r\n"
						  + " 							ON ts.subject_no = s.subject_no\r\n"
						  + "GROUP BY t.teacher_no, t.teacher_id, t.teacher_name\r\n"
						  + "LIMIT ?, ?";
		teacherStmt = conn.prepareStatement(teacherSql);
		teacherStmt.setInt(1, beginRow);
		teacherStmt.setInt(2, rowPerPage);
		// 쿼리 실행 및 결과 처리
		teacherRs = teacherStmt.executeQuery();
		while(teacherRs.next()) {
			HashMap<String, Object> teacher = new HashMap<String, Object>();
				teacher.put("teacherNo", teacherRs.getInt("teacherNo"));
				teacher.put("teacherId", teacherRs.getString("teacherId"));
				teacher.put("teacherName", teacherRs.getString("teacherName"));
				teacher.put("subjectName", teacherRs.getString("subjectName"));
				teacherList.add(teacher);
		}
		return teacherList;
	}
	
	
	/* teacherCnt 전체 강사의 수 */
	public int selectTeacherCnt () throws Exception {
		int tRow = 0;
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		String tSql = "SELECT COUNT(*) FROM teacher";
		PreparedStatement tStmt = conn.prepareStatement(tSql);
		ResultSet tRs = tStmt.executeQuery();
		if(tRs.next()) {
			tRow = tRs.getInt("COUNT(*)");
		}
		return tRow;
	}
	
	
	/* teacherOne 강사 한 명의 상세정보 */
	public Teacher selectTeacherOne(int teacherNo) throws Exception {	// teacherNo를 매개변수로 받아 해당 강사의 정보를 가져오는 메서드
	    Teacher teacher = null;
	    DBUtil dbUtil = new DBUtil(); // DBUtil 객체 생성
	    
	    // 데이터베이스 연결을 위한 Connection 객체 생성
	    Connection conn = dbUtil.getConnection();
	    // SQL 문을 준비하기 위해 PreparedStatement 객체 생성
	    PreparedStatement stmt = conn.prepareStatement("SELECT teacher_no teacherNo, teacher_id teacherId, teacher_name teacherName, teacher_history teacherHistory, updatedate, createdate FROM teacher WHERE teacher_no = ?");
	    // ? 1개
	    stmt.setInt(1, teacherNo); // SQL 문의 첫 번째 매개변수에 teacherNo 설정
	    
	    // 쿼리 실행 후 결과를 받기 위해 ResultSet 객체 생성
	    ResultSet rs = stmt.executeQuery();
	    if (rs.next()) { // 결과가 존재하는 경우
	        teacher = new Teacher(); // Teacher 객체 생성
	        
	        // ResultSet에서 강사의 정보를 가져와 Teacher 객체의 속성에 설정
	        teacher.setTeacherNo(rs.getInt("teacherNo"));
	        teacher.setTeacherId(rs.getString("teacherId"));
	        teacher.setTeacherName(rs.getString("teacherName"));
	        teacher.setTeacherHistory(rs.getString("teacherHistory"));
	        teacher.setUpdatedate(rs.getString("updatedate"));
	        teacher.setCreatedate(rs.getString("createdate"));
	    }
	    
	    return teacher; // 강사 객체 반환
		
	}
	
	/* modifyTeacher 강사 정보 수정 액션 */
	public int modifyTeacher(Teacher teacher) throws Exception {
		// sql 실행 시 영향받은 행의 수 
		int tmRow = 0;
		// db 접속
		DBUtil dbUtil = new DBUtil();
		Connection conn = dbUtil.getConnection();
		// sql 전송 후 영향받은 행의 수 반환받아 저장
		PreparedStatement tmStmt = conn.prepareStatement("UPDATE teacher SET teacher_id = ?, teacher_name = ?, teacher_history = ?, updatedate = NOW() WHERE teacher_no = ?");
		tmStmt.setString(1, teacher.getTeacherId());
		tmStmt.setString(2, teacher.getTeacherName());
		tmStmt.setString(3, teacher.getTeacherHistory());
		tmStmt.setInt(4, teacher.getTeacherNo());
		tmRow = tmStmt.executeUpdate();
		
		return tmRow;
	}
	
	
	
	
	/* removeTeacher 강사 정보 삭제 */
	
}