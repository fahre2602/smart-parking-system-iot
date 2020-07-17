# Smart-Parking-System-IoT
Smart Parking System is an integrated system which helps us managing public parking spot by giving real time data.
This system was built for completion of my thesis.

## Short Explanation
Smart Parking System has 3 subsystem :
- Web Application
The web application was built using Python with Django, with additional code in PHP for the API.

- Mobile Application
The mobile application was built in Android.

- IoT Devices
There are 2 device used, Raspberry Pi 3 as Master and ESP8266 Wifi Module as Slave.

Smart Parking System uses IoT devices to capture real time data of a parking space (either the parking space is being used, empty or booked) and save them as message via MQTT. The web app and mobile app will then acts according to those messages. User can book a parking space by using the mobile app. The mobile app sends data to web app's API, and those data will be processed and message will be send by using MQTT to IoT Devices.


