// Contributors: David Deneher, Dermot O'Brien
ArrayList tickerList;
class List {
  ScrollableList list;
  List(ControlP5 cp5) {

    list = cp5.addScrollableList("listOfTickers")
      .setPosition(0, 0)
      .setSize(120, SCREEN_Y)
      .setItemHeight(40)
      .setBarHeight(10);
    list.plugTo(this);

    //cp5.addBang("clickTrigger")
    //.setPosition(330, 0)
    //.setSize(70, 40);

    list.getCaptionLabel().toUpperCase(true);
    list.getCaptionLabel().set("Tickers");
    //list.getCaptionLabel().setColor(0xffff0000);
    //ArrayList stockData = db.getStockData("");
    //tickerList = stockData;
    //for (int i=0; i<stockData.size(); i++) {
      //ArrayList itemData = (ArrayList) stockData.get(i);
      //String listItemName = itemData.get(0) + " - " + itemData.get(1); 
      //list.addItem(listItemName, i); 
      //list.getItem(listItemName).put("color", new CColor().setBackground(0xffff0000).setBackground(0xffff8800));
    //}
  }
  void updateList(String query) {
    list.clear();
    ArrayList stockData = db.getStockData(query);
    tickerList = stockData;
    for (int i=0; i<stockData.size(); i++) {
      ArrayList itemData = (ArrayList) stockData.get(i);
      String listItemName = itemData.get(0) + " - " + itemData.get(1); 
      list.addItem(listItemName, i); 
      //list.getItem(listItemName).put("color", new CColor().setBackground(0xffff0000).setBackground(0xffff8800));
    }
  }
  void listOfTickers(int index, ArrayList itemData) {
    ticker = cp5.get(ScrollableList.class, "dropdown").getItem(index).get(itemData).toString();
    println("ticker:" + ticker);
  }
  void hide(){
    list.hide();
  }
  void show(){
    list.show();
  }
}
