package com.sbs.example.demo.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DBConnection {
	private Connection connection;
	private String dbHost;
	private String dbName;
	private String dbUser;
	private String dbPassword;
	private int dbPort;

	public DBConnection(String dbHost, String dbName, String dbUser, String dbPassword, int dbPort) {
		super();
		this.dbHost = dbHost;
		this.dbName = dbName;
		this.dbUser = dbUser;
		this.dbPassword = dbPassword;
		this.dbPort = dbPort;
	}

	public void connect() {
		String url = "jdbc:mysql://" + dbHost + ":" + dbPort + "/" + dbName
				+ "?serverTimezone=Asia/Seoul&useOldAliasMetadataBehavior=true";
		String user = dbUser;
		String password = dbPassword;
		String driverName = "com.mysql.cj.jdbc.Driver";

		try {
			Class.forName(driverName);
			connection = DriverManager.getConnection(url, user, password);
		} catch (SQLException e) {
			System.err.printf("[SQL 예외, conn 열기] : %s\n", e.getMessage());
		} catch (ClassNotFoundException e) {
			System.err.printf("[드라이버 클래스 로딩 예외] : %s\n", e.getMessage());
		}
	}

	public int selectRowIntValue(String sql) {
		Map<String, Object> row = selectRow(sql);

		for (String key : row.keySet()) {
			return (int) row.get(key);
		}

		return -1;
	}

	public String selectRowStringValue(String sql) {
		Map<String, Object> row = selectRow(sql);

		for (String key : row.keySet()) {
			return (String) row.get(key);
		}

		return "";
	}

	public Boolean selectRowBooleanValue(String sql) {
		Map<String, Object> row = selectRow(sql);

		for (String key : row.keySet()) {
			if (row.get(key) instanceof String) {
				return ((String) row.get(key)).equals("1");
			} else if (row.get(key) instanceof Integer) {
				return ((int) row.get(key)) == 1;
			} else if (row.get(key) instanceof Boolean) {
				return ((boolean) row.get(key));
			}
		}

		return false;
	}

	public Map<String, Object> selectRow(String sql) {
		List<Map<String, Object>> rows = selectRows(sql);

		if (rows.size() == 0) {
			return new HashMap<String, Object>();
		}

		return rows.get(0);
	}

	public List<Map<String, Object>> selectRows(String sql) {
		List<Map<String, Object>> rows = new ArrayList<>();

		Statement stmt = null;
		ResultSet rs = null;

		try {
			stmt = connection.createStatement();
			rs = stmt.executeQuery(sql);
			ResultSetMetaData metaData = rs.getMetaData();
			int columnSize = metaData.getColumnCount();

			while (rs.next()) {
				Map<String, Object> row = new HashMap<>();

				for (int columnIndex = 0; columnIndex < columnSize; columnIndex++) {
					String columnName = metaData.getColumnName(columnIndex + 1);
					Object value = rs.getObject(columnName);

					if (value instanceof Long) {
						int numValue = (int) (long) value;
						row.put(columnName, numValue);
					} else if (value instanceof Timestamp) {
						String dateValue = value.toString();
						dateValue = dateValue.substring(0, dateValue.length() - 2);
						row.put(columnName, dateValue);
					} else {
						row.put(columnName, value);
					}
				}

				rows.add(row);
			}
		} catch (SQLException e) {
			System.err.printf("[SQL 예외, SQL : %s] : %s\n", sql, e.getMessage());
			e.printStackTrace();
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, stmt 닫기] : %s\n", e.getMessage());
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, rs 닫기] : %s\n", e.getMessage());
				}
			}
		}

		return rows;
	}

	public int delete(String sql) {
		int affectedRows = 0;

		Statement stmt = null;
		try {
			stmt = connection.createStatement();
			affectedRows = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			System.err.printf("[SQL 예외, SQL : %s] : %s\n", sql, e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, stmt 닫기] : %s\n", e.getMessage());
				}
			}
		}

		return affectedRows;
	}

	public int update(String sql) {
		int affectedRows = 0;

		Statement stmt = null;
		try {
			stmt = connection.createStatement();
			affectedRows = stmt.executeUpdate(sql);
		} catch (SQLException e) {
			System.err.printf("[SQL 예외, SQL : %s] : %s\n", sql, e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, stmt 닫기] : %s\n", e.getMessage());
				}
			}
		}

		return affectedRows;
	}

	public int insert(String sql) {
		int id = -1;

		Statement stmt = null;
		ResultSet rs = null;

		try {
			stmt = connection.createStatement();
			stmt.execute(sql, Statement.RETURN_GENERATED_KEYS);
			rs = stmt.getGeneratedKeys();

			if (rs.next()) {
				id = rs.getInt(1);
			}

		} catch (SQLException e) {
			System.err.printf("[SQL 예외, SQL : %s] : %s\n", sql, e.getMessage());
		} finally {
			if (stmt != null) {
				try {
					stmt.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, stmt 닫기] : %s\n", e.getMessage());
				}
			}

			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException e) {
					System.err.printf("[SQL 예외, rs 닫기] : %s\n", e.getMessage());
				}
			}
		}

		return id;
	}

	public void close() {
		if (connection != null) {
			try {
				connection.close();
			} catch (SQLException e) {
				System.err.printf("[SQL 예외, connection 닫기] : %s\n", e.getMessage());
			}
		}
	}
}