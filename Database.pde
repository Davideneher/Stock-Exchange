// Class to query database
// contributors: Dermot O'Brien


/* HOW TO USE DATABASE
 **************************************
 1. Get Rows From Table: getRowsFromTable()
 Use this function to query each table
 
 @param  String  table          Name of the table you want to access eg daily_prices1k, daily_prices10k, dailyPrices_2GB
 @param  int     quantity       The amount of results you want. Each table contains 1000's to 1,000,000's of lines, use this function to return a certain amount
 @param  int     offset         Create an offset. Use this if you do not want to start at the 0th index. eg Start at the 100th index
 @param  String  orderByColumn  Order the data by column eg Date, Ticker, open etc
 
 @result ArrayList
 
 
 **************************************
 */
import de.bezier.data.sql.*;
import de.bezier.data.sql.mapper.*;
import java.sql.*;
DatabaseException tableDoesNotExist = new DatabaseException("Error This table does not exist.");
DatabaseException invalidNumber = new DatabaseException("Error Invalid number provided.");
DatabaseException columnDoesNotExist = new DatabaseException("Error This column does not exist.");
DatabaseException invalidString = new DatabaseException("Error Invalid String provided.");

class Database {    
  Connection  con;
  ResultSet   res;
  final String STOCKS_TABLE = "stocks";
  void Database() {
  }

  // Function that establishes connection with SQL server
  void connection() {
    try {
      Class.forName("com.mysql.jdbc.Driver");
      con = DriverManager.getConnection ("jdbc:mysql://194.58.121.193:3306/trinityprogrammingproject", "usertrinityaccess", "P3q8F5z9");
    } 
    catch (Exception e) {
      println("ERROR Exception in #DatabaseConnection: " + e);
    }
  }

  // Function that query's database directly
  // Parameters: query
  // Returns Arraylist of data
  ArrayList query(String query) {
    ArrayList output = new ArrayList();
    try {
      this.connection();
      Statement st = con.createStatement();
      ResultSet res = st.executeQuery(query);
      while (res.next()) {
        output.add(res.getString(1));
      }
      con.close();
    } 
    catch (Exception e) {
      println("ERROR Exception in #DatabaseQueryMethod: " + e);
    }
    return output;
  }

  // Function that checks if a table exists
  // Returns boolean
  boolean tableExists(String table) {
    return (this.query("SHOW TABLES LIKE '" + table + "'").size() == 1);
  }

  // Function that checks if a column exists
  // Returns boolean
  boolean columnExists(String table, String orderByColumn) { 
    return (this.query("SHOW COLUMNS FROM " + table + " LIKE '" + orderByColumn + "'").size() == 1);
  }

  // Function that gets data from the table
  // Parameters: table, quantity(of Rows), offset(By Row)
  // Returns ArrayList of Data
  ArrayList getRowsFromTable(String table, int quantity, String tickerName) {
    return this.getRowsFromTable(table, quantity, tickerName, "id", "ASC", 0);
  }

  ArrayList getRowsFromTable(String table, int quantity, String tickerName, String orderByColumn, String sortingOrder) {
    return this.getRowsFromTable(table, quantity, tickerName, orderByColumn, sortingOrder, 0);
  }


  // Function that gets all data related to a stock
  // Returns ArrayList of associated data
  ArrayList getStockData(String tickerLike) {
    ArrayList output = new ArrayList();
    try {
      if (!tableExists(STOCKS_TABLE)) throw tableDoesNotExist;

      //String query = "SELECT * FROM " + STOCKS_TABLE + " WHERE `ticker` REGEXP '" + tickerLike + "'";
      String query = "SELECT * FROM `stocks`";
      if (tickerLike.length() > 0) {
        query += " WHERE `ticker` REGEXP '" + tickerLike + "'";
      } 
      println(query);
      this.connection();
      Statement st = con.createStatement();
      ResultSet res = st.executeQuery(query);
      while (res.next()) {
        //int id           =   res.getInt(1);
        String ticker    =   res.getString(2);
        String exchange  =   res.getString(3);
        //String name      =   res.getString(4);
        //String sector    =   res.getString(5);
        //String industry  =   res.getString(6);

        ArrayList result = new ArrayList();
        //Collections.addAll(result, id, ticker, exchange, name, sector, industry);
        Collections.addAll(result, ticker, exchange);
        output.add(result);
      }
    } 
    catch(Exception e) {
      println("ERROR Exception in #getStockData: " + e);
    }

    return output;
  }

  // Function that gets data from the table
  // Parameters: table, quantity(of Rows), offset(By Row), order(column)
  // Returns ArrayList of Data  
  ArrayList getRowsFromTable(String table, int quantity, String tickerName, String orderByColumn, String sortingOrder, int offset) {
    ArrayList output = new ArrayList();
    try {
      String query;
      println("getRowsFromTable called");
      if (!tableExists(table)) throw tableDoesNotExist;
      if (!columnExists(table, orderByColumn)) throw columnDoesNotExist;
      if (quantity < -1) throw invalidNumber;
      if (tickerName.length() < 1) throw invalidString;
      //if (offset < 0) throw invalidNumber;
      println("error checking finished");

      if (tickerName.equals("allTickers"))
      {
        query = "SELECT * FROM " + table;
      } else
      {
        //String query = "SELECT * FROM " + table + " ORDER BY '" + orderByColumn + "' DESC LIMIT " + quantity + " OFFSET " + offset;
        query = "SELECT * FROM " + table + " WHERE ticker = '" + tickerName + "'";
        // if quantity == -1, do not limit results
      }
      //query += " WHERE 'ticker' = '" + tickerName + "'";
      query += " ORDER BY " + orderByColumn + " " +  sortingOrder;
      if (quantity != -1) {
        query += " LIMIT " + quantity;
      }
      if(offset > 0) {
        query += " OFFSET " + offset;
      }
      println(query);
      this.connection();
      Statement st = con.createStatement();
      ResultSet res = st.executeQuery(query);
      while (res.next()) {
        int id           =   res.getInt(1);
        String ticker    =   res.getString(2);
        float open       =   res.getFloat(3);
        float close      =   res.getFloat(4);
        float adj_close  =   res.getFloat(5);
        float low        =   res.getFloat(6);
        float high       =   res.getFloat(7);
        int volume       =   res.getInt(8);
        String date      =   res.getString(9);
        ArrayList result = new ArrayList();
        Collections.addAll(result, id, ticker, open, close, adj_close, low, high, volume, date);
        output.add(result);
      }
    }
    catch(Exception e) {
      println("ERROR Exception in #DatabaseGetRowsFromTable: " + e);
    }
    return output;
  }
}

// Class that handles exceptions
class DatabaseException extends Exception {
  DatabaseException(String str)
  {
    super(str);
  }
}
