package dao;

import java.util.*;
import java.sql.*;
import util.DBUtil;

public class TeacherDao {
	/* teacherList 출력 메소드 */
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
	
	
	/* teacherCnt 출력 메소드 */
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
	
	
	/* teacherOne 출력 메소드 */
	
	
	
	
}