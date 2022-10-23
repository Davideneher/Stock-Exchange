// Contributors: Dermot O'Brien and David Deneher

class Sliders {
  Range range;
  Sliders() {
    //cp5.addSlider("sliderTicks2")
    //  .setPosition(GRAPHXPOS,GRAPHYPOS+GRAPHYSIZE+20)
    //  .setWidth(400)
    //  .setRange(255,0)
    //  .setValue(128)
    //  .setNumberOfTickMarks(7)
    //  .setSliderMode(Slider.FLEXIBLE)
    //  .setColorTickMark(0);

    range = cp5.addRange("sliderRange")
      .setBroadcast(false) 
      .setPosition(GRAPHXPOS, GRAPHYPOS+GRAPHYSIZE+20)
      .setSize(GRAPHXSIZE, 40)
      .setHandleSize(30)
      .setRange(0, 255)
      .setDecimalPrecision(0)
      //.setRangeValues(50, 100)
      .setBroadcast(true)
      ;
  }
  void hide(){
    range.hide();
  }
  
  void show(){
    range.show();
  }
  
  //void updateRangeValues(int min, int max) {
  // //range.setArrayValue(new float[]{min, max});
  // //range.setArrayValue(1, max);
  // //range.setLowValue(min);
  // //range.setHighValue(max);
  // //range.setMax((float)max);
  // println("setting range valyes in sldeers", min, max);
  // //range.setRangeValues(min, max);
  //}


  void setRange(int min, int max) {
    println("RANGE VALUES", min, max);
    range.setRange(min, max);
    range.setRangeValues(min, max);
    //range.setNumberOfTickMarks(max-min);
  }
}
