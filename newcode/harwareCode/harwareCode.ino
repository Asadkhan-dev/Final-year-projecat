#include <Wire.h>
#include <FirebaseESP32.h>
#include <Adafruit_SSD1306.h>
#include <TinyGPS++.h>
#include <WiFi.h>
#include "OneWireNg_CurrentPlatform.h"
#include "drivers/DSTherm.h"
#include "utils/Placeholder.h"
#include <FS.h>
#include <SPIFFS.h>
#include <WiFiManager.h>
#include <ArduinoJson.h>

#define FIREBASE_HOST "https://esp32-8db74-default-rtdb.firebaseio.com/"
#define FIREBASE_Authorization_key "AIzaSyDnvWWCMfqWDCn0GQE0omrQSL2wqj0aFU4"
#define ESP_DRD_USE_SPIFFS true
#define JSON_CONFIG_FILE "/config.json"

struct location
{
  float lat;
  float lon;
};

struct location loc;

uint32_t chipId = 0;
 String  CurrentDate;

const char* ntpServer = "pool.ntp.org";
const long  gmtOffset_sec = 18000 ;
const int   daylightOffset_sec = 3600;
struct tm timeinfo;
bool shouldSaveConfig = false;

 // Variables to hold data from custom textboxes
int Max_value ;
int Min_value ;
int admin;
int team;
// Define WiFiManager Object
WiFiManager wm;
byte temp;

FirebaseData firebaseData;
FirebaseJson json;
String address;


# define OW_PIN  4
 #if !defined(SINGLE_SENSOR) && !CONFIG_SEARCH_ENABLED
# error "CONFIG_SEARCH_ENABLED is required for non SINGLE_SENSOR setup"
#endif

#if defined(PWR_CTRL_PIN) && !CONFIG_PWR_CTRL_ENABLED
# error "CONFIG_PWR_CTRL_ENABLED is required if PWR_CTRL_PIN is defined"
#endif

#if (CONFIG_MAX_SEARCH_FILTERS > 0)
static_assert(CONFIG_MAX_SEARCH_FILTERS >= DSTherm::SUPPORTED_SLAVES_NUM,
    "CONFIG_MAX_SEARCH_FILTERS too small");
#endif

#ifdef PARASITE_POWER
# define PARASITE_POWER_ARG true
#else
# define PARASITE_POWER_ARG false
#endif

static Placeholder<OneWireNg_CurrentPlatform> ow;


#define SCREEN_WIDTH 128 // OLED display width, in pixels
#define SCREEN_HEIGHT 64 // OLED display height, in pixels
 
//On ESP32: GPIO-21(SDA), GPIO-22(SCL)
#define OLED_RESET -1 //Reset pin # (or -1 if sharing Arduino reset pin)
#define SCREEN_ADDRESS 0x3C //See datasheet for Address
Adafruit_SSD1306 display(SCREEN_WIDTH, SCREEN_HEIGHT, &Wire, OLED_RESET);
// set pin numbers
const int buttonPinRED = 25;
const int buttonPinGREEN = 26;  // the number of the pushbutton 

// variable for storing the pushbutton status 
int buttonStateRED = 0;
int buttonStateGREEN = 0;
bool datasending = false;
bool notrun = false;
bool tripstartbool= false;
bool getsessiondate=true;
String  session;
 
#define RXD2 17
#define TXD2 16

HardwareSerial neogps(1);
 
TinyGPSPlus gps;
bool dead= true;

// in setup function all de component and vairable is initilized
void setup() 
{
  // to start Serial monitor at 115200 buds
  Serial.begin(115200);

  pinMode(buttonPinRED, INPUT);
  pinMode(buttonPinGREEN, INPUT);
  // to initilize  gps module 
  neogps.begin(9600, SERIAL_8N1, RXD2, TXD2);
  // to initilize display
  if(!display.begin(SSD1306_SWITCHCAPVCC, SCREEN_ADDRESS)) {
    Serial.println(F("SSD1306 allocation failed"));
    for(;;);  }

 // clear display and  set Splash Text 
    display.clearDisplay();  
    display.setTextColor(SSD1306_WHITE);
    display.setTextSize(2);
    display.setCursor(50, 3);
    display.print("FYP");
    display.setTextSize(1.8);
    display.setCursor(30, 20);
    display.print("Medical Box");
    display.setTextSize(1.6);
    display.setCursor(30, 35);
    display.print("BSSE-2019-A");
    display.setTextSize(1);
    display.setCursor(20, 50);
    display.print("CU:212,192,152");
    display.display();
    delay(5000);
    display.clearDisplay();
    display.setTextSize(1);
    display.setCursor(5, 35);
    display.print("Please Connect wifi");
    display.display();


 
  // this blow code is to initilize temp sensor
  #ifdef PWR_CTRL_PIN
    new (&ow) OneWireNg_CurrentPlatform(OW_PIN, PWR_CTRL_PIN, false);
   #else
    new (&ow) OneWireNg_CurrentPlatform(OW_PIN, false);
    #endif
 

   //this bool value is used to check is there is any saved wifi is availble 
   bool spiffsSetup = loadConfigFile();
   bool forceConfig= false; 
   if (!spiffsSetup)
   {
     // if there is no saved wifi is availble the system will go to config state using bool
    forceConfig = true;
   }
 
   // Explicitly set WiFi mode
   WiFi.mode(WIFI_STA);
 
   // Reset settings (only for development)
   // should be remove in production enverment
   ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
   
   // wm.resetSettings();
 
   // Set config save notify callback
   wm.setSaveConfigCallback(saveConfigCallback);
 
   // Set callback that gets called when connecting to previous WiFi fails, and enters Access Point mode
   wm.setAPCallback(configModeCallback);
 



   // Custom elements (input feild in config time )
   // Need to convert numerical input to string to display the default value.

    char convertedValue1[3];
    char convertedValue2[3];
    char convertedValue3[7];
    char convertedValue4[7];
    
    sprintf(convertedValue1, "%d", Max_value); 
    sprintf(convertedValue2, "%d", Min_value); 
    sprintf(convertedValue3, "%d", admin); 
    sprintf(convertedValue4, "%d", team); 



   // Text box (Number) - 7 characters maximum
     WiFiManagerParameter Max_valuex("MaxValue", "Set Max Temprature", convertedValue1, 3); 
     WiFiManagerParameter Min_valuex("MinValue", "Set Min Temprature", convertedValue2, 3); 
     WiFiManagerParameter adminx("Admin", "Admin ID", convertedValue3, 7); 
     WiFiManagerParameter teamx("Team", "Team ID", convertedValue4, 7); 
       
    // Add all defined parameters
    wm.addParameter(&adminx);
    wm.addParameter(&teamx);
    wm.addParameter(&Max_valuex);
    wm.addParameter(&Min_valuex);
   

   // Run if we need a configuration
    if (forceConfig)
    {
             if (!wm.startConfigPortal("Madical-Box"))
               {
                 Serial.println("failed to connect and hit timeout");
                 delay(3000);
                 //reset and try again,
                 ESP.restart();
                 delay(5000);
               }
  }
  else
  {
            if (!wm.autoConnect("Madical-Box"))
              {
                Serial.println("failed to connect and hit timeout");
                delay(3000);
                // if we still have not connected restart and try all over again
                ESP.restart();
                delay(5000);
              }
  }



  // Lets deal with the user config values
  //Convert the number value

 //Serial.println(adminx.getValue());

  admin = atoi(adminx.getValue());
  team  = atoi(teamx.getValue());
  
  Max_value = atoi(Max_valuex.getValue());
  Min_value = atoi(Min_valuex.getValue());
  
  //Serial.println(admin);
  //Serial.print(team);

  // Save the custom parameters to FS
    if (shouldSaveConfig)
    {
      saveConfigFile();
    }
  //  Initilize time of the device 
   configTime(gmtOffset_sec, daylightOffset_sec, ntpServer);   
  // firebase Initilization
   Firebase.begin(FIREBASE_HOST,FIREBASE_Authorization_key);
   address= WiFi.macAddress();
    display.clearDisplay();
    display.setTextSize(1);
    display.setCursor(5, 30);
    display.print("Connected:");
    display.setCursor(5, 40);
    display.print(WiFi.SSID());
    display.display();
   // session = timeinfo.tm_hour+":"+timeinfo.tm_min;

   for(int i=0; i<17; i=i+8) {
	  chipId |= ((ESP.getEfuseMac() >> (40 - i)) & 0xff) << i;
	}

  delay(3000);
 
}
 
 // loop is the function that always run with certain delay 

void loop() 
{
     char Date[11]; // Allocate a character array to hold the formatted date string
  sprintf(Date, "%02d-%02d-%04d", timeinfo.tm_mday, timeinfo.tm_mon+1, timeinfo.tm_year+1900);
  String CurrentDate(Date);
    
  

   char timez[6]; // Allocate a character array to hold the formatted time string
  sprintf(timez, "%02d:%02d", timeinfo.tm_hou-1, timeinfo.tm_min);
  String CurrentTime(timez);


   buttonStateRED = digitalRead(buttonPinRED);
   buttonStateGREEN = digitalRead(buttonPinGREEN);
  // check if the pushbutton is pressed.
  // if it is, the buttonState is HIGH
  if (buttonStateGREEN == HIGH && buttonStateRED== LOW ) 
  {
    datasending = true;  
    tripstartbool= true;  
  } 
 else if(buttonStateRED == HIGH && buttonStateGREEN == LOW)
  {
    datasending = false;
    notrun = true;
   // tripstart=false;
  }
  else{
       notrun=false;
      }

  
    if(!getLocalTime(&timeinfo))
    {
    Serial.println("Failed to obtain time");
    return;
    }
  display.clearDisplay();
  display.setTextSize(1); 
  display.setCursor(0, 0);
  display.print("Date:");
  display.setCursor(25, 0);
  display.print(&timeinfo, " %B %d %Y");
   display.setCursor(0, 10);
  display.print("Time:");
  display.setCursor(25, 10);
  display.print(&timeinfo, " %H:%M:%S");
  display.setCursor(20, 30);
  display.setTextSize(2);
  display.print("Temp:");
  if(datasending == true)
   {display.setTextSize(1);
     display.setCursor(20, 52);
     display.print("Trip started");
   }
  display.display();


                                                                                                                            
  DSTherm drv(ow);
  drv.convertTempAll(DSTherm::SCAN_BUS, PARASITE_POWER_ARG);

    Placeholder<DSTherm::Scratchpad> scrpd;

    for (const auto& id: *ow) {
      if (drv.readScratchpad(id, scrpd) == OneWireNg::EC_SUCCESS)
                getTemp(scrpd);
                 }
  // temp updated

  display.setCursor(90, 30);
  display.setTextSize(2);
  display.print(temp);
  display.display();


 boolean newData = false;
  for (unsigned long start = millis(); millis() - start < 1000;)
  {
    while (neogps.available())
    {
      if (gps.encode(neogps.read()))
      {
        newData = true;
      }
    }
  }
    
  //If newData is true
  if(newData == true) //&& timeduration is complet
  {
    newData = false;
    get_latlng();

  }
    if(getsessiondate == true)
   {
     char timez[6]; // Allocate a character array to hold the formatted time string
      sprintf(timez, "%02d:%02d", timeinfo.tm_hour-1, timeinfo.tm_min);
     session =timez;
     getsessiondate=false;

   }

    if(datasending == true)
   {     
     //timeinfo.tm_min%2 == 0 &&  
      if(timeinfo.tm_sec >= 0 && timeinfo.tm_sec <= 10)
  { 
    // String time = String(timeinfo.tm_hour)+":"+ String(timeinfo.tm_min)+":" + String(timeinfo.tm_sec) ;
      FirebaseJson jsonA,jsonB;
      jsonA.add("latitude", loc.lat);
      jsonA.add("Longitude", loc.lon);


      jsonB.add("CurrentTemperature", temp);
      jsonB.add("HighTemperature", Max_value);//
      jsonB.add("LowTemperature", Min_value);// CREATE IF FOR IT TO NOT EXECUTE AGAIN AND AGAIN

      if( temp >= Min_value && temp <=Max_value && dead = true )
      {
       jsonB.add("IsUnderThreshold", true) ;
      }
      else
      {
           jsonB.add("IsUnderThreshold", false);
           dead = false;
      }
    
       //String date = String(timeinfo.tm_mday)+"-"+ String(timeinfo.tm_mon+1)+"-" + String(timeinfo.tm_year+1900) ;  
       String LocAdress =  String(admin)+ "/"  +  String(team) +"/"+ String(chipId)+ "/"+String(CurrentDate)+"/"+String(session)+"/Location";
       String InfoAdress =  String(admin)+ "/"  +  String(team) +"/"+ String(chipId)+ "/"+String(CurrentDate)+"/"+String(session)+"/Info";
      
      Firebase.pushJSON(firebaseData,LocAdress ,jsonA);
      Firebase.setJSON(firebaseData,InfoAdress,jsonB);
      
       if(tripstartbool == true )
      { 
         String timez = String(timeinfo.tm_hour-1)+":"+ String(timeinfo.tm_min);
         String TimingAdress =  String(admin)+ "/"  +  String(team) +"/"+ String(chipId)+ "/"+CurrentDate+"/"+String(session)+"/Timing/Start"; 
        Firebase.set(firebaseData,TimingAdress,CurrentTime);
        tripstartbool = false;
       }


      notrun = false;
   }
   }
   else if(datasending == false && notrun == true )
   { 

     display.setTextSize(1);
     display.setCursor(20, 52);
     display.print("Trip Ended");
     display.display();
      //  String date = String(timeinfo.tm_mday)+"-"+ String(timeinfo.tm_mon+1)+"-" + String(timeinfo.tm_year+1900) ; 
     //  String timez = CurrentTime;
        String TimingAdress =  String(admin)+ "/"  +  String(team) +"/"+ String(chipId)+ "/"+CurrentDate+"/"+String(session)+"/Timing/End"; 
        Firebase.set(firebaseData,TimingAdress,CurrentTime);
       tripstartbool = true;
       Serial.println("data is not sending");

   }
  //delay(500);

}

// custome function to fetch lat long from gps
void get_latlng()
{
   if (gps.location.isValid() == 1 && gps.location.isUpdated())
  {
      if(gps.location.lat()==0&& gps.location.lng()== 0)
      { 

           loc.lat=33.9557749;
           loc.lon=71.4375873;
      }
      else
      {
         loc.lat=gps.location.lat();
         loc.lon=gps.location.lng();
      }
 
   
  }

}

// custome function to fetch data from temperature sensor 

 static void getTemp(const DSTherm::Scratchpad& scrpd)
{
     const uint8_t *scrpd_raw = scrpd.getRaw();

     long tempx = scrpd.getTemp();
     if (tempx < 0) 
     {
        tempx = -tempx;
     }
      
    temp= (tempx / 1000);
 
}

// Custome function to display data on  screen 

// Custome fiile to save data on EROM of ESP
 void saveConfigFile()
// Save Config in JSON format
 {
  Serial.println(F("Saving configuration..."));
  
  // Create a JSON document
  StaticJsonDocument<512> json;
  json["Max_value"] = Max_value;
  json["Min_value"] = Min_value;
  json["Admin_id"] = admin;
  json["Team_id"] = team;
 
  // Open config file
  File configFile = SPIFFS.open(JSON_CONFIG_FILE, "w");
  if (!configFile)
  {
    // Error, file did not open
    Serial.println("failed to open config file for writing");
  }
 
  // Serialize JSON data to write to file
  serializeJsonPretty(json, Serial);
  if (serializeJson(json, configFile) == 0)
  {
    // Error writing file
    Serial.println(F("Failed to write to file"));
  }
  // Close file
  configFile.close();
}
 

//Custome Function to Read data from EROM  
bool loadConfigFile()
// Load existing configuration file
{
  // Uncomment if we need to format filesystem
  // SPIFFS.format();
 
  // Read configuration from FS json
  Serial.println("Mounting File System...");
 
  // May need to make it begin(true) first time you are using SPIFFS
  if (SPIFFS.begin(false) || SPIFFS.begin(true))
  {
    Serial.println("mounted file system");
    if (SPIFFS.exists(JSON_CONFIG_FILE))
    {
      // The file exists, reading and loading
      Serial.println("reading config file");
      File configFile = SPIFFS.open(JSON_CONFIG_FILE, "r");
      if (configFile)
      {
        Serial.println("Opened configuration file");
        StaticJsonDocument<512> json;
        DeserializationError error = deserializeJson(json, configFile);
        serializeJsonPretty(json, Serial);
        if (!error)
        {
          Serial.println("Parsing JSON");
          Max_value = json["Max_value"].as<int>();
          Min_value = json["Min_value"].as<int>();
          admin = json["Admin_id"].as<int>();
          team =  json["Team_id"].as<int>();
          return true;
        }
        else
        {
          // Error loading JSON data
          Serial.println("Failed to load json config");
        }
      }
    }
  }
  else
  {
    // Error mounting file system
    Serial.println("Failed to mount FS");
  }
 
  return false;
}
 
void saveConfigCallback()
// Callback notifying us of the need to save configuration
{
  Serial.println("Should save config");
  shouldSaveConfig = true;
}
 
void configModeCallback(WiFiManager *myWiFiManager)
// Called when config mode launched
{
  Serial.println("Entered Configuration Mode");
 
  Serial.print("Config SSID: ");
  Serial.println(myWiFiManager->getConfigPortalSSID());
 
  Serial.print("Config IP Address: ");
  Serial.println(WiFi.softAPIP());
}

