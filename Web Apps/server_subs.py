import paho.mqtt.publish as publish
import paho.mqtt.client as mqtt
import time
import mysql.connector
import datetime

mydb = mysql.connector.connect(
    host="localhost",
    # host="192.168.43.254",
    user="root",
    password="",
    database="db_sps"
)
print("Connected to db_sps...")
cursor = mydb.cursor()


def on_message(client, userdata, message):
    print("message received")

    pesan = str(message.payload.decode("utf-8"))
    sumber,tujuan,perintah,idslot = pesan.split("_")
    slot = ""
    if(idslot == "1"):
        slot = "S001"
    elif(idslot == "2"):
        slot = "S002"
    elif(idslot == "3"):
        slot = "S003"
    elif(idslot == "4"):
        slot = "S004"
    elif(idslot == "5"):
        slot = "S005"
    elif(idslot == "6"):
        slot = "S006"
    elif(idslot == "7"):
        slot = "S007"
    elif(idslot == "8"):
        slot = "S008"
    elif(idslot == "9"):
        slot = "S009"
    elif(idslot == "10"):
        slot = "S010"
    else:
        slot = ""

    print(sumber + " -> " + tujuan + " = " + perintah + " " + idslot)

    if (perintah == "dbsync" and tujuan == "server"):
        cursor.execute("SELECT * FROM parkslot_list_list")
        records = cursor.fetchall()
        for row in records:
            slot = str(row[0])
            if row[3] == 0 :
                client.publish(topic = "sps", payload = "server_pi_unlock_"+slot)
                if row[2] == "yes":
                    client.publish(topic = "sps", payload = "server_pi_occupied_"+slot)
                else:
                    client.publish(topic = "sps", payload = "server_pi_unoccupied_"+slot)
            else:
                client.publish(topic = "sps", payload = "server_pi_lock_"+slot)
                if row[2] == "yes":
                    client.publish(topic = "sps", payload = "server_pi_occupied_"+slot)
                else:
                    client.publish(topic = "sps", payload = "server_pi_unoccupied_"+slot)

    if (perintah == "occupied" and idslot != "" and tujuan == "server"):
        now = datetime.datetime.now()
        formatted_date = now.strftime('%Y-%m-%d %H:%M:%S')
        status_occupied = "Occupied"

        cursor.execute("UPDATE parkslot_list_list SET status = 'yes' WHERE slot = '"+slot+"'")
        cursor.execute("INSERT INTO parkslot_list_historyoccupied (tanggal, slot, status) VALUES(%s, %s, %s)", (formatted_date, slot, status_occupied))
        mydb.commit()

    if (perintah == "unoccupied" and idslot != "" and tujuan == "server"):
        now = datetime.datetime.now()
        formatted_date = now.strftime('%Y-%m-%d %H:%M:%S')
        status_unoccupied = "Unoccupied"

        cursor.execute("UPDATE parkslot_list_list SET status = 'no' WHERE slot = '"+slot+"'")
        cursor.execute("INSERT INTO parkslot_list_historyoccupied (tanggal, slot, status) VALUES(%s, %s, %s)", (formatted_date, slot, status_unoccupied))
        mydb.commit()

broker_address = "192.168.1.73"
# broker_address = "192.168.43.254"
broker_portno = 1883
client = mqtt.Client("serverpy")

client.on_message=on_message
client.connect(broker_address, broker_portno)
client.subscribe("sps")
# client.loop_stop()
client.loop_forever()
