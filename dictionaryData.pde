//// Class responsible for organinsing data in accesible types and Formats
//// Contributors: Dermot O'Brien & Stephen Cashin

//import java.util.*;
class dictionaryData {
  ArrayList<StockLineInfo> infoList;

  // Function to ouptut all ticker names
  // Returns void
  // by Dermot O'Brien
  String getTickerNames() {
    String[] output = loadStrings("../stocks.csv");
    return output[10].split(",")[0];
  }

  // Function to create an array of floats of closingPrices from an Arraylist of StockLineInfo
  // Returns float[] with Closing prices
  // By Dermot O'Brien
  float[] getClosingPrices(ArrayList<StockLineInfo> infoList)
  {
    float currentPrice;
    float[] array = new float[infoList.size()];
    ArrayList<Float> closingPrices;
    for (int i=0; i<infoList.size(); i++)
    {
      currentPrice = infoList.get(i).getClosingPrice();
      array[i] = currentPrice;
    }
    return array;
  }

  // Function to get the date of an element in an ArrayList of StockLineInfo
  // Returns date as String
  // By Dermot O'Brien
  String getDateByIndex(int index, ArrayList<StockLineInfo> infoList) {
    return infoList.get(index).getDateAsString();
  }

  // Function to create an ArrayList of Stock Info
  // Returns ArrayList<StockLineInfo> sorted by date
  // By Stephen Cashin & Dermot O'Brien
  ArrayList<StockLineInfo> getRelevantInfo(String table, String tickerName)
  {
    maxClosingValue = 0;
    ArrayList<StockLineInfo> infoList = new ArrayList();
    Date date;
    StockLineInfo line = new StockLineInfo();
    ArrayList data = db.getRowsFromTable(table, -1, tickerName, "date", "ASC", 0);
    for (int i=0; i<data.size(); i++)
    {
      //getting Date
      String currentDate = (((ArrayList)(data.get(i))).get(8)).toString();
      
      try
      {
        date = new SimpleDateFormat("yyyy-MM-dd").parse(currentDate);

        //getting id
        String idString = (((ArrayList)(data.get(i))).get(0)).toString();
        int id = Integer.parseInt(idString);        

        //getting closingPrice
        String closingPricesString = (((ArrayList)(data.get(i))).get(3)).toString();
        float closingPrice = Float.valueOf(closingPricesString);
        if (closingPrice > maxClosingValue) {
          maxClosingValue = closingPrice;
        }
        //getting adjClose
        String adjCloseString = (((ArrayList)(data.get(i))).get(4)).toString();
        float adjClose = Float.valueOf(adjCloseString);
        
        //getting low
        String lowString = (((ArrayList)(data.get(i))).get(5)).toString();
        float low = Float.valueOf(lowString);
        
        //getting high
        String highString = (((ArrayList)(data.get(i))).get(6)).toString();
        float high = Float.valueOf(highString);
        
        //getting volume
        String volumeString = (((ArrayList)(data.get(i))).get(7)).toString();
        int volume = Integer.parseInt(volumeString);
        
        //getting openingPrice
        String openingPricesString = (((ArrayList)(data.get(i))).get(2)).toString();
        float openingPrice = Float.valueOf(openingPricesString);

        // getting TickerName
        tickerName = (((ArrayList)(data.get(i))).get(1)).toString();

        line = new StockLineInfo(openingPrice, closingPrice, date, tickerName, id, adjClose, low, high, volume);
        infoList.add(line);
        if(i == 0) minYearRange = line.getYear();
        if(i == data.size() - 1) maxYearRange = line.getYear();
      }    
      catch (Exception e)
      {
        println("ERROR Exception in #DatabaseConnection: " + e);
      }
    }
    Collections.sort(infoList);
    return infoList;
  }
  
  // Function to create an ArrayList of Stock Info within a set of Dates
  // Returns ArrayList<StockLineInfo> sorted by date
  // by Stephen Cashin
  ArrayList<StockLineInfo> getInfoWithDates(ArrayList<StockLineInfo> info, Date openingDate, Date closingDate)
  {
    maxClosingValue = 0;
    StockLineInfo line;
    Date currentDate;
    ArrayList<StockLineInfo> infoWithDates = new ArrayList();
    for(int i=0; i<info.size(); i++)
    {
      currentDate = info.get(i).getDate();
      if((currentDate.compareTo(openingDate) >= 0) && currentDate.compareTo(closingDate) < 0 )
      {
        if (info.get(i).getClosingPrice() > maxClosingValue) {
          maxClosingValue = info.get(i).getClosingPrice();
        }
        line = new StockLineInfo(info.get(i).getOpeningPrice(), info.get(i).getClosingPrice(), 
        info.get(i).getDate(), info.get(i).getTickerName(), info.get(i).getId(), info.get(i).getAdjClose(),
        info.get(i).getLow(), info.get(i).getHigh(), info.get(i).getVolume());
        infoWithDates.add(line);
      }
    }
    return infoWithDates;
  }

  // Function to get amount of Rows in a table
  // Returns int value of Rows
  // by Stephen Cashin
  int getAmountOfRows(String table)
  {
    int amountOfRows;
    ArrayList amountOfRowsInTable = db.query("SELECT COUNT(*) FROM " + table);
    String amountOfRowsString = amountOfRowsInTable.get(0).toString();
    amountOfRows = Integer.parseInt(amountOfRowsString);
    return amountOfRows;
  }
  
  // function to convert an ArrayList of float values to an Array of floats
  // Necessary for some graph input
  // returns float[] that contains the ArrayList elements
  // by Stephen Cashin
  float[] ArrayListToArrayFloat(ArrayList<Float> arrayList)
  {
    float[] array = new float[arrayList.size()];
    for (int i=0; i<arrayList.size(); i++)
    {
      array[i] = arrayList.get(i);
    }
    return array;
  }

}
