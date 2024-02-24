package dao;

import dao.DBConnection;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import model.User;

public class UserDAO {

    private Connection connection;
    private Statement statement;
    private ResultSet rs;
    public List<Map<String, Object>> getList() {
		String sql = "select * from Users" ;
		List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
		try {
			connection = DBConnection.getConnection();
			statement = connection.createStatement();
			rs = statement.executeQuery(sql);
			ResultSetMetaData md = rs.getMetaData(); 
			int columnCount = md.getColumnCount(); 
			while (rs.next()) {
				Map<String, Object> rowData = new HashMap<String, Object>();
				for (int i = 1; i <= columnCount; i++) {
					rowData.put(md.getColumnName(i), rs.getObject(i));
				}
				list.add(rowData);

			}
			connection.close();
		} catch (SQLException e) {
			try {
				connection.close();
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		
		return list;
    }
    
    public static void main(String[] args) {
		UserDAO uDAO = new UserDAO();
		List<Map<String, Object>> list = uDAO.getList();
		for(Map<String, Object> obj: list) {
			System.out.println(obj.get("id") + obj.toString());
		}
	}
}
