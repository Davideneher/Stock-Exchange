// Contributors: Desmond Lee and David Deneher
import controlP5.*;
Bang chooseLineGraph;
Bang chooseLiveData;
Bang goBack;
Bang tableTest;
Bang nextPage;
Bang previousPage;
Bang sortByTicker;
Bang sortById;
Bang sortByOpen;
Bang sortByClose;
Bang sortByAdjClose;
Bang sortByLow;
Bang sortByHigh;
Bang sortByVolume;
Bang sortByDate;

Screen homepageScreen;
Screen lineGraphScreen;
Screen liveDataScreen;
Screen graphScreen;
Screen dataScreen;
Screen tableScreen;
int currentScreen = NOT_AVAILABLE;
int previousScreen = NOT_AVAILABLE;
class Screen{
    ArrayList<String> BangList;
    int screenIndex;
    Screen(int scrnInd){
        BangList = new ArrayList();
        screenIndex = scrnInd;
    }

    void display(){  
        currentScreen = screenIndex;
        println("\npre:" + previousScreen + "\ncur: " + currentScreen);
        background(255);
        chooseLineGraph.hide();      
        chooseLiveData.hide();
        goBack.hide();
        if(!BangList.isEmpty()){
            for(int i = 0; i<BangList.size(); i++)
            {
             cp5.getController(BangList.get(i)).show();
            }
        }
    }

    void addABang(String BangName){
        BangList.add(BangName);
    }
}
