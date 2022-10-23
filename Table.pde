// Class to implement table data and functionality
// Contributors Stephen Cashin

public class Table implements Comparator<String[]> 
{
  
  private int pageNumber;
  private int currentOffset;
  private int numberOfDataPoints;
  public String[][] tableWithData;
  
  Table(ArrayList data, int numberOfDataPoints, int page, int currentOffset)
  {
    this.currentOffset = currentOffset;
    this.numberOfDataPoints = numberOfDataPoints;
    pageNumber = page;
    tableWithData = new String[NUMBER_OF_ROWS][NUMBER_OF_COLUMNS];
    for (int y=0; y <NUMBER_OF_COLUMNS; y++) { 
      for (int x=0; x < NUMBER_OF_ROWS; x++) {
        tableWithData[x][y]= (((ArrayList)(data.get(y))).get(x)).toString();
      }
    }
    
  }
  
  void updateTableData(ArrayList data)
  {

    for (int y=(pageNumber-1)*10; y <(NUMBER_OF_COLUMNS+((pageNumber-1)*10)); y++) {
      for (int x=0; x < NUMBER_OF_ROWS; x++) {
          tableWithData[x][y-((pageNumber-1)*10)]= (((ArrayList)(data.get(y-currentOffset))).get(x)).toString(); 
        }
      }
    
  }
  
  
  
  int getPageNumber()
  {
    return pageNumber; 
  }
  
  void incrementPageNumber()
  {
   // if(pageNumber < numberOfDataPoints/10)
    pageNumber++;
  }
  
  void decrementPageNumber()
  {
    if(pageNumber > 1)
    {
      pageNumber--; 
    }
  }
  
  void showAGrid(String[][] data, int xOffSet) {
 
  // distance between  
  int distanceCellX = 120;
  int distanceCellY = 40;
 
  // size of a cell 
  int sizeCellX = 15;
  int sizeCellY = 15;
 
  // nested for loop
  for (int y=0; y < NUMBER_OF_COLUMNS; y++) { 
    for (int x=0; x < NUMBER_OF_ROWS; x++) 
    {
      //fill(data[x][y]);
      text(data[x][y], x*distanceCellX+xOffSet, y*distanceCellY+150);
      stroke(255);
     // rect(x*distanceCell+xOffSet, y*distanceCell+18, 
     // sizeCellX, sizeCellY);
    }
  }
}
  
  @Override
  public int compare(String[] array1, String[] array2)
  {
     String s1 = array1[1];
     String s2 = array2[1];
     return -s1.compareTo(s2);
  }
  
  
}
