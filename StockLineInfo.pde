// Class to create a StockLineInfo object
// Helps to sort data more effectively
// Contributors: Stephen Cashin & Dermot O'Brien
import java.text.DateFormat; 
import java.text.SimpleDateFormat;

public class StockLineInfo implements Comparable<StockLineInfo>
{
  private float openingPrice;
  private float closingPrice;
  private Date date;
  private String tickerName;
  private int id;
  private float adjClose;
  private float low;
  private float high;
  private int volume;
  
  StockLineInfo()
  {
    
  }
  
  // Constructor for StockLineInfo object
  // By Stephen Cashin
  StockLineInfo(float openingPrice, float closingPrice, Date date, String tickerName, int id, float adjClose, float low, float high, int volume)
  {
    this.volume = volume;
    this.high = high;
    this.low = low;
    this.adjClose = adjClose;
    this.openingPrice = openingPrice;
    this.closingPrice = closingPrice;
    this.date = date;
    this.tickerName = tickerName;  
    this.id = id;
  }

  // Function to get volume
  // Returns volume
  // By Stephen Cashin
  int getVolume()
  {
    return volume;
  }

  //// Function to get highest Price
  //// Returns high
  //// By Stephen Cashin
  float getHigh()
  {
    return high;
  }
  
  // Function to get id
  // Returns id
  // By Stephen Cashin
  int getId()
  {
    return id;
  }
  
  // Function to get lowest Price
  // Returns low
  // By Stephen Cashin
  float getLow()
  {
    return low;
  }
  
  // Function to get adj_close
  // Returns adj_close
  // By Stephen Cashin
  float getAdjClose()
  {
    return adjClose; 
  }
  
  // Function to get opening Price
  // Returns opening Price
  // By Stephen Cashin
  float getOpeningPrice()
  {
   return openingPrice; 
  } 

  // Function to get Closing Price
  // Returns Closing Price
  // By Stephen Cashin
  float getClosingPrice()
  {
   return closingPrice; 
  }
  
  // Function to get date
  // Returns date
  // By Stephen Cashin
  Date getDate()
  {
   return date; 
  }

  // Function to get date as a String
  // Returns date as a String
  // By Stephen Cashin
  String getDateAsString()
  {
   DateFormat dateFormat = new SimpleDateFormat("dd MMM, yyyy");
   String strDate = dateFormat.format(date);
   return strDate;
  }
  
  // Function to get date as a year only
  // Returns date as year only
  // By Dermot O'Brien
  int getYear() {
   DateFormat yearFormat = new SimpleDateFormat("yyyy");
   int yearDate = Integer.parseInt(yearFormat.format(date));
   return yearDate;
  }
  
  // Function to get ticker name
  // Returns ticker name
  // By Stephen Cashin
  String getTickerName()
  {
    return tickerName;
  }
  
  // Function to sort data by date ascending
  // Returns data sorted by date
  // By Stephen Cashin
  @Override
  public int compareTo(StockLineInfo compareInfo)
  {
    return getDate().compareTo(compareInfo.getDate());
  }
  
}
