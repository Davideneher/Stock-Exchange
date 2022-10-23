// Class adds the main text box in the progamme and adds the line chart based on the imput
// Contributors: David Deneher, Dermot O'Brien
class TextBox {
  float[] dataSet = new float[0];
  String myText;
  String lastInputText;
  
  TextBox() {
    listOfTickers = new List(cp5);
    
    PFont font = createFont("arial", 20);
    myTextfield = cp5.addTextfield("input")
      .setPosition(130, 0)
      .setSize(200, 40)
      .setFont(font)
      .setFocus(true);
      //.setColorLabel(#0799DB);
      //.setColor(color(255, 0, 0));

    //cp5.addBang("buttonTrigger")
    //.setPosition(330, 0)
    //.setSize(70, 40);
  }

  // Function which draws the widgets
  void draw() {

    inputText = myTextfield.getText();
    //println("SLIDER " + inputText);
    
    //println("inputText " + inputText + " -- lastInputText " + lastInputText); 
    if(!inputText.equals(lastInputText)) {
      listOfTickers.updateList(inputText); 
    }
    //text(inputText, 50, 200);
    lastInputText = inputText;
   
  }
  void hide(){
    myTextfield.hide();
  }
  
  void show(){
    myTextfield.show();
  }

}
