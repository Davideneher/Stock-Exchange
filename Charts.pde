// Class to draw charts & buttons related to charts
// Contributors: David Deneher, Dermot O'Brien


class Charts {
  Chart myChart;
  float value;
  ControlP5 cp5;
  String dataSet = "test";
  String lastTickerName = "void";
  String arrow;
  color textColor;
  Boolean isBarChart = false;
  int time = 0;
  float newStockPrice = 0.00;
  float minimum = 0;

  // Constructor to make a chart
  // parameters: library, chartname, dataSet
  Charts(ControlP5 cp5)
  {
    this.cp5 = cp5;
    myChart = cp5.addChart(lastTickerName).setPosition(GRAPHXPOS, GRAPHYPOS).setSize(GRAPHXSIZE, GRAPHYSIZE).setRange(0, (int)maxClosingValue).setView(Chart.LINE);
    myChart.getColor().setBackground(color(255, 100));
  }

  // Function to update the chart with the current selected ticker data
  // by Dermot O'Brien

  void updateChart(String tickerName, float[] pricesData, boolean resetRange) {
    if (pricesData == null) {
      text("NO DATA FOR SELECTED TICKER", GRAPHXPOS, GRAPHYPOS);
    } else {
      myChart.remove();
      minClosingValue = 0.00;
      myChart = cp5.addChart(tickerName).setPosition(GRAPHXPOS, GRAPHYPOS).setSize(GRAPHXSIZE, GRAPHYSIZE).setRange(GRAPHXRANGE, (int)maxClosingValue).setView(Chart.LINE);
      myChart.getColor().setBackground(color(255, 100));
      myChart.addDataSet(tickerName);
      myChart.setColors(tickerName, color(17, 1, 93));
      myChart.setData(tickerName, pricesData);
      myChart.plugTo(this);
      lastTickerName = tickerName;
      if (resetRange) {
        chartSlider.setRange(minYearRange, maxYearRange);
      }
    }
  }

  void newLiveChart(String tickerName) {
    myChart.setData(tickerName, new float[30]);
  }
  void updateLiveChart(String tickerName) {
    if (millis() > time + 1000)
    {
      println(stockApi.getLatestStockPrice(tickerName));
      newStockPrice = stockApi.getLatestStockPrice(tickerName);
      myChart.addData(tickerName, newStockPrice);
      time = millis();
    }
    maxClosingValue = stockApi.getMaxLivePrice();
    minimum = maxClosingValue-maxClosingValue/4;
    myChart.setRange(minimum, maxClosingValue);
    // if the dataSet has more than the required data entries, delete the first one on the left
    if (myChart.getDataSet(tickerName).size()>29) {
      myChart.removeData(tickerName, 0);
    }
    drawAxis();
    //range.setRange(min, max);
    //range.setRangeValues(min, max);
  }

  // Function to change the chart to a bar chart style
  // By David Deneher
  void switchToBarChart() {
    myChart.setView(Chart.BAR);
    isBarChart = true;
  }

  // Function to change the chart to a line chart style
  // By David Deneher
  void switchToLineChart() {
    myChart.setView(Chart.LINE);
    isBarChart = false;
  }

  // Function that draws the axes on the graph
  // By David Deneher
  void drawAxis() {
    if (!isLiveData) {
      line(GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE, GRAPHXPOS, GRAPHYPOS);
      line(GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE, GRAPHXPOS+GRAPHXSIZE, GRAPHYPOS+GRAPHYSIZE);

      textSize(10);

      text("$" + nf((maxClosingValue), 0, 2), GRAPHXPOS-38, GRAPHYPOS-3);
      line(GRAPHXPOS-10, GRAPHYPOS, GRAPHXPOS, GRAPHYPOS);
      text("$" + nf((maxClosingValue)-(maxClosingValue)*1/8, 0, 2), GRAPHXPOS-38, (GRAPHYPOS+GRAPHYSIZE*1/8)-3);
      line(GRAPHXPOS-10, GRAPHYPOS+GRAPHYSIZE*1/8, GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE*1/8);
      text("$" + nf((maxClosingValue)-(maxClosingValue)*2/8, 0, 2), GRAPHXPOS-38, (GRAPHYPOS+GRAPHYSIZE*2/8)-3);
      line(GRAPHXPOS-10, GRAPHYPOS+GRAPHYSIZE*2/8, GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE*2/8);
      text("$" + nf((maxClosingValue)-(maxClosingValue)*3/8, 0, 2), GRAPHXPOS-38, (GRAPHYPOS+GRAPHYSIZE*3/8)-3);
      line(GRAPHXPOS-10, GRAPHYPOS+GRAPHYSIZE*3/8, GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE*3/8);
      text("$" + nf((maxClosingValue)-(maxClosingValue)*4/8, 0, 2), GRAPHXPOS-38, (GRAPHYPOS+GRAPHYSIZE*4/8)-3);
      line(GRAPHXPOS-10, GRAPHYPOS+GRAPHYSIZE*4/8, GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE*4/8);
      text("$" + nf((maxClosingValue)-(maxClosingValue)*5/8, 0, 2), GRAPHXPOS-38, (GRAPHYPOS+GRAPHYSIZE*5/8)-3);
      line(GRAPHXPOS-10, GRAPHYPOS+GRAPHYSIZE*5/8, GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE*5/8);
      text("$" + nf((maxClosingValue)-(maxClosingValue)*6/8, 0, 2), GRAPHXPOS-38, (GRAPHYPOS+GRAPHYSIZE*6/8)-3);
      line(GRAPHXPOS-10, GRAPHYPOS+GRAPHYSIZE*6/8, GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE*6/8);
      text("$" + nf((maxClosingValue)-(maxClosingValue)*7/8, 0, 2), GRAPHXPOS-38, (GRAPHYPOS+GRAPHYSIZE*7/8)-3);
      line(GRAPHXPOS-10, GRAPHYPOS+GRAPHYSIZE*7/8, GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE*7/8);
    } else {
      textSize(20);
      text("LIVE Data for stock " + lastTickerName, GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE);
    }
  }
  // Function that displays value of data point when hovering over graph
  // by David Deneher, Dermot O'Brien
  void findValue(String tickerName) {
    textSize(80);
    textFont(tickerFont);
    text(tickerName, GRAPHXPOS, GRAPHYPOS+70);

    if (myChart.getDataSet(tickerName).size() > 0) {
      if (cp5.isMouseOver( myChart )) {
        int s = myChart.getDataSet( tickerName ).size();
        int n = int( constrain( map( myChart.getPointer().x(), 0, myChart.getWidth(), 0, s ), 0, s ) ) ;
        float value =  myChart.getData( tickerName, n ).getValue();
        float previousValue = 0;
        if (n > 0) {
          previousValue = myChart.getData( tickerName, n-1).getValue();
        }

        fill(0);
        if (mouseX>GRAPHXPOS && mouseX<GRAPHXPOS+GRAPHXSIZE) {
          if (!isBarChart && !isLiveData) {
            //line(GRAPHXPOS, mouseY, GRAPHXPOS+GRAPHXSIZE, mouseY);
            line(GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE-value*GRAPHYSIZE/(maxClosingValue), GRAPHXPOS+GRAPHXSIZE, GRAPHYPOS+GRAPHYSIZE-value*GRAPHYSIZE/(maxClosingValue));
            line(mouseX-50, GRAPHYPOS + 30, mouseX+50, GRAPHYPOS + 30);

            ellipse(mouseX, GRAPHYPOS+GRAPHYSIZE-value*GRAPHYSIZE/(maxClosingValue), 10, 10);
          }
          line(mouseX, GRAPHYPOS, mouseX, GRAPHYPOS+GRAPHYSIZE);
        }

        textSize(20);
        if (!isLiveData) {
          String date = dictionaryData.getDateByIndex(n, data);
          text(date, mouseX - 50, GRAPHYPOS + 30);
        }
        float changeInValue = value - previousValue;
        float percentageChange = (changeInValue/previousValue *100);

        if (value > previousValue) {
          arrow = "\u2191";
          textColor = color(0, 255, 0);
        } else if (value < previousValue) {
          arrow = "\u2193";
          textColor = color(255, 0, 0);
        } else {
          arrow = "";
          textColor = color(0);
        }
        textSize(40);
        text(arrow + "Stock Value: $"+value, GRAPHXPOS +160, GRAPHYPOS-30);
        textSize(20);
        fill(textColor);
        text("Daily Change: $" + nf(changeInValue, 0, 2) + " Percentage Change: " + nf(percentageChange, 0, 2) + "%", GRAPHXPOS +160, GRAPHYPOS);
      }
    } else {
      textSize(20);
      text("NO DATA FOR SELECTED TICKER", GRAPHXPOS, GRAPHYPOS);
    }
  }

  void hide() {
    myChart.hide();
  }
  void show() {
    myChart.show();
  }
}
