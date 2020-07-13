import paho.mqtt.publish as publish
import paho.mqtt.client as mqtt
import time
import mysql.connector
import datetime

mydb = mysql.connector.connect(
    host="192.168.1.73",
    # host="192.168.43.254",
    user="user",
    password="password",
    database="db_minisps"
)
print("Connected to db_minisps...")
cursor = mydb.cursor()


# cursor.execute("SELECT status FROM parkslot_list_list WHERE slot = 'S001'")
# status_slot1 = cursor.fetchone()

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

    if (perintah == "lock" and idslot != "" and tujuan == "pi"):
        # write database lock
        cursor.execute("UPDATE parkslot SET locked = 1 WHERE slot = '"+slot+"'")
        client.publish(topic = "sps", payload = "pi_slave_lock_"+idslot)
        mydb.commit()

    if (perintah == "unlock" and idslot != "" and tujuan == "pi"):
        # write database lock
        cursor.execute("UPDATE parkslot SET locked = 0 WHERE slot = '"+slot+"'")
        client.publish(topic = "sps", payload = "pi_slave_unlock_"+idslot)
        mydb.commit()

    if (perintah == "checkstats"):
        # check status database lock
        cursor.execute("SELECT locked FROM parkslot WHERE slot = '"+slot+"'")
        lock_slot = cursor.fetchone()
        if(lock_slot[0] == 1):
            client.publish(topic = "sps", payload = "pi_slave_lock_"+idslot)
        else:
            client.publish(topic = "sps", payload = "pi_slave_unlock_"+idslot)

    if (perintah == "occupied" and idslot != "" and tujuan == "pi"):
        cursor.execute("UPDATE parkslot SET status = 'yes' WHERE slot = '"+slot+"'")
        client.publish(topic = "sps", payload = "pi_server_occupied_"+idslot)
        mydb.commit()

    if (perintah == "unoccupied" and idslot != "" and tujuan == "pi"):
        cursor.execute("UPDATE parkslot SET status = 'no' WHERE slot = '"+slot+"'")
        client.publish(topic = "sps", payload = "pi_server_unoccupied_"+idslot)
        mydb.commit()

broker_address = "192.168.1.73"
# broker_address = "192.168.43.254"
broker_portno = 1883
client = mqtt.Client()

client.on_message=on_message
client.connect(broker_address, broker_portno)
client.subscribe("sps")
client.publish(topic = "sps", payload = "pi_server_dbsync_0")
# client.loop_stop()
client.loop_forever()
