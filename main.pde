 // Class used to draw screens & test functions
// Contributors: Dermot O'Brien, Stephen Cashin, Desmond Lee, David Deneher
import java.util.Date;
import java.text.SimpleDateFormat;

// Functions to set up screen
void settings() {
  size(SCREEN_X, SCREEN_Y);
}

// Function to setup all necessary data and functionality
// By Dermot O'Brien, David Deneher & Stephen Cashin
void setup() {
  //Visual Setup
  font = createFont("CourierNewPSMT-48.vlw", 32);
  tableLabelFont = createFont("CourierNewPSMT-48.vlw", 18);
  tickerFont = createFont("VerdanaPro-CondBlackItalic-90.vlw", 90);
  textFont(font);
  logo = loadImage("Logo.png");
  logoHappy = loadImage("Logo1.PNG");
  background = loadImage("background.png");

  // Dictionary Data 
  dictionaryData = new dictionaryData();

  // External Stock API
  stockApi = new ExternalStockAPI();


  //dictionaryData.loadTableGetDataByTicker("../daily_prices1k.csv");
  //tickerName = dictionaryData.getTickerNames();

  // Charts
  cp5 = new ControlP5(this);
  lineChart = new Charts(cp5);

  //Widgets
  textBox = new TextBox();
  chartSlider = new Sliders();
  chartSlider.setRange(1980, 2020);
  //listOfTickers = new List(cp5);
  barChartButton = cp5.addBang("Bar Chart");
  barChartButton.setPosition(GRAPHXPOS+GRAPHXSIZE + 50, GRAPHYPOS+55).setSize(100, 50).setFont(tableLabelFont).setColorLabel(#0A0D93);
  lineChartButton = cp5.addBang("Line Chart");
  lineChartButton.setPosition(GRAPHXPOS+GRAPHXSIZE + 50, GRAPHYPOS+135).setSize(100, 50).setFont(tableLabelFont).setColorLabel(#0A0D93);
  sliderButton = cp5.addBang("Slider Button");
  sliderButton.setPosition(GRAPHXPOS + GRAPHXSIZE +5, GRAPHYPOS+GRAPHYSIZE+20).setSize(40, 40).setCaptionLabel("GO");


  // Screens
  myTextfield.hide();
  listOfTickers.hide();
  chartSlider.hide();
  lineChart.hide();
  barChartButton.hide();
  lineChartButton.hide();
  sliderButton.hide();
  addButtons();

  homepageScreen.display();
}

// Function to draw parts of the screen
// By David Deneher
void draw() {
  fill(0);
  background(background);
  if (goBack.isMouseOver()) {
    tint(0);
  } else {
    noTint();
  }

  if (isTableScreen == true && running == true)
  {
    dataInTable.showAGrid(dataInTable.tableWithData, 30);
    text("Page " + dataInTable.getPageNumber(), ((SCREEN_X/2) - 20), SCREEN_Y-40);
  }
  tint(#000393);
  if (isHomePage) {
    //rect(SCREEN_X/2-225, 30, 450, 50);
    textSize(18);
    text("David Deneher",SCREEN_X/2-225, 445);
    text("Dermot O' Brien",SCREEN_X/2+100, 445);
    text("Honglin Li", SCREEN_X/2-172, 490);
    text("Stephen Cashin", SCREEN_X/2+75, 490);
    if (mouseX > SCREEN_X/2-200 && mouseX < SCREEN_X/2+200 && mouseY > 40 && mouseY < 40 + 500) {
      image(logoHappy, SCREEN_X/2-225, 40, 450, 500);
    } else {
      image(logo, SCREEN_X/2-225, 39, 450, 500);
    }
  }

  fill(0);
  if (isLiveData) {
    lineChart.updateLiveChart(chosenTickerName);
  }
  if (isLineGraph) {
    textBox.draw();
    //println(chartSlider);
    lineChart.drawAxis();
    if (isPressed && chosenTickerName.length() > 0) {
      lineChart.findValue(chosenTickerName);
    }
  }
}

// Function that handles the events caused by pressing buttons
// By David Deneher, Dermot O'Brien & Stephen Cashin
void controlEvent(ControlEvent theEvent) { 
  if (theEvent.getName().equals("listOfTickers")) {
    int chosenIndex = (int) theEvent.value();
    isPressed = true;
    isLiveData = false;
    //dataOnGraph = myTextfield.getText();
    println(theEvent);
    chosenTickerName = (String)((ArrayList)tickerList.get(chosenIndex)).get(0);
    println(chosenTickerName);
    //dataOnGraph = tickerName;
    //println(tickerName);
    // println(db.getRowsFromTable("daily_prices100k", -1, tickerName, "id"));
    originalData = dictionaryData.getRelevantInfo("daily_prices2GB", chosenTickerName);
    data = (ArrayList<StockLineInfo>) originalData.clone();
    dataSet = dictionaryData.getClosingPrices(data); 
    //lineChart = new Charts(cp5, chosenTickerName, dataSet);
    lineChart.updateChart(chosenTickerName, dataSet, true);
  }
  if (theEvent.getName().equals("Bar Chart")) {
    println("bar chart");
    lineChart.switchToBarChart();
  }
  if (theEvent.getName().equals("Line Chart")) {
    lineChart.switchToLineChart();
  }
  if (theEvent.getName().equals("Id")) {
    println("sorting by Id");
    sortingOrder = "ASC";
    currentSortingMethod = "id";
    currentPageOffset = 0;
    tableData = db.getRowsFromTable("daily_prices10k", NUMBER_OF_LOADED_ROWS, "allTickers", currentSortingMethod, sortingOrder);
    dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
  }

  if (theEvent.getName().equals("Open"))
  {
    println("sorting by Open"); 
    currentSortingMethod = "open";
    sortingOrder = "DESC";
    currentPageOffset = 0;
    tableData = db.getRowsFromTable("daily_prices10k", NUMBER_OF_LOADED_ROWS, "allTickers", currentSortingMethod, sortingOrder);
    dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
  }
  if (theEvent.getName().equals("Close"))
  {
    println("sorting by Close");
    currentSortingMethod = "close";
    sortingOrder = "DESC";
    currentPageOffset = 0;
    tableData = db.getRowsFromTable("daily_prices10k", NUMBER_OF_LOADED_ROWS, "allTickers", currentSortingMethod, sortingOrder);
    dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
  }
  if (theEvent.getName().equals("Ticker"))
  {
    println("sorting by Ticker");
    currentSortingMethod = "ticker";
    sortingOrder = "ASC";
    currentPageOffset = 0;
    tableData = db.getRowsFromTable("daily_prices10k", NUMBER_OF_LOADED_ROWS, "allTickers", currentSortingMethod, sortingOrder);
    dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
  }
  if (theEvent.getName().equals("AdjClose"))
  {
    println("sorting by AdjClose");
    currentSortingMethod = "adj_close";
    sortingOrder = "DESC";
    currentPageOffset = 0;
    tableData = db.getRowsFromTable("daily_prices10k", NUMBER_OF_LOADED_ROWS, "allTickers", currentSortingMethod, sortingOrder);
    dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
  }
  if (theEvent.getName().equals("Low"))
  {
    println("sorting by Low");
    currentSortingMethod = "low";
    sortingOrder = "DESC";
    currentPageOffset = 0;
    tableData = db.getRowsFromTable("daily_prices10k", NUMBER_OF_LOADED_ROWS, "allTickers", currentSortingMethod, sortingOrder);
    dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
  }
  if (theEvent.getName().equals("High"))
  {
    println("sorting by High");
    currentSortingMethod = "high";
    sortingOrder = "DESC";
    currentPageOffset = 0;
    tableData = db.getRowsFromTable("daily_prices10k", NUMBER_OF_LOADED_ROWS, "allTickers", currentSortingMethod, sortingOrder);
    dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
  }
  if (theEvent.getName().equals("Volume"))
  {
    println("sorting by Volume");
    currentSortingMethod = "volume";
    sortingOrder = "DESC";
    currentPageOffset = 0;
    tableData = db.getRowsFromTable("daily_prices10k", NUMBER_OF_LOADED_ROWS, "allTickers", currentSortingMethod, sortingOrder);
    dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
  }  
  if (theEvent.getName().equals("Date"))
  {
    println("sorting by Date");
    currentSortingMethod = "date";
    sortingOrder = "DESC";
    currentPageOffset = 0;
    tableData = db.getRowsFromTable("daily_prices10k", NUMBER_OF_LOADED_ROWS, "allTickers", currentSortingMethod, sortingOrder);
    dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
  } 

  if (theEvent.getName().equals(">")) {
    try {
      dataInTable.incrementPageNumber();

      if((dataInTable.getPageNumber()-1)%(NUMBER_OF_LOADED_ROWS/10) == 0)
       {
        currentPageOffset += NUMBER_OF_LOADED_ROWS;
        tableData = db.getRowsFromTable("daily_prices10k", NUMBER_OF_LOADED_ROWS, "allTickers", currentSortingMethod, sortingOrder, currentPageOffset);
        dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
      }

      dataInTable.updateTableData(tableData);
    }
    catch (Exception e)
    {
      println("ERROR Exception in #DatabaseConnection: " + e);
    }
  }
  if (theEvent.getName().equals("<")) {
    try {
      dataInTable.decrementPageNumber();
      if(dataInTable.getPageNumber()%(NUMBER_OF_LOADED_ROWS/10) == 0)
      {
        currentPageOffset -= NUMBER_OF_LOADED_ROWS;
        tableData = db.getRowsFromTable("daily_prices10k", NUMBER_OF_LOADED_ROWS, "allTickers", currentSortingMethod, sortingOrder, currentPageOffset);
        dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
      }
      dataInTable.updateTableData(tableData);
    }
    catch (Exception e)
    {
      println("ERROR Exception in #DatabaseConnection: " + e);
    }
  }

  if (theEvent.isController()) {
    println(theEvent);
    previousScreen = currentScreen;
    if (theEvent.getName().equals("LineGraph"))
    {
      isTableScreen = false;
      isLineGraph = true;
      isHomePage = false;
      lineGraphScreen.display();
      println("Line Graph Screen");
      myTextfield.show();
      listOfTickers.show();
      chartSlider.show();
      barChartButton.show();
      lineChartButton.show();
      sliderButton.show();
      tableTest.hide();
    }
    if (theEvent.getName().equals("Table"))
    {
      isTableScreen = true;
      isHomePage = false;
      isLineGraph = false;
      tableTest.hide();
      tableScreen.display();
      running = true;
      println("run");
      tableFont = createFont("CourierNewPSMT-48.vlw", 16);
      textFont(tableFont);
      tableData = db.getRowsFromTable("daily_prices10k", 10000, "allTickers", currentSortingMethod, sortingOrder, currentPageOffset);
      dataInTable = new Table(tableData, tableData.size(), (currentPageOffset/10)+1, currentPageOffset);
      println(data);
    }
    if (theEvent.getName().equals("LiveData"))
    {
      isLiveData = !isLiveData;
      //isHomePage = false;
      //liveDataScreen.display();
      //println("Live Data Screen");
      //lineChart.hide();
      //myTextfield.hide();
      //listOfTickers.hide();
      //chartSlider.hide();
      if (isLiveData) {
        lineChart.newLiveChart(chosenTickerName);
        chartSlider.hide();
      } else {
        lineChart.updateChart(chosenTickerName, dataSet, true);
        chartSlider.show();
      }
      //lineChart.updateLiveChart(chosenTickerName);
    }
    if (theEvent.getName().equals("Back"))
    {
      if (previousScreen != SCREEN_HOMEPAGE)//should be "==" but don't know what's wrong
        homepageScreen.display();
      println("Home Screen");
      isHomePage = true;
      running = false;
      isLiveData = false;
      isLineGraph = false;
      lineChart.hide();
      myTextfield.hide();
      listOfTickers.hide();
      chartSlider.hide();
      barChartButton.hide();
      lineChartButton.hide();
      sliderButton.hide();
      nextPage.hide();
      previousPage.hide();
      sortByTicker.hide();
      sortByOpen.hide();
      sortByClose.hide();
      sortByAdjClose.hide();
      sortByLow.hide();
      sortByHigh.hide();
      sortByVolume.hide();
      sortByDate.hide();
      sortById.hide();
      //else if(previousScreen == SCREEN_NASDAQ_TICKERS)
      //lineGraphScreen.display();
      //else if(previousScreen == SCREEN_NYSE_TICKERS)
      //liveDataScreen.display();
    }
  }

  if (theEvent.getName().equals("Slider Button"))
  {
    try
    {
      String openingDateString = Integer.toString(minSliderValue);
      Date openingDate = new SimpleDateFormat("yyyy").parse(openingDateString);
      String closingDateString = Integer.toString(maxSliderValue);
      Date closingDate = new SimpleDateFormat("yyyy").parse(closingDateString);
      data = dictionaryData.getInfoWithDates(originalData, openingDate, closingDate);
      dataSet = dictionaryData.getClosingPrices(data);
      lineChart.updateChart(chosenTickerName, dataSet, false);
    }    
    catch (Exception e)
    {
      println("ERROR Exception in #DatabaseConnection: " + e);
    }
  }
  if (theEvent.isFrom("sliderRange")) {
    minSliderValue = int(theEvent.getController().getArrayValue(0));
    maxSliderValue = int(theEvent.getController().getArrayValue(1));
    //chartSlider.setArrayValue(minSliderValue, maxSliderValue); 
    //if ((minSliderValue > 0) && (maxSliderValue > minSliderValue)) {
    //    //chartSlider.setPosition(12, 122); 
    //    chartSlider.updateRangeValues(minSliderValue, maxSliderValue);
    //  //println(maxSliderValue > minSliderValue);
    //  println("called in event ", minSliderValue, maxSliderValue);
    //}
    //println("called in event ", minSliderValue, maxSliderValue);
  }
}
void addButtons() {
  chooseLineGraph = cp5.addBang("LineGraph");
  chooseLineGraph.setPosition(50, SCREEN_Y/2 - 100).setSize(200, 200).setFont(font).setColorLabel(#0A0D93);
  chooseLineGraph.hide();

  chooseLiveData = cp5.addBang("LiveData");
  chooseLiveData.setPosition(GRAPHXPOS+GRAPHXSIZE, GRAPHYPOS-55).setSize(50, 50).setColorLabel(#0A0D93);
  chooseLiveData.hide();

  tableTest = cp5.addBang("Table");
  tableTest.setPosition(950, SCREEN_Y/2 -100).setSize(200, 200).setFont(font).setColorLabel(#0A0D93);
  tableTest.hide();

  nextPage = cp5.addBang(">");
  nextPage.setPosition((SCREEN_X/2) +70, SCREEN_Y-100).setSize(25, 25).setFont(font);
  nextPage.hide();

  previousPage = cp5.addBang("<");
  previousPage.setPosition((SCREEN_X/2) -70, SCREEN_Y-100).setSize(25, 25).setFont(font);
  previousPage.hide();

  sortByTicker = cp5.addBang("Ticker");
  sortByTicker.setPosition(X_MARGIN + LABEL_MARGIN, 70).setSize(45, 10).setFont(tableLabelFont);
  sortByTicker.hide();

  sortById = cp5.addBang("Id");
  sortById.setPosition(X_MARGIN, 70).setSize(45, 10).setFont(tableLabelFont);
  sortById.hide();

  sortByOpen = cp5.addBang("Open");
  sortByOpen.setPosition(X_MARGIN + LABEL_MARGIN*2, 70).setSize(45, 10).setFont(tableLabelFont);
  sortByOpen.hide();

  sortByClose = cp5.addBang("Close");
  sortByClose.setPosition(X_MARGIN + LABEL_MARGIN*3, 70).setSize(45, 10).setFont(tableLabelFont);
  sortByClose.hide();

  sortByAdjClose = cp5.addBang("AdjClose");
  sortByAdjClose.setPosition(X_MARGIN + LABEL_MARGIN*4, 70).setSize(45, 10).setFont(tableLabelFont);
  sortByAdjClose.hide();

  sortByLow = cp5.addBang("Low");
  sortByLow.setPosition(X_MARGIN + LABEL_MARGIN*5, 70).setSize(45, 10).setFont(tableLabelFont);
  sortByLow.hide();

  sortByHigh = cp5.addBang("High");
  sortByHigh.setPosition(X_MARGIN + LABEL_MARGIN*6, 70).setSize(45, 10).setFont(tableLabelFont);
  sortByHigh.hide();

  sortByVolume = cp5.addBang("Volume");
  sortByVolume.setPosition(X_MARGIN + LABEL_MARGIN*7, 70).setSize(45, 10).setFont(tableLabelFont);
  sortByVolume.hide();

  sortByDate = cp5.addBang("Date");
  sortByDate.setPosition(X_MARGIN + LABEL_MARGIN*8, 70).setSize(45, 10).setFont(tableLabelFont);
  sortByDate.hide();

  goBack = cp5.addBang("Back");
  goBack.setPosition(SCREEN_X-50, 0).setImage(loadImage("back.png")).updateSize();
  goBack.setSize(50, 50);
  goBack.hide();


  homepageScreen = new Screen(SCREEN_HOMEPAGE);
  lineGraphScreen = new Screen(SCREEN_NASDAQ_TICKERS);
  liveDataScreen = new Screen(SCREEN_NYSE_TICKERS);
  tableScreen = new Screen(SCREEN_TABLE);
  //  graphScreen = new Screen(SCREEN_SELECTED_GRAPH);
  //  dataScreen = new Screen(SCREEN_SELECTED_DATA);

  homepageScreen.addABang("LineGraph");
  homepageScreen.addABang("Table");
  tableScreen.addABang("Back");
  tableScreen.addABang("Ticker");
  tableScreen.addABang(">");
  tableScreen.addABang("<");
  tableScreen.addABang("Id");
  tableScreen.addABang("Open");
  tableScreen.addABang("Close");
  tableScreen.addABang("AdjClose");
  tableScreen.addABang("Low");
  tableScreen.addABang("High");
  tableScreen.addABang("Volume");
  tableScreen.addABang("Date");
  lineGraphScreen.addABang("LiveData");
  lineGraphScreen.addABang("Back");
  liveDataScreen.addABang("Back");
  liveDataScreen.addABang("Go");
  //  graphScreen.addABang("BACK0");
  //  dataScreen.addABang("BACK0");
}
