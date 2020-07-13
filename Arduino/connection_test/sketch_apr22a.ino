#include "ESP8266WiFi.h"

const char* ssid = "fsociety"; //Enter SSID
const char* password = "hahahaha"; //Enter Password

void setup(void)
{ 
  Serial.begin(9600);
  // Connect to WiFi
  WiFi.begin(ssid, password);
  while (WiFi.status() != WL_CONNECTED) 
  {
     delay(500);
     Serial.print("*");
  }
  
  Serial.println("");
  Serial.println("WiFi connection Successful");
  Serial.print("The IP Address of ESP8266 Module is: ");
  Serial.print(WiFi.localIP());// Print the IP address
}

void loop() 
{
  // EMPTY
}
