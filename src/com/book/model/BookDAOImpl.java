package com.book.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Optional;

import javax.sql.DataSource;

public class BookDAOImpl implements BookDAO {
	private DataSource ds;

	public BookDAOImpl(DataSource dataSource) {
		this.ds = dataSource;
	}

	private static final String INSERT_STMT = "INSERT INTO BOOKS(BOOK_ID,PUBLISHER_ID,LANGUAGE_ID,CATEGORY_ID,BOOK_NAME,ISBN,AUTHOR,LIST_PRICE,SALE_PRICE,BOOK_BP,IS_SOLD,PUBLICATION_DATE,STOCK,SAFETY_STOCK,BOOK_INTRO,BOOK_NAME_ORIGINAL) VALUES ('B' || lpad(BOOK_ID_SEQ.NEXTVAL, 11, '0'),?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
	private static final String FIND_BY_BOOK_ID_STMT = "SELECT * FROM BOOKS WHERE BOOK_ID = ?";
	private static final List<String> ADV_SEARCH_CONDITIONS = Arrays.asList("publisherName", "bookName", "author",
			"categoryID", "publicationDateMin", "publicationDateMax", "salePriceMin", "salePriceMax", "discountMin",
			"discountMax", "isbn", "isSold");
	private static final String ADV_SEARCH_STMT = "SELECT * FROM BOOKS B WHERE (? IS NULL OR EXISTS (SELECT 1 FROM PUBLISHERS P WHERE P.PUBLISHER_ID = B. PUBLISHER_ID AND upper(PUBLISHER_NAME) LIKE '%'|| upper(?) || '%'))"
			+ "AND (? IS NULL OR upper(BOOK_NAME) LIKE '%'|| upper(?) || '%')"
			+ "AND (? IS NULL OR upper(AUTHOR) LIKE '%'|| upper(?) || '%')" 
			+ "AND (? IS NULL OR CATEGORY_ID = ?)"
			+ "AND (? IS NULL OR PUBLICATION_DATE >= to_date(?, 'yyyy-mm-dd'))"
			+ "AND (? IS NULL OR PUBLICATION_DATE <= to_date(?, 'yyyy-mm-dd'))"
			+ "AND (? IS NULL OR LEAST(SALE_PRICE, NVL(SALE_PRICE_PROMO,SALE_PRICE)) >= ?)"
			+ "AND (? IS NULL OR LEAST(SALE_PRICE, NVL(SALE_PRICE_PROMO,SALE_PRICE)) <= ?)"
			+ "AND (? IS NULL OR LEAST(SALE_PRICE, NVL(SALE_PRICE_PROMO,SALE_PRICE))/SALE_PRICE*100 >= ?)"
			+ "AND (? IS NULL OR LEAST(SALE_PRICE, NVL(SALE_PRICE_PROMO,SALE_PRICE))/SALE_PRICE*100 <= ?)"
			+ "AND (? IS NULL OR ISBN = ?)" + "AND (? IS NULL OR IS_SOLD = ?)";
	private static final String UPDATE_STMT = "UPDATE BOOKS SET PUBLISHER_ID = ?, LANGUAGE_ID = ?, CATEGORY_ID = ?, BOOK_NAME = ?, ISBN = ?, AUTHOR = ?, LIST_PRICE = ?, SALE_PRICE = ?, BOOK_BP = ?, IS_SOLD = ?, PUBLICATION_DATE = ?, STOCK = ?, SAFETY_STOCK = ?, BOOK_INTRO = ?, BOOK_NAME_ORIGINAL = ? WHERE BOOK_ID = ?";
	private static final String UPDATE_SALE_PRICE_PROMO_STMT = "UPDATE BOOKS SET SALE_PRICE_PROMO = ? WHERE BOOK_ID = ?";
	private static final String UPDATE_BOOK_BP_PROMO_STMT = "UPDATE BOOKS SET BOOK_BP_PROMO = ? WHERE BOOK_ID = ?";
	private static final String UPDATE_IS_SOLD_STMT = "UPDATE BOOKS SET IS_SOLD = ? WHERE BOOK_ID = ?";
	private static final String UPDATE_EFFECTIVE_PROMOS = "UPDATE BOOKS SET EFFECTIVE_PROMOS = ?　WHERE BOOK_ID = ?";
	private static final String UPDATE_BATCH_STMT = "UPDATE BOOKS SET PUBLISHER_ID = ?, LANGUAGE_ID = ?, CATEGORY_ID = ?, BOOK_NAME = ?, ISBN = ?, AUTHOR = ?, LIST_PRICE = ?, SALE_PRICE = ?, BOOK_BP = ?, IS_SOLD = ?, PUBLICATION_DATE = ?, STOCK = ?, SAFETY_STOCK = ?, BOOK_INTRO = ?, BOOK_NAME_ORIGINAL = ?, SALE_PRICE_PROMO = ?, BOOK_BP_PROMO = ?, EFFECTIVE_PROMOS = ? WHERE BOOK_ID = ?";

	@Override
	public void insert(Book book) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(INSERT_STMT);

			pstmt.setString(1, book.getPublisherID());
			pstmt.setString(2, book.getLanguageID());
			pstmt.setString(3, book.getCategoryID());
			pstmt.setString(4, book.getBookName());
			pstmt.setString(5, book.getIsbn());
			pstmt.setString(6, book.getAuthor());
			pstmt.setDouble(7, book.getListPrice());
			pstmt.setDouble(8, book.getSalePrice());
			pstmt.setDouble(9, book.getBookBP());
			pstmt.setInt(10, book.getIsSold());
			pstmt.setDate(11, book.getPublicationDate());
			pstmt.setInt(12, book.getStock());
			pstmt.setInt(13, book.getSafetyStock());
			pstmt.setString(14, book.getBookIntro());
			pstmt.setString(15, book.getBookNameOriginal());

			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public Optional<Book> findByBookID(String bookID) {
		Book book = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_BOOK_ID_STMT);
			pstmt.setString(1, bookID);

			rs = pstmt.executeQuery();
			while (rs.next()) {
				book = new Book();
				book.setBookID(rs.getString("BOOK_ID"));
				book.setPublisherID(rs.getString("PUBLISHER_ID"));
				book.setLanguageID(rs.getString("LANGUAGE_ID"));
				book.setCategoryID(rs.getString("CATEGORY_ID"));
				book.setBookName(rs.getString("BOOK_NAME"));
				book.setIsbn(rs.getString("ISBN"));
				book.setAuthor(rs.getString("AUTHOR"));
				book.setListPrice(rs.getDouble("LIST_PRICE"));
				book.setSalePrice(rs.getDouble("SALE_PRICE"));
				book.setBookBP(rs.getDouble("BOOK_BP"));
				book.setIsSold(rs.getInt("IS_SOLD"));
				book.setPublicationDate(rs.getDate("PUBLICATION_DATE"));
				book.setStock(rs.getInt("STOCK"));
				book.setSafetyStock(rs.getInt("SAFETY_STOCK"));
				book.setBookIntro(rs.getString("BOOK_INTRO"));
				book.setBookNameOriginal(rs.getString("BOOK_NAME_ORIGINAL"));
				if (rs.getObject("SALE_PRICE_PROMO") == null) {
					book.setSalePricePromo(Double.NaN);
				} else {
					book.setSalePricePromo(rs.getDouble("SALE_PRICE_PROMO"));
				}
				if (rs.getObject("BOOK_BP_PROMO") == null) {
					book.setBookBPPromo(Double.NaN);
				} else {
					book.setBookBPPromo(rs.getDouble("BOOK_BP_PROMO"));
				}
				book.setEffectivePromos(rs.getString("EFFECTIVE_PROMOS"));

			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return Optional.ofNullable(book);
	}

	@Override
	public List<Book> findByISBN(String isbn) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("isbn", isbn);
		List<Book> listBook = advSearch(map);
		return listBook;
	}

	@Override
	public List<Book> findByBookName(String bookName) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("bookName", bookName);
		List<Book> listBook = advSearch(map);
		return listBook;
	}

	@Override
	public List<Book> findByAuthor(String author) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("author", author);
		List<Book> listBook = advSearch(map);
		return listBook;
	}

	@Override
	public List<Book> findByPublisherName(String publisherName) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("publisherName", publisherName);
		List<Book> listBook = advSearch(map);
		return listBook;
	}

	@Override
	public List<Book> findByCategoryID(String categoryID) {
		Map<String, String> map = new HashMap<String, String>();
		map.put("categoryID", categoryID);
		List<Book> listBook = advSearch(map);
		return listBook;
	}

	@Override
	public List<Book> advSearch(Map<String, String> map) {
		List<Book> listBook = new ArrayList<Book>();
		Book book = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String[] conditions = new String[ADV_SEARCH_CONDITIONS.size()];

		for (int i = 0; i < conditions.length; i++) {
			conditions[i] = map.get(ADV_SEARCH_CONDITIONS.get(i));
		}

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(ADV_SEARCH_STMT);

			for (int i = 1; i < conditions.length * 2 + 1; i += 2) {
				pstmt.setString(i, conditions[i / 2]);
				pstmt.setString(i + 1, conditions[i / 2]);
			}

			rs = pstmt.executeQuery();

			while (rs.next()) {
				book = new Book();
				book.setBookID(rs.getString("BOOK_ID"));
				book.setPublisherID(rs.getString("PUBLISHER_ID"));
				book.setLanguageID(rs.getString("LANGUAGE_ID"));
				book.setCategoryID(rs.getString("CATEGORY_ID"));
				book.setBookName(rs.getString("BOOK_NAME"));
				book.setIsbn(rs.getString("ISBN"));
				book.setAuthor(rs.getString("AUTHOR"));
				book.setListPrice(rs.getDouble("LIST_PRICE"));
				book.setSalePrice(rs.getDouble("SALE_PRICE"));
				book.setBookBP(rs.getDouble("BOOK_BP"));
				book.setIsSold(rs.getInt("IS_SOLD"));
				book.setPublicationDate(rs.getDate("PUBLICATION_DATE"));
				book.setStock(rs.getInt("STOCK"));
				book.setSafetyStock(rs.getInt("SAFETY_STOCK"));
				book.setBookIntro(rs.getString("BOOK_INTRO"));
				book.setBookNameOriginal(rs.getString("BOOK_NAME_ORIGINAL"));
				if (rs.getObject("SALE_PRICE_PROMO") == null) {
					book.setSalePricePromo(Double.NaN);
				} else {
					book.setSalePricePromo(rs.getDouble("SALE_PRICE_PROMO"));
				}
				if (rs.getObject("BOOK_BP_PROMO") == null) {
					book.setBookBPPromo(Double.NaN);
				} else {
					book.setBookBPPromo(rs.getDouble("BOOK_BP_PROMO"));
				}
				book.setEffectivePromos(rs.getString("EFFECTIVE_PROMOS"));
				listBook.add(book);
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (rs != null) {
				try {
					rs.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return listBook;
	}

	@Override
	public List<Book> getAll() {
		Map<String, String> map = new HashMap<String, String>();
		List<Book> listBook = advSearch(map);
		return listBook;
	}

	@Override
	public void update(Book book) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_STMT);

			pstmt.setString(1, book.getPublisherID());
			pstmt.setString(2, book.getLanguageID());
			pstmt.setString(3, book.getCategoryID());
			pstmt.setString(4, book.getBookName());
			pstmt.setString(5, book.getIsbn());
			pstmt.setString(6, book.getAuthor());
			pstmt.setDouble(7, book.getListPrice());
			pstmt.setDouble(8, book.getSalePrice());
			pstmt.setDouble(9, book.getBookBP());
			pstmt.setInt(10, book.getIsSold());
			pstmt.setDate(11, book.getPublicationDate());
			pstmt.setInt(12, book.getStock());
			pstmt.setInt(13, book.getSafetyStock());
			pstmt.setString(14, book.getBookIntro());
			pstmt.setString(15, book.getBookNameOriginal());
			pstmt.setString(16, book.getBookID());

			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void updateSalePricePromo(String bookID, Double salePricePromo) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_SALE_PRICE_PROMO_STMT);
			if (salePricePromo.isNaN()) {
				pstmt.setString(1, null);
			} else {
				pstmt.setDouble(1, salePricePromo);
			}
			pstmt.setString(2, bookID);

			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void insertBatch(List<Book> books) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(INSERT_STMT);

			for (Book book : books) {
				pstmt.setString(1, book.getPublisherID());
				pstmt.setString(2, book.getLanguageID());
				pstmt.setString(3, book.getCategoryID());
				pstmt.setString(4, book.getBookName());
				pstmt.setString(5, book.getIsbn());
				pstmt.setString(6, book.getAuthor());
				pstmt.setDouble(7, book.getListPrice());
				pstmt.setDouble(8, book.getSalePrice());
				pstmt.setDouble(9, book.getBookBP());
				pstmt.setInt(10, book.getIsSold());
				pstmt.setDate(11, book.getPublicationDate());
				pstmt.setInt(13, book.getStock());
				pstmt.setInt(14, book.getSafetyStock());
				pstmt.setString(15, book.getBookIntro());
				pstmt.setString(16, book.getBookNameOriginal());
				pstmt.addBatch();
			}

			pstmt.executeBatch();
			con.commit();

		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}

	}

	@Override
	public void updateSalePricePromoBatch(List<String> bookIDs, List<Double> salePricePromos) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_SALE_PRICE_PROMO_STMT);

			for (int i = 0; i < bookIDs.size(); i++) {
				Double salePricePromo = salePricePromos.get(i);
				String bookID = bookIDs.get(i);

				if (salePricePromo.isNaN()) {
					pstmt.setString(1, null);
				} else {
					pstmt.setDouble(1, salePricePromo);
				}
				pstmt.setString(2, bookID);
				pstmt.addBatch();
			}
			pstmt.executeBatch();
			con.commit();
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public void updateIsSoldBatch(List<String> bookIDs, Integer isSold) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_IS_SOLD_STMT);

			for (int i = 0; i < bookIDs.size(); i++) {
				String bookID = bookIDs.get(i);
				pstmt.setInt(1, isSold);
				pstmt.setString(2, bookID);
				pstmt.addBatch();
			}
			pstmt.executeBatch();
			con.commit();
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	@Override
	public List<Book> findByBookIDList(List<String> bookIDs) {
		List<Book> listBook = new ArrayList<Book>();
		Book book = null;
		Connection con = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(FIND_BY_BOOK_ID_STMT);

			for (String bookID : bookIDs) {
				pstmt.setString(1, bookID);
				rs = pstmt.executeQuery();
				while (rs.next()) {
					book = new Book();
					book.setBookID(rs.getString("BOOK_ID"));
					book.setPublisherID(rs.getString("PUBLISHER_ID"));
					book.setLanguageID(rs.getString("LANGUAGE_ID"));
					book.setCategoryID(rs.getString("CATEGORY_ID"));
					book.setBookName(rs.getString("BOOK_NAME"));
					book.setIsbn(rs.getString("ISBN"));
					book.setAuthor(rs.getString("AUTHOR"));
					book.setListPrice(rs.getDouble("LIST_PRICE"));
					book.setSalePrice(rs.getDouble("SALE_PRICE"));
					book.setBookBP(rs.getDouble("BOOK_BP"));
					book.setIsSold(rs.getInt("IS_SOLD"));
					book.setPublicationDate(rs.getDate("PUBLICATION_DATE"));
					book.setStock(rs.getInt("STOCK"));
					book.setSafetyStock(rs.getInt("SAFETY_STOCK"));
					book.setBookIntro(rs.getString("BOOK_INTRO"));
					book.setBookNameOriginal(rs.getString("BOOK_NAME_ORIGINAL"));
					if (rs.getObject("SALE_PRICE_PROMO") == null) {
						book.setSalePricePromo(Double.NaN);
					} else {
						book.setSalePricePromo(rs.getDouble("SALE_PRICE_PROMO"));
					}
					if (rs.getObject("BOOK_BP_PROMO") == null) {
						book.setBookBPPromo(Double.NaN);
					} else {
						book.setBookBPPromo(rs.getDouble("BOOK_BP_PROMO"));
					}
					book.setEffectivePromos(rs.getString("EFFECTIVE_PROMOS"));
					listBook.add(book);
				}
			}
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
		return listBook;
	}

	@Override
	public void updateBPPromoBatch(List<String> bookIDs, List<Double> bookBPPromos) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_BOOK_BP_PROMO_STMT);

			for (int i = 0; i < bookIDs.size(); i++) {
				Double bookBPPromo = bookBPPromos.get(i);
				String bookID = bookIDs.get(i);

				if (bookBPPromo.isNaN()) {
					pstmt.setString(1, null);
				} else {
					pstmt.setDouble(1, bookBPPromo);
				}
				pstmt.setString(2, bookID);
				pstmt.addBatch();
			}
			pstmt.executeBatch();
			con.commit();
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}

	public void updateEffPromoBatch(List<String> bookIDs, List<String> effectivePromos) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_EFFECTIVE_PROMOS);

			for (int i = 0; i < bookIDs.size(); i++) {
				String effPromo = effectivePromos.get(i);
				String bookID = bookIDs.get(i);
				
				// 目前有效的促銷事件都記錄在這本書上，故不可被批量更新，只能被促銷事件排程器存取
				if("B00000000001".equals(bookID)) {
					continue;
				}
	
				pstmt.setString(1, effPromo);
				pstmt.setString(2, bookID);
				pstmt.addBatch();
			}
			pstmt.executeBatch();
			con.commit();
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	@Override
	public void updateBatch(List<Book> books) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			con.setAutoCommit(false);
			pstmt = con.prepareStatement(UPDATE_BATCH_STMT);

			for (int i = 0; i < books.size(); i++) {
				Book book = books.get(i);
				Double salePricePromo = book.getSalePricePromo();
				Double bookBPPromo = book.getBookBPPromo();
				
				// 目前有效的促銷事件都記錄在這本書上，故不可被批量更新，只能被促銷事件排程器存取
				if("B00000000001".equals(book.getBookID())) {
					continue;
				}
				
				pstmt.setString(1, book.getPublisherID());
				pstmt.setString(2, book.getLanguageID());
				pstmt.setString(3, book.getCategoryID());
				pstmt.setString(4, book.getBookName());
				pstmt.setString(5, book.getIsbn());
				pstmt.setString(6, book.getAuthor());
				pstmt.setDouble(7, book.getListPrice());
				pstmt.setDouble(8, book.getSalePrice());
				pstmt.setDouble(9, book.getBookBP());
				pstmt.setInt(10, book.getIsSold());
				pstmt.setDate(11, book.getPublicationDate());
				pstmt.setInt(12, book.getStock());
				pstmt.setInt(13, book.getSafetyStock());
				pstmt.setString(14, book.getBookIntro());
				pstmt.setString(15, book.getBookNameOriginal());
				
				if (salePricePromo.isNaN()) {
					pstmt.setString(16, null);
				} else {
					pstmt.setDouble(16, salePricePromo);
				}
				
				if (bookBPPromo.isNaN()) {
					pstmt.setString(17, null);
				} else {
					pstmt.setDouble(17, bookBPPromo);
				}
				pstmt.setString(18, book.getEffectivePromos());
				pstmt.setString(19, book.getBookID());	
				pstmt.addBatch();
			}
			pstmt.executeBatch();
			con.commit();
		} catch (SQLException se) {
			try {
				con.rollback();
			} catch (SQLException e) {
				e.printStackTrace();
			}
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.setAutoCommit(true);
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
	
	//B00000000001專屬方法
	public void updateEffPromos(String effectivePromos) {
		Connection con = null;
		PreparedStatement pstmt = null;

		try {
			con = ds.getConnection();
			pstmt = con.prepareStatement(UPDATE_EFFECTIVE_PROMOS);
			pstmt.setString(1, effectivePromos);
			pstmt.setString(2, "B00000000001");
			pstmt.executeUpdate();
		} catch (SQLException se) {
			throw new RuntimeException("A database error occured. " + se.getMessage());
			// Clean up JDBC resources
		} finally {
			if (pstmt != null) {
				try {
					pstmt.close();
				} catch (SQLException se) {
					se.printStackTrace(System.err);
				}
			}
			if (con != null) {
				try {
					con.close();
				} catch (Exception e) {
					e.printStackTrace(System.err);
				}
			}
		}
	}
}