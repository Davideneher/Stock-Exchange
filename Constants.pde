/***********
CONSTANTS FILE
  | THIS FILE STORES ALL CONSTANTS
  | PLEASE ENSURE A SECTION IS CREATED FOR EACH TYPE OF CONSTANT LIST
*************/
// Contributors: Stephen Cashin, David Deneher, Dermot O'Brien, Desmond Lee

/* Database Constants */
Database db = new Database();
final int SCREEN_X = 1200, SCREEN_Y = 640;
import java.util.*;

/* TextBox Constants */
String inputText; // used to update DB queries if user queries ticker options
PFont font;
PFont tableFont;
PFont tableLabelFont;
PFont tickerFont;

/* Chart Constants */
import controlP5.*;
Charts lineChart;
ControlP5 cp5;
final int GRAPHXPOS = 200, GRAPHYPOS = 100, GRAPHXSIZE = 800, GRAPHYSIZE = 450, GRAPHXRANGE = 0, GRAPHYRANGE = 200;
String chosenTickerName;

import org.gicentre.utils.stat.*; 
BarChart barChart;

/* Dictionary Data Constants */
int amountOfRows;
String tickerName;
ArrayList<Float> FLWSClosingPrices;
ArrayList<ArrayList<String>> FLWSClosingPricesWithDates;
dictionaryData dictionaryData;
float maxClosingValue = 0.00; // max closing price for selected ticker
float minClosingValue = 0.00; // max closing price for selected ticker
int minYearRange = 0;
int maxYearRange = 0;
//Hashtable dictionary;
//float[] dataSet;

/* Widget constants */
Boolean isPressed = false;
TextBox textBox;
Textfield myTextfield;
Sliders chartSlider;
float[] dataSet;
ArrayList<StockLineInfo> originalData;
ArrayList<StockLineInfo> data;
int minSliderValue;
int maxSliderValue;
String dataOnGraph;
List listOfTickers;
String ticker = null;
Bang barChartButton;
Bang lineChartButton;
Bang sliderButton;

final String NASDAQ= "NASDAQ";
final String NYSE = "NYSE";
final String AHH = "AHH";
final String CLOSING = "clear";


/* External StocK API Constants */
ExternalStockAPI stockApi;

/* Table Constants */
Table dataInTable;
ArrayList tableData;
int currentPageOffset;
String sortingOrder = "ASC";
String currentSortingMethod = "id";
final int NUMBER_OF_ROWS = 9;
final int NUMBER_OF_COLUMNS = 10;
final int NUMBER_OF_LOADED_ROWS = 1000;

/* Screen Constants */
final int X_MARGIN = 26;
final int LABEL_MARGIN = 120;
final int SCREEN_HOMEPAGE = 0;
final int SCREEN_TABLE = 4;
final int SCREEN_NASDAQ_TICKERS = 11;
final int SCREEN_NYSE_TICKERS = 12;
final int SCREEN_SELECTED_GRAPH = 2;
final int SCREEN_SELECTED_DATA = 3;
final int NOT_AVAILABLE = -1;
Boolean isHomePage = true;
boolean running = false;
boolean isTableScreen = false;
Boolean isLineGraph = false;
Boolean isLiveData = false;
PImage logo;
PImage background;
PImage back;
PImage logoHappy;
