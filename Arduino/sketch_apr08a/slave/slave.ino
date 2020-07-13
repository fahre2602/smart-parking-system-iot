#include <EEPROM.h>
#include <ESP8266WiFi.h>
#include <PubSubClient.h>
#include <Wire.h>
#include <Ethernet.h>

int trigPin1 = D5;
int echoPin1 = D6;
int trigPin2 = D7;
int echoPin2 = D8;
int ledR = D4;
int ledG = D3;
int ledB = D2;
int buzzer = D1;
int kunci = 0;
int statechanged = 0;
char* state = "unoccupied";
char* statebaru = "unoccupied";
long duration1, duration2;
int distance1, distance2;
// Connect to the WiFi
//const char* ssid = "fsociety";
//const char* password = "hahahaha";
//const char* mqtt_server = "192.168.43.254";
const char* ssid = "INDIHOME_MBMC2";
const char* password = "reza2357";
const char* mqtt_server = "192.168.1.73";


WiFiClient espClient;
PubSubClient client(espClient);
 
void callback(char* topic, byte* payload, unsigned int length) {
  String msgInput = "";
 Serial.print("Message arrived [");
 Serial.print(topic);
 Serial.print("] ");
 for (int i=0;i<length;i++) {
  msgInput += (char)payload[i];
 }
  Serial.print(msgInput);
 for (int i=0;i<length;i++) {
  char receivedChar = (char)payload[i];
 }
  if (msgInput == "pi_slave_lock_9"){
    setColor(255, 0, 0); // Red Color
    kunci = 1;
  }
  if (msgInput == "pi_slave_unlock_9"){      
      setColor(0, 255, 0); // Green Color
      kunci = 0;
  }
  Serial.println();
}

void setColor(int redValue, int greenValue, int blueValue) {
  analogWrite(ledR, redValue);
  analogWrite(ledG, greenValue);
  analogWrite(ledB, blueValue);
}

void reconnect() {
 // Loop until we're reconnected
 while (!client.connected()) {
 Serial.print("Attempting MQTT connection...");
 // Attempt to connect
 if (client.connect("ESP8266 Client9")) {
  Serial.println("connected");
  // ... and subscribe to topic
  client.subscribe("sps");
  delay(1000);
  client.publish("sps", "slave_pi_checkstats_9");
 } else {
  Serial.print("failed, rc=");
  Serial.print(client.state());
  Serial.println(" try again in 5 seconds");
  // Wait 5 seconds before retrying
  delay(5000);
  }
 }
}

void locked(){
  digitalWrite(trigPin1, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin1, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin1, LOW);
  duration1 = pulseIn(echoPin1, HIGH);
  distance1 = (duration1/2) / 29.1;

  digitalWrite(trigPin2, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin2, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin2, LOW);
  duration2 = pulseIn(echoPin2, HIGH);
  distance2 = (duration2/2) / 29.1;
  
  if (distance1 < 10 && distance2 < 10)
  {
    statebaru = "occupied";
    statechanged = isStatechange(state, statebaru);
    if(statechanged == 1){
      client.publish("sps", "slave_pi_occupied_9");
    }
    state = statebaru;
    digitalWrite(buzzer,HIGH);
  }
  else {
    statebaru = "unoccupied";
    statechanged = isStatechange(state, statebaru);
    if(statechanged == 1){
      client.publish("sps", "slave_pi_unoccupied_9");
    }
    state = statebaru;
    digitalWrite(buzzer,LOW);
    }
  Serial.print("Distance 1 = ");
  Serial.print(distance1);
  Serial.println(" cm");
  Serial.print("Distance 2 = ");
  Serial.print(distance2);
  Serial.println(" cm");
  delay(500);
}

void unlocked(){
  digitalWrite(trigPin1, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin1, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin1, LOW);
  duration1 = pulseIn(echoPin1, HIGH);
  distance1 = (duration1/2) / 29.1;

  digitalWrite(trigPin2, LOW);
  delayMicroseconds(2);
  digitalWrite(trigPin2, HIGH);
  delayMicroseconds(10);
  digitalWrite(trigPin2, LOW);
  duration2 = pulseIn(echoPin2, HIGH);
  distance2 = (duration2/2) / 29.1;
  
  if (distance1 < 10 && distance2 < 10)
  {
    statebaru = "occupied";
    statechanged = isStatechange(state, statebaru);
    if(statechanged == 1){
      client.publish("sps", "slave_pi_occupied_9");
    }
    state = statebaru;
  }
  else {
    statebaru = "unoccupied";
    statechanged = isStatechange(state, statebaru);
    if(statechanged == 1){
      client.publish("sps", "slave_pi_unoccupied_9");
    }
    state = statebaru;
   }
  Serial.print("Distance 1 = ");
  Serial.print(distance1);
  Serial.println(" cm");
  Serial.print("Distance 2 = ");
  Serial.print(distance2);
  Serial.println(" cm");
  delay(500);
}

int isStatechange(char* state, char* statebaru){
  if(state != statebaru){
    return 1;
  }
  else{
    return 0;
  }
}

void setup()
{
  Serial.begin (9600);
  pinMode(trigPin1, OUTPUT);
  pinMode(echoPin1, INPUT);
  pinMode(trigPin2, OUTPUT);
  pinMode(echoPin2, INPUT);
  pinMode(ledR, OUTPUT);
  pinMode(ledG, OUTPUT);
  pinMode(ledB, OUTPUT);
  pinMode(buzzer, OUTPUT);
  client.setServer(mqtt_server, 1883);
  client.setCallback(callback);
}

void loop()
{ 
  if (!client.connected()) {
  reconnect();
  }

  if (kunci == 1){
    locked();
  }
  
  else {
    unlocked();
  }
  client.loop();
}
