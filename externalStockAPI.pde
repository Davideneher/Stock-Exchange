
// Contributors: Dermot O'Brien
class ExternalStockAPI{
  final boolean IS_SANDBOX = false;
  final String SANDBOX_API_TOKEN = "Tpk_aabe14e9cf6f49f18fe5d5f009a885a7";
  final String LIVE_API_TOKEN = "pk_2fb2cf3d42c94ed2937e106057e1d499";
  float maxLivePrice = 0.00;
 
 String generateApiUrl(String tickerName) {
   String output = "";
  if(IS_SANDBOX) {
   output = "https://sandbox.iexapis.com/stable/stock/" + tickerName + "/quote/latestPrice?token=" + SANDBOX_API_TOKEN;  
  } else {
   output = "https://cloud.iexapis.com/stable/stock/" + tickerName + "/quote/latestPrice?token=" + LIVE_API_TOKEN; 
  }
  return output;
 }
 
 float getMaxLivePrice() {
  return maxLivePrice + maxLivePrice/10; 
 }
 
 
 
 float getLatestStockPrice(String tickerName) {
   float output = 0.00;
   try {
    output = Float.parseFloat(stockApi.getUrl(generateApiUrl(tickerName))[0]);
    if(output > maxLivePrice) {
     maxLivePrice = output; 
    }
   } catch(Exception e) {
     println("Error in #getLatestStockPrice: ", e);
   }
   return output;
 }
 
 String[] getUrl(String url) {
  return loadStrings(url);
 }
}
